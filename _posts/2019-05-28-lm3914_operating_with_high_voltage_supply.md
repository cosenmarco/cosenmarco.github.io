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
    caption = "Fig. 1 Operating the LM3914 with a high voltage supply"
%}

I must say I "cheated" and built the circuit before actually analyzing it but this has
proven beneficial because it suggested me the easiest path to understand how it's 
supposed to work on paper.

The proposed approach here is to analyze the DC operating point of the circuit in 2 cases:
1. D1 is forward biased (aka conducting or ON)
2. D1 is reverse biased (aka not conducting or OFF)

## D1 OFF case

For D1 to be off we must be under the hypothesis that it's V<sub>AK</sub> < 0.7V.
We will have to check this assumption holds after resolving the DC operating point.

Under the assumption of D1 being off we can re-draw the circuit like in Fig. 2
where I also replaced the transistor with its large signal model and the LM3914V supply
port with a current generator which sinks ca. 5.6mA 
(according to the "Supply Current vs Temperature" chart, Figure 2).

{% include figure 
    image_path = "/assets/images/lm3914-high-voltage-supply/d1-off-circuit.svg" 
    caption = "Fig. 2 D1 OFF case with some replacements to help analysis"
%}