---
title: "30 LEDs with 30 Volts"
date: 2019-05-24 15:34:05 +0200
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

The application to use the LM3914V with a supply voltage which is higher as the absolute maximum (25V)
is slightly more complicated. Fig. 3 reports the application from the datasheet.

FIG

In order to understand the circuit, we have first to understand the operating mode of transistor Q1.
Since the collector is connected to GND, the configuration is [common collector](https://en.wikipedia.org/wiki/Common_collector).

Every time I see a transistor, I like (in this case need) to understand in which region of operation
it's working. 

We can calculate that since ??? the ratio between V<sub>E</sub> and V<sub>B</sub> is ≈ 1 and therefore
V<sub>E</sub> ≈ REF_OUT = 1.2V