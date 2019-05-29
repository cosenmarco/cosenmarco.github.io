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
1. D1 is forward biased (aka conducting or ON)
2. D1 is reverse biased (aka not conducting or OFF)

## D1 OFF case

For D1 to be off we must be under the hypothesis that it's V<sub>AK</sub> < 0.7V.
We will have to check that this assumption holds after resolving the DC operating point.

Under the assumption of D1 being off we can re-draw the circuit like in Fig. 2
where I also replaced the transistor with its large signal model and the LM3914V supply
port with a current generator which sinks ca. 5.6mA 
(according to the "Supply Current vs Temperature" chart, Figure 2).

{% include figure 
    image_path = "/assets/images/lm3914-high-voltage-supply/d1-off-circuit.svg" 
    caption = "Fig. 2 - D1 OFF case with some replacements to help analysis"
%}

Another assumption I'll make is that D2 and D<sub>eb</sub>
(the model diode between emitter and base) are both forward biased. In this
case we can consider them as fixed voltage sources like V<sub>eb</sub> = 0.7V and
VD2<sub>AK</sub> = 1.0V (being that a LED).

In this case we can write the following equations by applying the
[Kirchhoff voltage law](https://en.wikipedia.org/wiki/Kirchhoff%27s_circuit_laws):

$$ V_+ = VD2_{AK} + V_{eb} + 1.25V = 1.0V - 0.7V - 1.25V = 2.95V $$

$$ 48V = V_{R1} + V_+  $$

$$ V_{R1} = 48V - 1.0V - 0.7V - 1.25V = 45.05V $$

$$ I_{R1} = {V_{R1} \over R1} = {45.05V \over 3900\Omega} = 11.55mA $$

Of these 11.55mA we have 5.6mA going in the LM3914V and 5.95mA going into D2 and the BJT emitter
thus proving our assumption that D2 was forward biased and the BJT was in the active region.

To verify the assumption about D1 being OFF, we need to know V<sub>AK</sub>. We have
already V<sub>K</sub> = V<sub>+</sub> so we need to calculate V<sub>A</sub>.

In dot mode at any given time we either have one display LED ON or none. This means that
at node V<sub>A</sub> (looking again at Fig. 1) the potential could be:

1. in case one display LED is turned ON, then we have (still assuming D1 turned off), that
   
   $$ V_A = 48V - V_{R2} = 48V - I_{R2} R2 $$
   
   The current I<sub>R2</sub> is given by the current we set for the LEDs using resistor R3
   which is (neglecting I<sup>B</sup>) 1.25V / 620Ω = 2mA thus setting the LED current (according to
   datasheet Figure 9, "LED Current vs Reference Loading") to ca. 18mA. Ths means

   $$ V_A = 48V - 0.018 \times 3900Ω = -22.2 V $$

   Oops! what's going on there? We assumed that the current LED current set by the LM3914V was
   18mA but it's clear that the LM3914V can't handle that in such circumstances. The datasheet
   mentions this also: "the LM3914 outputs operate in saturation for minimum dissipation."

   We know the the saturation voltage V<sub>sat</sub> from the datasheet ("LED Driver Saturation Voltage", Figure 7)
   as well: current will not reach 20mA but let's assume it's about 1V. This means

   $$ V_A = V_{sat} + V_{LED} \approx 2V $$

   We calculated previously that V<sub>+</sub> = 2.95V so V<sub>AK</sub> = -0.95V thus confirming D1 being OFF

2. in case no display LED is turned ON we have no current flowing into any LED thus having all LEDs behave as
   open circuits. If there was no current flowing in diode D1 then point V<sub>A</sub> would be at 48V therefore
   D1 must be forward biased in this case.

## D1 ON case

In case D1 is conducting the equivalent circuit is the following in Fig. 3


{% include figure 
    image_path = "/assets/images/lm3914-high-voltage-supply/d1-on-circuit.svg" 
    caption = "Fig. 2 - D1 ON case"
%}

Calculations for V<sub>+</sub> still hold. What changes, is the current flowing into D2 and Q1
which is basically 

$$ I_{D2} = I_{R1} + I_{R2} = 11.55mA + { {48V - V_+ - VD1_{AK}}} \over R2} \\
  = 11.55mA + { 48V - 2.95V - 0.7V \over 3900 \Omega} = 22.92mA $$

# Building the circuit

TODO

# Conclusions