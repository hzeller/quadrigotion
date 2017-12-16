EESchema Schematic File Version 4
LIBS:tmc2660-quad-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 5
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 4350 1550 1000 950 
U 5A1094BF
F0 "TMC2660-100" 60
F1 "tmc2660-block-100.sch" 60
F2 "MISO" O R 5350 1950 60 
F3 "MOSI" I R 5350 2050 60 
F4 "SCLK" I R 5350 2150 60 
F5 "CS" I R 5350 2250 60 
F6 "VMot" U L 4350 1650 60 
F7 "VCC" U L 4350 1750 60 
F8 "~EN" I L 4350 2250 60 
F9 "START_MOSI" I R 5350 1800 60 
F10 "STEP" I L 4350 1950 60 
F11 "DIR" I L 4350 2050 60 
$EndSheet
Text GLabel 4250 1650 0    60   Input ~ 0
VMot
$Comp
L power:VCC #PWR0111
U 1 1 5A1094E5
P 4350 1750
F 0 "#PWR0111" H 4350 1600 50  0001 C CNN
F 1 "VCC" V 4350 1900 50  0000 L CNN
F 2 "" H 4350 1750 50  0001 C CNN
F 3 "" H 4350 1750 50  0001 C CNN
	1    4350 1750
	0    -1   -1   0   
$EndComp
Text GLabel 4250 2950 0    60   Input ~ 0
VMot
$Comp
L power:VCC #PWR0112
U 1 1 5A109A7C
P 4350 3050
F 0 "#PWR0112" H 4350 2900 50  0001 C CNN
F 1 "VCC" V 4350 3200 50  0000 L CNN
F 2 "" H 4350 3050 50  0001 C CNN
F 3 "" H 4350 3050 50  0001 C CNN
	1    4350 3050
	0    -1   -1   0   
$EndComp
$Sheet
S 4350 4150 1000 950 
U 5A10A8D5
F0 "TMC2660-300" 60
F1 "tmc2660-block-300.sch" 60
F2 "MISO" O R 5350 4550 60 
F3 "MOSI" I R 5350 4650 60 
F4 "SCLK" I R 5350 4750 60 
F5 "CS" I R 5350 4850 60 
F6 "VMot" U L 4350 4250 60 
F7 "VCC" U L 4350 4350 60 
F8 "~EN" I L 4350 4850 60 
F9 "START_MOSI" I R 5350 4400 60 
F10 "STEP" I L 4350 4550 60 
F11 "DIR" I L 4350 4650 60 
$EndSheet
Text GLabel 4250 4250 0    60   Input ~ 0
VMot
$Comp
L power:VCC #PWR0113
U 1 1 5A10A8FB
P 4350 4350
F 0 "#PWR0113" H 4350 4200 50  0001 C CNN
F 1 "VCC" V 4350 4500 50  0000 L CNN
F 2 "" H 4350 4350 50  0001 C CNN
F 3 "" H 4350 4350 50  0001 C CNN
	1    4350 4350
	0    -1   -1   0   
$EndComp
$Sheet
S 4350 5450 1000 950 
U 5A10AEC6
F0 "TMC2660-400" 60
F1 "tmc2660-block-400.sch" 60
F2 "MISO" O R 5350 5850 60 
F3 "MOSI" I R 5350 5950 60 
F4 "SCLK" I R 5350 6050 60 
F5 "CS" I R 5350 6150 60 
F6 "VMot" U L 4350 5550 60 
F7 "VCC" U L 4350 5650 60 
F8 "~EN" I L 4350 6150 60 
F9 "START_MOSI" I R 5350 5700 60 
F10 "STEP" I L 4350 5850 60 
F11 "DIR" I L 4350 5950 60 
$EndSheet
Text GLabel 4250 5550 0    60   Input ~ 0
VMot
$Comp
L power:VCC #PWR0114
U 1 1 5A10AEEC
P 4350 5650
F 0 "#PWR0114" H 4350 5500 50  0001 C CNN
F 1 "VCC" V 4350 5800 50  0000 L CNN
F 2 "" H 4350 5650 50  0001 C CNN
F 3 "" H 4350 5650 50  0001 C CNN
	1    4350 5650
	0    -1   -1   0   
$EndComp
$Comp
L Connector:Conn_02x08_Odd_Even J2
U 1 1 5A1095ED
P 2500 3450
F 0 "J2" H 2550 2825 50  0000 C CNN
F 1 "DataIn" H 2550 2916 50  0000 C CNN
F 2 "Quadrigotion:IDC_Header_SMD_16pins" H 2500 3450 50  0001 C CNN
F 3 "~" H 2500 3450 50  0001 C CNN
	1    2500 3450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0116
