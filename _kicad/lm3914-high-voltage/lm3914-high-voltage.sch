EESchema Schematic File Version 4
LIBS:lm3914-high-voltage-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L LED:HDSP-4830_2 BAR1
U 1 1 5CECF6F5
P 2700 1450
F 0 "BAR1" V 2250 1350 50  0000 L CNN
F 1 "HDSP-4830_2" V 2350 1350 50  0000 L CNN
F 2 "Display:HDSP-4830" H 2700 650 50  0001 C CNN
F 3 "https://docs.broadcom.com/docs/AV02-1798EN" H 700 1650 50  0001 C CNN
	1    2700 1450
	0    1    1    0   
$EndComp
Wire Wire Line
	2200 1250 2300 1250
Connection ~ 2300 1250
Wire Wire Line
	2300 1250 2400 1250
Connection ~ 2400 1250
Wire Wire Line
	2400 1250 2500 1250
Connection ~ 2500 1250
Wire Wire Line
	2500 1250 2600 1250
Connection ~ 2600 1250
Wire Wire Line
	2600 1250 2700 1250
Connection ~ 2700 1250
Wire Wire Line
	2700 1250 2800 1250
Connection ~ 2800 1250
Wire Wire Line
	2800 1250 2900 1250
Connection ~ 2900 1250
Wire Wire Line
	2900 1250 3000 1250
Connection ~ 3000 1250
Wire Wire Line
	3000 1250 3100 1250
$Comp
L LM3914V:LM3914V U1
U 1 1 5CECF718
P 2600 2500
F 0 "U1" V 2646 1670 50  0000 R CNN
F 1 "LM3914V" V 2555 1670 50  0000 R CNN
F 2 "PLCC127P990X990X457-20N" H 2600 2500 50  0001 L BNN
F 3 "" H 2600 2500 50  0001 L BNN
F 4 "PLCC-20 Texas Instruments" H 2600 2500 50  0001 L BNN "Campo4"
F 5 "Texas Instruments" H 2600 2500 50  0001 L BNN "Campo5"
F 6 "None" H 2600 2500 50  0001 L BNN "Campo6"
F 7 "Dot/Bar Display Driver 20-PLCC 0 to 70" H 2600 2500 50  0001 L BNN "Campo7"
F 8 "Unavailable" H 2600 2500 50  0001 L BNN "Campo8"
	1    2600 2500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2200 1650 2200 1800
Wire Wire Line
	2300 1650 2300 1800
Wire Wire Line
	2400 1650 2400 1800
Wire Wire Line
	2500 1650 2500 1800
Wire Wire Line
	2600 1650 2600 1800
Wire Wire Line
	2700 1650 2700 1800
Wire Wire Line
	2800 1650 2800 1800
Wire Wire Line
	2900 1650 2900 1800
Wire Wire Line
	3100 1650 3100 1800
$Comp
L Device:R R3
U 1 1 5CECF72E
P 2500 3600
F 0 "R3" H 2569 3554 50  0000 L CNN
F 1 "620" H 2569 3645 50  0000 L CNN
F 2 "" V 2430 3600 50  0001 C CNN
F 3 "" H 2500 3600 50  0001 C CNN
	1    2500 3600
	-1   0    0    1   
$EndComp
Wire Wire Line
	2800 3200 2800 3350
$Comp
L Device:R R2
U 1 1 5CECF73E
P 2000 950
F 0 "R2" H 2070 996 50  0000 L CNN
F 1 "3.9K" H 2070 905 50  0000 L CNN
F 2 "" V 1930 950 50  0001 C CNN
F 3 "" H 2000 950 50  0001 C CNN
	1    2000 950 
	1    0    0    1   
$EndComp
$Comp
L power:GND #PWR01
U 1 1 5CECF74E
P 3550 1850
F 0 "#PWR01" H 3550 1600 50  0001 C CNN
F 1 "GND" H 3555 1677 50  0000 C CNN
F 2 "" H 3550 1850 50  0001 C CNN
F 3 "" H 3550 1850 50  0001 C CNN
	1    3550 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	3300 1800 3550 1800
Wire Wire Line
	3550 1800 3550 1850
Wire Wire Line
	2600 3200 2600 3250
Wire Wire Line
	2600 3250 2900 3250
Wire Wire Line
	2900 3250 2900 3200
$Comp
L power:GND #PWR02
U 1 1 5CECF75D
P 1250 3800
F 0 "#PWR02" H 1250 3550 50  0001 C CNN
F 1 "GND" H 1255 3627 50  0000 C CNN
F 2 "" H 1250 3800 50  0001 C CNN
F 3 "" H 1250 3800 50  0001 C CNN
	1    1250 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2300 3200 2300 3250
