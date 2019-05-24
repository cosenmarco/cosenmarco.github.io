---
title:  "30 LEDs with 30 Volts"
date:   2019-05-24 15:34:05 +0200
categories: electronics UI LED display LM3914
---

I'm currently (lazily) realizing a medium-ish size project which aims to bring
several of [Mr. Carlson](https://www.patreon.com/MrCarlsonsLab)'s 
capacitor testing devices into one single device to
speed up the testing process by not having to move the cap around across
several different pieces of equipment (each one also requiring power supply, casing, etc...).

Mr. Carlson (Paul) has designed and realized a leakage detector and a tester for detecting the 
which pole is connected to the external foil in non polarized poly type caps.

Both of Paul's projects use for the User Interface a 10 LED dot-type meter based on the
[LM3914V](https://www.ti.com/lit/ds/symlink/lm3914.pdf)
IC using a slightly modified version (for 30V supply) of the
"Operating with a High Voltage Supply" application from the datasheet.

I'm thinking to add an ESR meter (more on that in some other post) and package that nicely into a
project box with a linear power supply. To be able to read the ESR with some
degree of accuracy though, I want to increase the resolution of the display 
by adding more LEDs to the scale (and scale the signal accordingly at the display input).

This post is essentially about how to realize a 30 LED display meter which is powered
by a 30V power supply by combining and extending the two applications 
"Operating with a High Voltage Supply" and "20-Segment Meter with Mode Switch" from the datasheet.