U 1 1 5A109C26
P 2300 3150
F 0 "#PWR0116" H 2300 2900 50  0001 C CNN
F 1 "GND" V 2305 3022 50  0000 R CNN
F 2 "" H 2300 3150 50  0001 C CNN
F 3 "" H 2300 3150 50  0001 C CNN
	1    2300 3150
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR0115
U 1 1 5A109EE9
P 2800 3150
F 0 "#PWR0115" H 2800 3000 50  0001 C CNN
F 1 "VCC" V 2817 3278 50  0000 L CNN
F 2 "" H 2800 3150 50  0001 C CNN
F 3 "" H 2800 3150 50  0001 C CNN
	1    2800 3150
	0    1    1    0   
$EndComp
Wire Wire Line
	4250 1650 4350 1650
Wire Wire Line
	4250 2950 4350 2950
Wire Wire Line
	4250 4250 4350 4250
Wire Wire Line
	4250 5550 4350 5550
Wire Wire Line
	4350 2250 3850 2250
Wire Wire Line
	3850 2250 3850 6150
Wire Wire Line
	3850 6150 4350 6150
Wire Wire Line
	5350 2250 6050 2250
Wire Wire Line
	5500 6150 5350 6150
Wire Wire Line
	5350 4850 5500 4850
Connection ~ 5500 4850
Wire Wire Line
	5350 3550 5500 3550
Connection ~ 5500 3550
Wire Wire Line
	5350 2150 6050 2150
Wire Wire Line
	5650 2150 5650 6050
Wire Wire Line
	5650 6050 5350 6050
Wire Wire Line
	5350 4750 5650 4750
Connection ~ 5650 4750
Wire Wire Line
	5350 3450 5650 3450
Connection ~ 5650 3450
Wire Wire Line
	5350 5700 5850 5700
Wire Wire Line
	5850 1800 5850 5950
Wire Wire Line
	5350 1800 6050 1800
Wire Wire Line
	5350 3100 5850 3100
Connection ~ 5850 3100
Wire Wire Line
	5350 4400 5850 4400
Connection ~ 5850 4400
Wire Wire Line
	4350 4850 3850 4850
Connection ~ 3850 4850
Wire Wire Line
	4350 3550 3850 3550
Connection ~ 3850 3550
Text GLabel 6050 2250 2    51   Input ~ 0
CS
Text GLabel 6050 2150 2    51   Input ~ 0
SCLK
Text GLabel 6050 1950 2    51   Output ~ 0
GLOBAL_MISO
Text GLabel 6050 1800 2    51   Input ~ 0
GLOBAL_MOSI
Connection ~ 5850 1800
Connection ~ 5650 2150
Connection ~ 5500 2250
Text GLabel 2300 3350 0    51   Output ~ 0
CS
Text GLabel 2800 3350 2    51   Output ~ 0
SCLK
Text GLabel 2800 3450 2    51   Output ~ 0
GLOBAL_MOSI
Text GLabel 2300 3450 0    51   Input ~ 0
GLOBAL_MISO
$Comp
L Connector:Conn_01x04 J1
U 1 1 5A111B0F
P 2450 1700
F 0 "J1" H 2450 1350 50  0000 C CNN
F 1 "Power" H 2450 1250 50  0000 C CNN
F 2 "Connectors_JST:JST_VH_B4PS-VH_2x4x3.96mm_Horizontal" H 2450 1700 50  0001 C CNN
F 3 "~" H 2450 1700 50  0001 C CNN
	1    2450 1700
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0110
U 1 1 5A112185
P 2650 2000
F 0 "#PWR0110" H 2650 1750 50  0001 C CNN
F 1 "GND" H 2655 1827 50  0000 C CNN
F 2 "" H 2650 2000 50  0001 C CNN
F 3 "" H 2650 2000 50  0001 C CNN
	1    2650 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 1800 2650 2000
Connection ~ 2650 1900
Text GLabel 3500 1600 2    60   Output ~ 0
VMot
Wire Wire Line
	2650 1600 2650 1700
Wire Wire Line
	2650 1600 3050 1600
Connection ~ 2650 1600
Wire Wire Line
	5500 2250 5500 6150
$Sheet
S 4350 2850 1000 950 
U 5A109A56
F0 "TMC2660-200" 60
F1 "tmc2660-block-200.sch" 60
F2 "MISO" O R 5350 3250 60 
F3 "MOSI" I R 5350 3350 60 
F4 "SCLK" I R 5350 3450 60 
F5 "CS" I R 5350 3550 60 
F6 "VMot" U L 4350 2950 60 
F7 "VCC" U L 4350 3050 60 
F8 "~EN" I L 4350 3550 60 
F9 "START_MOSI" I R 5350 3100 60 
F10 "STEP" I L 4350 3250 60 
F11 "DIR" I L 4350 3350 60 
$EndSheet
Wire Wire Line
	5350 1950 6050 1950