Text HLabel 950  800  0    50   Input ~ 6
VCC
Text HLabel 2050 3200 0    50   Input ~ 6
IN
$Comp
L Device:D D1
U 1 1 5CF43EAB
P 1600 1250
F 0 "D1" H 1600 1466 50  0000 C CNN
F 1 "1N4002" H 1600 1375 50  0000 C CNN
F 2 "" H 1600 1250 50  0001 C CNN
F 3 "~" H 1600 1250 50  0001 C CNN
	1    1600 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 1100 2000 1250
Wire Wire Line
	2000 1250 2200 1250
Connection ~ 2200 1250
Wire Wire Line
	1750 1250 2000 1250
Connection ~ 2000 1250
$Comp
L Connector:TestPoint_Probe TP1
U 1 1 5CF6AB66
P 2150 700
F 0 "TP1" H 2302 801 50  0001 L CNN
F 1 "48V" H 2302 755 50  0000 L CNN
F 2 "" H 2350 700 50  0001 C CNN
F 3 "~" H 2350 700 50  0001 C CNN
	1    2150 700 
	1    0    0    -1  
$EndComp
Wire Wire Line
	2150 700  2000 700 
Wire Wire Line
	2000 700  2000 800 
$Comp
L Device:Q_PNP_BCE Q1
U 1 1 5CF752DE
P 1350 3350
F 0 "Q1" H 1541 3304 50  0000 L CNN
F 1 "2N2905" H 1541 3395 50  0000 L CNN
F 2 "" H 1550 3450 50  0001 C CNN
F 3 "~" H 1350 3350 50  0001 C CNN
	1    1350 3350
	-1   0    0    1   
$EndComp
Wire Wire Line
	3000 1650 3000 1800
$Comp
L Device:LED D2
U 1 1 5CF7436C
P 1250 2500
F 0 "D2" V 1289 2383 50  0000 R CNN
F 1 "LED" V 1198 2383 50  0000 R CNN
F 2 "" H 1250 2500 50  0001 C CNN
F 3 "~" H 1250 2500 50  0001 C CNN
	1    1250 2500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1250 1250 1450 1250
Wire Wire Line
	1250 1100 1250 1250
$Comp
L Device:R R1
U 1 1 5CF4319D
P 1250 950
F 0 "R1" H 1320 996 50  0000 L CNN
F 1 "3.9K" H 1320 905 50  0000 L CNN
F 2 "" V 1180 950 50  0001 C CNN
F 3 "" H 1250 950 50  0001 C CNN
	1    1250 950 
	1    0    0    1   
$EndComp
Wire Wire Line
	2900 3250 2900 3800
Connection ~ 2900 3250
Wire Wire Line
	1250 3800 1250 3550
Wire Wire Line
	2050 3200 2200 3200
Wire Wire Line
	1550 3350 2500 3350
Wire Wire Line
	1250 1250 1250 1800
Connection ~ 1250 1250
Wire Wire Line
	1250 2650 1250 3150
Wire Wire Line
	2000 1800 1250 1800
Connection ~ 1250 1800
Wire Wire Line
	1250 1800 1250 2350
Wire Wire Line
	2500 3200 2500 3350
Connection ~ 2500 3350
Wire Wire Line
	2500 3350 2800 3350
Wire Wire Line
	950  800  1250 800 
Connection ~ 1250 800 
Wire Wire Line
	1250 800  2000 800 
Connection ~ 2000 800 
Connection ~ 1250 3800
Wire Wire Line
	1250 3800 2500 3800
Wire Wire Line
	2500 3350 2500 3450
Wire Wire Line
	2500 3750 2500 3800
Connection ~ 2500 3800
Wire Wire Line
	2500 3800 2900 3800
$Comp
L power:GND #PWR?
U 1 1 5CEE728B
P 6150 3750
F 0 "#PWR?" H 6150 3500 50  0001 C CNN
F 1 "GND" H 6155 3577 50  0000 C CNN
F 2 "" H 6150 3750 50  0001 C CNN
F 3 "" H 6150 3750 50  0001 C CNN
	1    6150 3750
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D2
U 1 1 5CEE72AB
P 6150 2100
F 0 "D2" V 6189 1983 50  0000 R CNN
F 1 "LED" V 6098 1983 50  0000 R CNN
F 2 "" H 6150 2100 50  0001 C CNN
F 3 "~" H 6150 2100 50  0001 C CNN
	1    6150 2100
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R1
U 1 1 5CEE72B7
P 6150 1500
F 0 "R1" H 6220 1546 50  0000 L CNN
F 1 "3.9K" H 6220 1455 50  0000 L CNN
F 2 "" V 6080 1500 50  0001 C CNN
F 3 "" H 6150 1500 50  0001 C CNN
	1    6150 1500
	1    0    0    1   
