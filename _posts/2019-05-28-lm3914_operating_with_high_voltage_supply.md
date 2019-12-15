---
title: "Operating the LM3914 with a high voltage supply"
date: 2019-05-28 00:34:05 +0200
categories: electronics
tags: 
    - electronics
    - UI
    - LED
    - display
    - LM3914
---

This post is about reverse-engineering the application "Operating with a High Voltage Supply"
application from the [LM3914V datasheet](https://www.ti.com/lit/ds/symlink/lm3914.pdf).

In such application, the LM3914 can be operated using supplies much higher than the 
absolute maximum supply (25V) supported out of the box by the IC. The example application
is designed to operate at 48V but it can be easily adjusted to higher or lower voltages.
The only limitation is that this application allows to operate the display only in dot mode.

{% include figure 
    image_path = "/assets/images/lm3914-high-voltage-supply/lm3914-high-voltage-application.svg" 
    caption = "Fig. 1 - Operating the LM3914 with a high voltage supply"
%}

I must say I "cheated" and built the circuit before actually analyzing it but this has
proven beneficial because it suggested me the easiest path to understand how it's 
supposed to work on paper.

The proposed approach here is to analyze the DC operating point of the circuit in 2 cases:
1. D1 is forward biased (aka conducting or, simply, on)
2. D1 is reverse biased (aka not conducting or, simply, off)

## D1 off case

For D1 to be off we must be under the hypothesis that V<sub>D1</sub> < 0.7V.
We will have to check that this assumption holds after resolving the DC operating point.

Under the assumption of D1 being off we can re-draw the circuit like in Fig. 2
where I also replaced the transistor with its large signal model and the LM3914V supply
port with a current generator which sinks ca. 10mA

The datasheet in fact, mentions that 
> Typical standby supply current (all LEDs OFF) is 1.6mA (2.5mA max).
> However, any reference loading adds 4 times that current drain to the V<sub>+</sub> (pin 3)
> supply input.

We're draining ca. 2mA from the voltage reference so we'll assume a current draw from V<sub>+</sub>
of 10mA (which is close to the measured value).

{% include figure 
    image_path = "/assets/images/lm3914-high-voltage-supply/d1-off-circuit.svg" 
    caption = "Fig. 2 - D1 off case with some replacements to help analysis"
%}

Another assumption I'll make is that D2 and D<sub>eb</sub>
(the model diode between emitter and base) are both forward biased. In this
case we can consider them as fixed voltage sources like V<sub>eb</sub> = 0.65V and
D2 (like all other forward biased LEDs) having a drop of 2.10V
(measured to be that value at 10mA but we'll assume that value no matter the current).

In this case we can write the following equations by applying the
[Kirchhoff's voltage law](https://en.wikipedia.org/wiki/Kirchhoff%27s_circuit_laws):

$$ V_+ = V_{D2} + V_{eb} + V_{ref} = 2.1V + 0.65V + 1.25V = 4.00V $$

$$ 48V = V_{R1} + V_+  \Longrightarrow  V_{R1} = 48V - 4V = 44V $$

$$ I_{R1} = {V_{R1} \over R1} = {44V \over 3900\Omega} = 11.28mA $$

Of these 11.28mA we have 10mA going in the LM3914V and 1.28mA going into D2 and the BJT emitter
thus proving our assumption that D2 was forward biased and the BJT was in the active region.

To verify the assumption about D1 being off, we need to know V<sub>D1</sub>. We have
already VK<sub>D1</sub> = V<sub>+</sub> so we need to calculate VA<sub>D1</sub>
(VA = voltage at the anode and VK = voltage at the cathode).

In dot mode at any given time we either have one display LED on or none. This means that
at node VA<sub>D1</sub> (looking again at Fig. 1) the potential could be

1. in case one display LED is turned on, then we have (still assuming D1 turned off), that
   
   $$ VA_{D1} = 48V - V_{R2} = 48V - I_{R2} R2 $$
   
   The current I<sub>R2</sub> is given by the current we set for the LEDs using resistor R3
   which is (neglecting I<sub>B</sub>) 1.25V / 620Ω = 2mA thus setting the LED current (according to
   datasheet Figure 9, "LED Current vs Reference Loading") to ca. 18mA. Ths means:

   $$ VA_{D1} = 48V - 0.018 \times 3900\Omega = -22.2 V $$

   Oops! what's going on here? We assumed that the LED current set by the LM3914V was
   18mA but it's clear that the LM3914V can't handle that in such circumstances. The datasheet
   mentions this as well:
   
   > the LM3914 outputs operate in saturation for minimum dissipation

   So by setting the resistor R3 at 620Ω, the designers already knew that this setting would
   exceed the maximum current that could flow out of node VA<sub>D1</sub>. They did so in
   order to let the LM3914 operate in saturation.

   We know the the saturation voltage V<sub>sat</sub> from the datasheet
   ("LED Driver Saturation Voltage", Figure 7). Current will not reach 20mA so 
   let's assume it settles around 0.7V. This means:

   $$ VA_{D1} = V_{sat} + V_{LED} \approx 2.8V $$

   Note: This gives us a LED current of (48V - VA<sub>D1</sub>) / R2 = 11.58mA
   {: .notice--info}

   We calculated previously that V<sub>+</sub> = 4V so 
   
   $$ V_{D1} = VA_{D1} - VK_{D1} = 2.8V - 4V = -1.2V $$ 
   
   thus confirming D1 being reverse biased.

2. in case no display LED is turned on we have no current flowing into any LED thus having all LEDs behave as
   open circuits. If there was no current flowing in diode D1 then point V<sub>A</sub> would have be at 
   48V therefore D1 must be forward biased in this case.

## D1 on case

In case D1 is conducting the equivalent circuit is the following in Fig. 3

{% include figure 
    image_path = "/assets/images/lm3914-high-voltage-supply/d1-on-circuit.svg" 
    caption = "Fig. 3 - D1 on case"
%}

Calculations for V<sub>+</sub> still hold. What changes, is the current flowing into D2 and Q1
which is ([Kirchhoff's current law](https://en.wikipedia.org/wiki/Kirchhoff%27s_circuit_laws)) 

$$ I_{D2} = I_{R1} + I_{R2} - 10mA \\
   = 11.28mA + { {48V - V_{D1} - V_+} \over R2} - 10mA \\
   = 1.28mA + { 48V - 0.7V - 4V \over 3900\Omega } \\
   = 1.28mA + 11.10mA = 12.38mA $$

# Building the circuit

So let's take some measurements on the real thing which is shown in Fig. 4

{% include figure 
    image_path = "/assets/images/lm3914-high-voltage-supply/the-real-thing.jpg" 
    caption = "Fig. 4 - The circuit from Fig. 1 realized on the breadboard"
%}

A couple of notes about the build:
1. I didn't have the resistors with the right values and wattage, so I used two potentiometers
   (set as close as possible to 3.9K) for R1 and R2 and a resistor decade set to 620Ω for R3
2. I didn't have a [2N2905](https://www.onsemi.com/pub/Collateral/2N2905A-D.PDF) but rather
   a Panasonic [2SA1123](https://cdn-reichelt.de/documents/datenblatt/A100/2SA1123_MAT.pdf).
   I think, since the design is largely independent from the transistor parameters
   (as long as β is in the hundreds), we can replace Q1 with basically any PNP BJT.
3. D1 is a [1N4007](https://www.vishay.com/docs/88503/1n4001.pdf). Not a big deal.
4. The LM3914V is not a TI original but rather some clone.
5. Measurements were taken with my [Solartron Schlumberge 7150plus](https://holzleitner.com/el/solartron-7150/index-en.html)
   which is in good working order, as far as I can tell, but not calibrated.

## Measurements

|     Variable        | Measured (D1 off) | Calculated  (D1 off) | Measured (D1 on) | Calculated (D1 on)          |
|:--------------------|:------------------|:---------------------|:-----------------|:----------------------------|
| V<sub>+</sub>       | 3.626V            | 4V                   | 4.239V           | 4V                          |
| V<sub>ref</sub>     | 1.2488V           | 1.25V                | 1.2486V          | 1.25V                       |
| VA<sub>D1</sub>     | 3.025V            | ≈2.8V                | 4.857V           | V<sub>+</sub> + 0.7V = 4.7V |
| I<sub>D2</sub>      | 0.858mA           | 1.28mA               | 11.778mA         | 12.38mA                     |
| V<sub>D2</sub>      | 1.7886V           | 2.1V (assumption)    | 2.178V           | 2.1V (assumption)           |
| V<sub>EB</sub>      | 0.6329V           | 0.65V (assumption)   | 0.7484V          | 0.65V (assumption)          |
| I<sub>R1</sub>      | 11.06mA           | 11.28mA              | 10.875mA         | 11.28mA                     |
| I<sub>LED</sub>     | 11.15mA           | 11.58mA              | 0.009mA          | 0mA (assumption)            |
| I<sub>D1</sub>      | 0.011mA           | 0mA (assumption)     | 10.736mA         | 11.10mA (= I<sub>R2</sub>)  |
| V<sub>D1</sub>      | -0.698V           | -1.2V                | 0.6897V          | 0.7V                        |
| I<sub>LM3914</sub>  | 10.17mA           | 10mA (assumption)    | 9.732mA          | 10mA (assumption)           |
| V<sub>out</sub>     | 0.8523V           | 0.7V (assumption)    | 3.449V           | N/A                         |

I<sub>LM3914</sub> is the current entering the V<sub>+</sub> pin of the LM3914V and
V<sub>out</sub> is the voltage at the output port on the LM3914V at the lit led
(in case D1 is off) or any other output port (when D1 is on).

# Conclusions

In this post we've seen how the application is supposed to work on paper, analyzing the bias points of the
various components and understanding what happens in every part of the circuit and gaining some in-deep
understanding of how the LM3914 works.

I'm also pretty happy with how close the measurements turned out to be to the calculated values given
all approximations we did during the course of the analysis. I think most of the error comes from the fact
that I considered a voltage drop across diodes to be the same regardless of the current flowing through them
(a simplified model of the real thing) to make it easier to reason about it.

I hope this post was helpful to whom is interested in the LM3914. It certainly was interesting and a great
exercise to me to write it: this helped me understanding this application in order to design a display
based on it (see [this post](/electronics/30_leds_with_30_volts/) about the display I'm designing).