Wire Wire Line
	5350 2050 5750 2050
Wire Wire Line
	5750 2050 5750 3250
Wire Wire Line
	5750 3250 5350 3250
Wire Wire Line
	5350 3350 5750 3350
Wire Wire Line
	5750 3350 5750 4550
Wire Wire Line
	5750 4550 5350 4550
Wire Wire Line
	5350 4650 5750 4650
Wire Wire Line
	5750 4650 5750 5850
Wire Wire Line
	5750 5850 5350 5850
Text GLabel 4200 1950 0    51   Input ~ 0
STEP1
Wire Wire Line
	4200 1950 4350 1950
Text GLabel 4200 2050 0    51   Input ~ 0
DIR1
Wire Wire Line
	4200 2050 4350 2050
Text GLabel 4200 3250 0    51   Input ~ 0
STEP2
Wire Wire Line
	4200 3250 4350 3250
Text GLabel 4200 3350 0    51   Input ~ 0
DIR2
Wire Wire Line
	4200 3350 4350 3350
Text GLabel 4200 4550 0    51   Input ~ 0
STEP3
Wire Wire Line
	4200 4550 4350 4550
Text GLabel 4200 4650 0    51   Input ~ 0
DIR3
Wire Wire Line
	4200 4650 4350 4650
Text GLabel 4200 5850 0    51   Input ~ 0
STEP4
Wire Wire Line
	4200 5850 4350 5850
Text GLabel 4200 5950 0    51   Input ~ 0
DIR4
Wire Wire Line
	4200 5950 4350 5950
Text GLabel 3800 2700 0    51   Input ~ 0
~ENABLE
Wire Wire Line
	3800 2700 3850 2700
Connection ~ 3850 2700
Text GLabel 2300 3250 0    47   Input ~ 0
~ENABLE
Text GLabel 2300 3550 0    51   Output ~ 0
STEP1
Text GLabel 2300 3650 0    51   Output ~ 0
STEP2
Text GLabel 2300 3750 0    51   Output ~ 0
STEP3
Text GLabel 2300 3850 0    51   Output ~ 0
STEP4
Text GLabel 2800 3550 2    51   Output ~ 0
DIR1
Text GLabel 2800 3650 2    51   Output ~ 0
DIR2
Text GLabel 2800 3750 2    51   Output ~ 0
DIR3
Text GLabel 2800 3850 2    51   Output ~ 0
DIR4
NoConn ~ 2800 3250
Wire Wire Line
	5350 5950 5850 5950
Connection ~ 5850 5700
$Comp
L Mechanical:Mounting_Hole M0
U 1 1 5A1112B3
P 2300 4550
F 0 "M0" H 2250 4700 50  0000 L CNN
F 1 "Mount" H 2200 4800 50  0000 L CNN
F 2 "Mounting_Holes:MountingHole_2.7mm_M2.5" H 2500 4550 50  0001 C CNN
F 3 "~" H 2500 4550 50  0001 C CNN
	1    2300 4550
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:Mounting_Hole_PAD M1
U 1 1 5A1112BA
P 2700 4600
F 0 "M1" H 2700 4800 50  0000 L CNN
F 1 "Mount" H 2600 4900 50  0000 L CNN
F 2 "Mounting_Holes:MountingHole_2.7mm_M2.5_Pad" H 2900 4600 50  0001 C CNN
F 3 "~" H 2900 4600 50  0001 C CNN
	1    2700 4600
	1    0    0    -1  
$EndComp
$Comp
L device:Fuse F1
U 1 1 5A1105FC
P 3200 1600
F 0 "F1" V 3003 1600 50  0000 C CNN
F 1 "Fuse" V 3094 1600 50  0000 C CNN
F 2 "Quadrigotion:BladeFuse-Mini_Keystone-3586" V 3130 1600 50  0001 C CNN
F 3 "" H 3200 1600 50  0001 C CNN
	1    3200 1600
	0    1    1    0   
$EndComp
Wire Wire Line
	3350 1600 3500 1600
Text Label 2700 1600 0    60   ~ 0
PowerIn
$Comp
L power:GND #PWR02
U 1 1 5A1C0ADE
P 2700 4700
F 0 "#PWR02" H 2700 4450 50  0001 C CNN
F 1 "GND" V 2705 4572 50  0000 R CNN
F 2 "" H 2700 4700 50  0001 C CNN
F 3 "" H 2700 4700 50  0001 C CNN
	1    2700 4700
	1    0    0    -1  
$EndComp
$EndSCHEMATC