$EndComp
Wire Wire Line
	6150 2250 6150 2500
Wire Wire Line
	6150 1750 6150 1950
Connection ~ 6150 3750
Wire Wire Line
	6150 3750 6900 3750
$Comp
L Device:Battery_Cell BT?
U 1 1 5CEECD97
P 5400 2350
F 0 "BT?" H 5518 2446 50  0001 L CNN
F 1 "48V" H 5518 2400 50  0000 L CNN
F 2 "" V 5400 2410 50  0001 C CNN
F 3 "~" V 5400 2410 50  0001 C CNN
	1    5400 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:Battery_Cell BT?
U 1 1 5CEF528F
P 6900 3450
F 0 "BT?" H 7018 3546 50  0001 L CNN
F 1 "1.25V" H 7018 3500 50  0000 L CNN
F 2 "" V 6900 3510 50  0001 C CNN
F 3 "~" V 6900 3510 50  0001 C CNN
	1    6900 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 1250 5400 2150
Wire Wire Line
	5400 1250 6150 1250
Wire Wire Line
	5400 2450 5400 3750
Wire Wire Line
	5400 3750 6150 3750
Wire Wire Line
	6150 1250 6150 1350
Wire Wire Line
	6150 1650 6150 1750
Connection ~ 6150 1750
Wire Wire Line
	6900 3100 6900 3150
Wire Wire Line
	6900 3750 6900 3550
$Comp
L pspice:ISOURCE I?
U 1 1 5CF0DFBD
P 8100 3100
F 0 "I?" V 7585 3100 50  0001 C CNN
F 1 "LM3914V - 5.6mA" H 7722 3100 50  0000 R CNN
F 2 "" H 8100 3100 50  0001 C CNN
F 3 "~" H 8100 3100 50  0001 C CNN
	1    8100 3100
	-1   0    0    1   
$EndComp
$Comp
L pspice:ISOURCE I?
U 1 1 5CF182EA
P 6150 3000
F 0 "I?" V 5635 3000 50  0001 C CNN
F 1 "βIb" H 5772 3000 50  0000 R CNN
F 2 "" H 6150 3000 50  0001 C CNN
F 3 "~" H 6150 3000 50  0001 C CNN
	1    6150 3000
	-1   0    0    1   
$EndComp
Wire Wire Line
	6150 3400 6150 3750
$Comp
L Device:D D?
U 1 1 5CF1A376
P 6900 2950
F 0 "D?" V 6946 2871 50  0001 R CNN
F 1 "Deb" V 6900 2871 50  0000 R CNN
F 2 "" H 6900 2950 50  0001 C CNN
F 3 "~" H 6900 2950 50  0001 C CNN
	1    6900 2950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6150 2500 6900 2500
Wire Wire Line
	6900 2500 6900 2800
Connection ~ 6150 2500
Wire Wire Line
	6150 2500 6150 2600
Text Notes 6200 1700 0    50   ~ 0
V+
Text Notes 6200 2450 0    50   ~ 0
E
Text Notes 6800 3200 0    50   ~ 0
B
Text Notes 6200 3500 0    50   ~ 0
C
Wire Wire Line
	8100 1750 8100 2700
Wire Wire Line
	6150 1750 8100 1750
Wire Wire Line
	8100 3500 8100 3750
Connection ~ 6900 3750
$Comp
L Graphic:SYM_Arrow_Normal #SYM?
U 1 1 5CF3191E
P 7150 2950
F 0 "#SYM?" H 7150 3010 50  0001 C CNN
F 1 "SYM_Arrow_Normal" H 7160 2900 50  0001 C CNN
F 2 "" H 7150 2950 50  0001 C CNN
F 3 "~" H 7150 2950 50  0001 C CNN
	1    7150 2950
	0    1    1    0   
$EndComp
Text Notes 7200 2950 0    50   ~ 0
Ib
$Comp
L Device:R R3
U 1 1 5CF3E8D0
P 7550 3400
F 0 "R3" H 7619 3354 50  0000 L CNN
F 1 "620" H 7619 3445 50  0000 L CNN
F 2 "" V 7480 3400 50  0001 C CNN
F 3 "" H 7550 3400 50  0001 C CNN
	1    7550 3400
	-1   0    0    1   
$EndComp
Wire Wire Line
	6900 3750 7550 3750
Wire Wire Line
	6900 3150 7550 3150
Wire Wire Line
	7550 3150 7550 3250
Connection ~ 6900 3150
Wire Wire Line
	6900 3150 6900 3250
Wire Wire Line
	7550 3550 7550 3750
Connection ~ 7550 3750
Wire Wire Line
	7550 3750 8100 3750
$EndSCHEMATC