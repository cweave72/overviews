# Useful RF Relationships

## Volts RMS, Power and dB Conversions

Volts RMS from V peak-peak:
$${\Large V_{rms}=\frac{V_{p-p}}{2\sqrt{2}}=\frac{V_{pk}}{\sqrt{2}}}$$

Power (Watts):
$${\Large P_{W} = \frac{V_{rms}^2}{R_{ohms}}}$$

Power (dBW  "dB relative to 1 W"):
$${\Large P_{dBW} = 10\log({P_{W}})}$$

Power (dBm "dB relative to 1 mW"):
$${\Large P_{dBm} = 10\log\left(\frac{P_{W}}{.001 W}\right)}$$

dBm to dBW:
$${\Large P_{dBm}=P_{dBW} + 30}$$

dBm to mW:
$${\Large P_{mW} = 10^{\frac{P_{dBm}}{10}}}$$

dBm to $V_{rms}$:
$${\Large V_{rms} = \sqrt{10^{dBm/10} \cdot 0.001 \cdot R}}$$

* R is usually 50 Ohms

### Examples

| P (W)    | dBW    | dBm    | V (rms) | V (p-p) | 
| ---      | ---    | ---    | ---     | ---     | 
| 4        | 6.02   | 36.02  | 14.1421 | 40.0000 | 
| 2        | 3.01   | 33.01  | 10.0000 | 28.2843 | 
| 1        | 0.00   | 30.00  | 7.0711  | 20.0000 | 
| 0.1      | -10.00 | 20.00  | 2.2361  | 6.3246  | 
| 0.01     | -20.00 | 10.00  | 0.7071  | 2.0000  | 
| 0.001    | -30.00 | 0.00   | 0.2236  | 0.6325  | 
| 0.0001   | -40.00 | -10.00 | 0.0707  | 0.2000  | 
| 1.00E-05 | -50.00 | -20.00 | 0.0224  | 0.0632  | 
| 1.00E-06 | -60.00 | -30.00 | 0.0071  | 0.0200  | 
| 1.00E-07 | -70.00 | -40.00 | 0.0022  | 0.0063  | 
| 1.00E-08 | -80.00 | -50.00 | 0.0007  | 0.0020  | 

* V (rms) computed using R=50 ohm

## RF Path Loss

**EIRP** : Effective Isotropic Radiated Power : This is a normalized measure of
power radiated out of an antenna at a transmitter, usually given in dBm or dBW.
This accounts for any gain in the antenna.

**Free-space Path Loss, $L$**: The loss experienced between transmitting and receiving
antennas over a line-of-sight path (i.e. no obstructions). Usually just called
"path loss".

$${\Large L = \left(\frac{4 \pi d}{\lambda}\right)^2}$$
$${\Large L = \left(\frac{4 \pi d f}{c} \right)^2}$$

where:

* ${\large \lambda = \frac{c}{f}}$
* $c$ = speed of light ($3 \cdot 10^8$) m/s
* $f$ = frequency in Hz
* $d$ = distance in meters

In dB:
$${\Large L_{dB} = 20\log(d) + 20\log(f) + 20\log\left(\frac{4\pi}{c}\right)}$$
$${\Large L_{dB} = 20\log(d) + 20\log(f) - 147.55}$$

### Computing Path Loss: Example

* Transmitter EIRP: +30 dBm
* Distance between antennas (d): 2 meters
* Freq: 10 GHz
* Receive antenna gain (${\large G_{r}}$): 4dB (typical for a patch antenna)

Power at output of receive antenna:

${\Large P_{r} = EIRP - L_{dB} + G_{r}}$

${\Large P_{r} = 30 - (20\log(2) + 20\log(10^9) - 147.55) + G_{r}}$

${\Large P_{r} = 30 - (6.02 + 200 - 147.55) + 4}$

${\Large P_{r} = 30 - 58.4 + 4}$

${\Large P_{r} = -24.4}$ dBm

Takeaways:

* RF power loses 58.4 dB over just 2 meters!
* Power decreases with the square of the distance. This is the **Inverse Square Law**
* For every *doubling* of the distance you would only lose an additional 6 dB of power!
* This is why we can still communicate with the Voyager space probes!
