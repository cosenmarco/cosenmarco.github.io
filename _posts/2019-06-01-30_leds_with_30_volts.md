---
title: "30 LEDs with 30 Volts"
date: 2019-06-03 23:07:05 +0200
categories: electronics
tags: 
    - electronics
    - UI
    - LED 
    - display 
    - LM3914
---

I'm currently (quite lazily) realizing a medium-ish size project which aims to bring
several of [Mr. Carlson](https://www.patreon.com/MrCarlsonsLab)'s 
capacitor testing devices into one single device to
speed up the testing process by not having to move the cap around across
several different pieces of equipment (each of them also requiring power supply, casing, etc...).

Mr. Carlson (Paul) has designed and realized a leakage detector and a tester for detecting the 
which pole is connected to the external foil in non polarized poly type caps.

Both of Paul's projects use for the User Interface a 10 LED dot-type meter based on the
[LM3914V](https://www.ti.com/lit/ds/symlink/lm3914.pdf)
IC using a slightly modified version (for 30V supply) of the
"Operating with a High Voltage Supply" application from the datasheet.

It's also my intention to add an ESR meter (more on that in some other post),
a cap discharger and package that nicely into a project box with a linear power supply.

To be able to read the ESR with some
degree of accuracy though, I want to increase the resolution of the display 
by adding more LEDs to the scale (and scale the signal accordingly at the display input).

This post is essentially about how to realize a 30 LED display meter which is powered
by a 30V power supply by combining and extending the two applications 
"Operating with a High Voltage Supply" and "20-Segment Meter with Mode Switch" from the datasheet.

{% include figure 
    image_path = "/assets/images/30-volt-30-led/30-volt-30-led-prototype-breadboard.jpg" 
    caption = "One of the 30 Volt 30 LEDs display prototypes. Please excuse the crudity of the wiring 😉"
%}


## Understanding the applications in the datasheet

### 20-LED dot-mode display

Before moving on to the final circuit we may want to break down the examples provided in the 
datasheet to better understand the final design. Let's start with the easy one: "20-Segment Meter with Mode Switch"

In the schematic below (Fig. 1) I removed the switch between bar / dot mode to make it more readable.

{% include figure 
    image_path = "/assets/images/30-volt-30-led/20-segment-meter-dot-mode.svg" 
    caption = "Fig 1 - Classic LM3914V 20-segment dot mode display"
%}

The way dot mode carry is implemented, is described quite well in the datasheet so I'll not talk about that here.

Like shown in Fig. 2, the way the two devices divide the input range between the two of them is also 
pretty easy to understand:
the two internal voltage references are basically connected in series like in the diagram below and the two 
internal resistor dividers connected between RLO and RHI for each of the two devices will have the ranges
0V 🠒 1.2V assigned to the first LM3914V and the range 1.2V 🠒 2.4V assigned to the second one.
Additionally the resistors R1 and R3 would set the I<sub>L</sub> ≅ 10mA.

{% include figure 
    image_path = "/assets/images/30-volt-30-led/20-segment-vref.svg" 
    caption = "Fig 2 - Voltage references arrangement in the 20-segment dot mode display"
%}

How to extend this to 30 LEDs is at this point fairly straightforward: you would need to add
obviously another LM3914V, replicate the dot carry wiring, wind up the 
third voltage reference in series with the second (so that the third driver gets the portion 2.4V 🠒 3.6V)
and provide a resistor with value 3.6K to set the I<sub>L</sub> current also to 10mA. So far so good.

### Operating with a high voltage supply

I made [a post](/electronics/lm3914_operating_with_high_voltage_supply/) about this application
so I'll assume the reader is familiar with this application as well. If not please read the post before continuing.

## Merging the two applications into one

The high voltage supply application shows that we need to let the LM3914V operate their
output drivers in the saturation region and have the leds current set by the R2 resistor
based on the formula

$$ I_{LED} = { {V_{CC} - 2.8V} \over R2 } $$

so let's say we desire to have a current of 12mA.

$$ R2 = { {V_{CC} - 2.8V} \over I_{LED} } = { 30V - 2.8V \over 0.012 } = 2260\Omega \approx 2.2K\Omega $$

The required power handling capabilities for R2 are given by

$$ P_{R2} = I_{R2}^2 \times R2 = 144\mu A^2 \times 2200\Omega = 0.316W < 1/2W $$

Also we need to make sure that we set the current flowing out of the
voltage reference to ca. 2mA (corresponding to a desired I<sub>LED</sub>
current of 20mA) to give us a margin for guaranteeing the region of
operation of the LM3914's drivers.

With this specification we can calculate the values for the three
V<sub>ref</sub> resistors using Ohm's law:

1. $ R_{ref1} = (1.25V / 0.002A) = 620\Omega  \approx 680\Omega $
2. $ R_{ref2} = (2.50V / 0.002A) = 1240\Omega \approx 1.2K\Omega $
3. $ R_{ref3} = (3.75V / 0.002A) = 1860\Omega \approx 1.8K\Omega $

(yes, although I should have approximated down to 560Ω, 
680Ω is also fine)

With that sorted out, we need to make sure the supply voltage 
is adequately high to provide enough juice to the last LM3914
for it to provide a V<sub>ref</sub> of 3.75V.

I struggled a bit on this, thinking I had to adjust somehow resistor 
values or using some fancy technique to accomplish that but after 
the analysis of the high voltage supply application, the answer 
became clear and easy: 
I just had to connect the V<sub>ref3</sub> to the base of the PNP so 
that basically the V<sub>+</sub> would become 3.75V + V<sub>EB</sub> +
V<sub>LED</sub> which is basically as high as 6.1V.

Last but not least I wanted (as Paul envisioned for his leak detector) the LED which
is part of the V<sub>+</sub> regulation, act as an "overflow" indicator for the display
basically being dark when there's at least one display LED ON and lit when
all display LEDs are OFF. This requirement helps setting the value of resistor R1.

Let's say we're using a LED which looks almost completely dark at 0.5mA with a drop of 1.7V
and it looks completely lit at 10mA with a drop of 2.1V.

This gives us the following calculation for R1 but not so easily... in fact 
we must supply current to 3 LM3914. At any given time one of those devices
will have one LED turned on and the other two will have no LED turned on.
Looking at the experimental results of the previous build I'd consider
10mA for the device which has the LED on and 9.7mA for the one which 
has all LEDs off.

$$ 30V = V_{R1} + V_+ \Rightarrow V_{R1} = 30V - 6.1V = 23.9V $$

$$ I_{R1} = I_{LED} + I_{LM3914} \\
= 0.5mA + 10mA + 9.7mA + 9.7mA = 29.9mA $$

$$ R1 = V_{R1} / I_{R1} = 23.9V / 29.9mA = 799\Omega \approx 820\Omega $$

The required power handling capabilities for R1 are given by

$$ P_{R1} = I_{R1}^2 \times R1 = 894\mu A^2 \times 820\Omega = 0.733W < 1 W $$

The following Fig. 3 is the circuit diagram for the prototype I'm going to build.

{% include figure 
    image_path = "/assets/images/30-volt-30-led/30-volt-30-led-proto.svg" 
    caption = "Fig 3 - Ciurcuit I'm going to build on the prototype board"
%}

## Building and testing

### Carry issue

The prototype worked almost fine on the first attempt but there was
an issue which I demo in the video below

<iframe src="https://player.vimeo.com/video/342413220" width="640" height="360" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>

You can see that when the input signal climbs, the carry function
works fine but when the signal falls, instead of turning on the
last LED of the first LM3914, it turns all the LEDs off (thus
causing the green LED to go on) and then jumps down to the 8th or
7th LED. Same story for the 2nd LM3914.

After some reading frmo the [datasheet](https://www.ti.com/lit/ds/symlink/lm3914.pdf) about the "DOT MODE CARRY" which says

> An auxiliary current source at pin 1 keeps at least 100μA flowing
> through LED No. 11 even if the input voltage
> rises high enough to extinguish the LED. This ensures that pin 11 of
> LM3914 No. 1 is held low enough to force
> LED No. 10 off when any higher LED is illuminated. While 100μA does not
> normally produce significant LED
> illumination, it may be noticeable when using high-efficiency LEDs in a
> dark environment. If this is bothersome,
> the simple cure is to shunt LED No. 11 with a 10k resistor. The 1V IR
> drop is more than the 900mV worst case
> required to hold off LED No. 10 yet small enough that LED No. 11 does
> not conduct significantly.

Note: in the citation above I replaced pin n.9 with 11 to match 
with the LM3914V which is the one I'm using for this project.

According to the explanation and the diagram in "Figure 14. Block 
Diagram of Mode Pin Description" I cannot explain what's going on
there. It seems to me there is some more trickery going on[^1] but 
adding a 10K resistor across LED 11 (and LED 21) fixes the issue as
can be seen in video below.

<iframe src="https://player.vimeo.com/video/342413244" width="640" height="360" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>

[^1]:
    Perhaps there is some hysteresis in comparator C2 and the type
    of LEDs I'm using doesn't make a clear cut between the two states of
    C2 making up for the issue.

### Measurements

Here a few measurements from the final prototype with the following notes
1. I didn't have the resistors with the right values and wattage, so I used two potentiometers
   for R1 and R2
2. I didn't have a [2N2905](https://www.onsemi.com/pub/Collateral/2N2905A-D.PDF) but rather
   a Panasonic [2SA1123](https://cdn-reichelt.de/documents/datenblatt/A100/2SA1123_MAT.pdf).
3. D1 is a [1N4007](https://www.vishay.com/docs/88503/1n4001.pdf). Not a big deal.
4. The LM3914V is not a TI original but rather some clone.
5. Measurements were taken with my [Solartron Schlumberge 7150plus](https://holzleitner.com/el/solartron-7150/index-en.html)
   which is in good working order, as far as I can tell, but not calibrated.

|     Variable        | Measured          | Calculated           |
|:--------------------|:------------------|:---------------------|
| V<sub>+</sub>       | 6.1944V           | 6.1V                 |
| V<sub>ref1</sub>    | 1.2500V           | 1.25V                |
| V<sub>ref2</sub>    | 2.4992V           | 2.50V                |
| V<sub>ref3</sub>    | 3.7461V           | 3.75V                |
| I<sub>LED</sub>     | 12.00mA           | 12mA (spec)          |
| I<sub>R1</sub>      | 30.03mA           | 29.9mA               |
| I<sub>D1</sub>OFF   | 0.91mA            | 0.5mA (spec)         |
| I<sub>D1</sub>ON    | 10.49mA           | N/A                  |
| I<sub>LM3914</sub>  | 29.19mA           | 29.4mA (assumption)  |

Here as well I'm pretty happy about how measurements turned out to 
be compared to calculated or assumed values.

With 0.91mA through D1 I can see the LED is barely emitting light
and this is fine for that type of LED. If that were a high efficiency
LED, then perhaps I would have had to change R1 in order to have it
reasonably dim when it had to look off.

I'm thinking that a future build of this circuit should have a 
trimmer instead of a fixed value for R1 so that one can set the
brightness of D1 when it's on the off setting still keeping a
correct current consumption of the LM3914's.

Also R1 is getting pretty warm so I would recommend to have something
like a fixed resistor of maybe 720Ω (1W) in series with a 200Ω trimmer
also capable of dissipating at least 1W.