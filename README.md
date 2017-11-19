Quadrigotion: Multiple Motor Drivers on a Stick
================================================

Often it is useful to have all the motor drivers needed for a machine
on a separate circuit board to be able to mount it to a heatsink or close
to the action. **Quadrigotion** is a word amalgamated from 'Quadriga' (Four horses
powering a carriage) and 'Motion'.

While the first Quadrigotion implementation happens to also have four motor
drivers, this could of course extend in the future.

The Quadrigotion boards are meant to be quickly replaceable in any of
my 3D printers and CNC machines, and have a uniform connector to configure
and step the motors.

The digital input is provided with an IDC connector with 16 pins (2x8).
It features a SPI bus to send configuration data and also read motor/driver
status (the actual protocol is implementation-dependent, but they all can
share the same hardware interface).


| Desc               | Pin | Pin | Desc
|-------------------:|:---:|:---:|:-----------------------------
|               GND  |   1 |   2 | VCC (3.3V-5V)
| All Motors !Enable |   3 |   4 | (not connected; plan: fault detection out)
|          !CS (SPI) |   5 |   6 | CLK (SPI)
|         MISO (SPI) |   7 |   8 | MOSI (SPI)
|            Step #1 |   9 |  10 | Dir #1
|            Step #2 |  11 |  12 | Dir #2
|            Step #3 |  13 |  14 | Dir #3
|            Step #4 |  15 |  16 | Dir #4

It is easy to see that extending the driver count would just require a wider
IDC connector; the serial configuration interface can deal with any
number.

In an upcoming project, I'll build a breakout board to work with [BeagleG].

The first implementation is based on the TMC2660, a feature-rich motor driver
that can drive up to 4A (2.8A RMS). The PCB is a four layer board which duals
as heat conductor for cooling. Dense M2.5 mounting holes allow to firmly
mount it to a heatsink and get even pressure to individual silicone
heatsink pads.
Power is provided via a 4-pin JST VH connector (3.96mm pitch),
circuit protected with an automotive ATC Mini 297 blade fuse.

![](./img/tmc2660-quad-render.jpg)


[BeagleG]: https://github.com/hzeller/beagleg