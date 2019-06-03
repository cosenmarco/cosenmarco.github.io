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
    caption = "Detail of the 30 Volt 30 LEDs display prototype breadboard. Please excuse the crudity of the wiring 😉"
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
so I'll assume the reader is familiar with this application as well. If not please read the 
post before continuing.

## Merging the two applications into one

The high voltage supply application shows that we need to let the LM3914V operate their
output drivers in the saturation region and have the leds current set by the R2 resistor
based on the formula

$$ I_{LED} = { {V_{CC} - 2.8V} \over R2 } $$

so let's say we desire to have a current of 12mA.

$$ R2 = { {V_{CC} - 2.8V} \over I_{LED} } = { 30V - 2.8V \over 0.012 } = 2260\Omega \approx 2.2K\Omega $$

and we need to make sure that we set the current flowing out of the voltage reference to ca. 20mA
to give us a margin for guaranteeing the region of operation of the LM3914's drivers. With this 
we can calculate the values for the three V<sub>ref</sub> resistors using Ohm's law and
the multiplication factor of ca. 10 which the LM3914 uses to calculate the I<sub>LED</sub> from I<sub>ref</sub>:

1. $ R_{ref1} = (1.25V / 0.020A) * 10 = 620\Omega $
2. $ R_{ref2} = (2.50V / 0.020A) * 10 = 1240\Omega \approx 1.2K\Omega $
3. $ R_{ref3} = (3.75V / 0.020A) * 10 = 1860\Omega \approx 1.8K\Omega $

With that sorted out, we need to make sure the supply voltage is adequately 
high to provide enough juice to the last LM3914 for it to provide a V<sub>ref</sub>
of 3.75V.

I struggled a bit on this, thinking I had to adjust somehow resistor values or using
some fancy technique to accomplish that but after the analysis of the 
[high voltage supply application](/electronics/lm3914_operating_with_high_voltage_supply/)
the answer became clear and easy: I just had to connect the V<sub>ref3</sub> to the base
of the PNP so that basically the V<sub>+</sub> would become 3.75V + V<sub>EB</sub> + V<sub>LED</sub>
which is basically as high as 6.5V using a LED with a somewhat high voltage drop.

Last but not least I wanted (as Paul envisioned for his leak detector) the LED which
is part of the V<sub>+</sub> regulation, act as an "overflow" indicator for the display
basically being dark when there's at least one led ON in the display and lit when
there's no led ON. This requirement helps setting the value of resistor R1.

Say we want a current of... TODO