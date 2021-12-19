JSFX SoX Plugins for Reaper DAW
===============================

Overview
--------

The JSFX-SoX software package provides JSFX (Jesusonic) plugins for
being used in the Reaper DAW; they implement some of the audio
processing effects from SoX.  It is also possible to use them in any
VST compatible DAW using the freely available [ReaJS VST
plugin][reference:ReaJS] that is able to interpret JSFX files.

*[SoX][reference:SoX]* is a command line audio processing tool for
Unix, Windows and Mac OS that transforms source audio files in several
formats into other audio files.

The effects provided here are a complete rewrite of the SoX algorithms
for producing *(bit-exact) identical* renderings in the DAW.  This can
easily be checked by rendering some audio externally with SoX and
internally with the plugins and subtracting the results.  Apart from
roundoff errors (SoX often uses 32bit integer processing, while JSFX
always uses double floating point processing) the results cancel out
with typically a residual noise of -140dBFS.

The main motivation for this package is to be able to play around with
effects in Reaper and be sure that the external rendering by SoX will
produce exactly the same results.  Although SoX does not always
provide the "best" effects, it still is a reliable and well-defined
audio tool.

Because SoX has rich command line options for its effects, not every
effect configuration from SoX can be transported into the slider
oriented GUI for JSFX.  E.g. the compander of SoX allows the
definition of a transfer function having multiple segments.  Although
the internal engine of the JSFX compander implements exactly the same
internal segment logic, the user interface only allows the typical
definition of a threshold and a compression ratio (with three
segments).

Note also that a spiffy user interface is *not at all* a priority in
this project.

The SoX effects have been rewritten and restructured for easier
maintenance, because in the original source there is some redundancy
and unnecessary complexity due to its several contributors.
Nevertheless the effects provided here faithfully model the SoX
processing.

Available Effects
-----------------

The following effects are available in this package:

  - *allpass*: a biquad allpass filter two-poled with filter frequency
        and the filter bandwith (in several units)

  - *band*: a biquad bandpass filter with center filter frequency and
        the filter bandwith (in several units) and an option for
        unpitched audio

  - *bandpass/bandreject*: a biquad filter for bandpass or bandreject
        with center filter frequency and the filter bandwith (in
        several units)

  - *bass/treble*: a biquad filter for boosting or cutting bass or
        treble with a shelving characteristics with settings for
        filter frequency and the filter bandwith (in several units)

  - *biquad*: a generic biquad (iir) filter with 6 coefficients b0,
        b1, b2, a0, a1 and a2

  - *compand*: a compander with attack, release, input gain shift,
        threshold and compression and soft knee; this is a reduced
        version of SoX compand with only a simple transfer function

  - *equalizer*: a biquad filter for equalizing with settings for the
        pole count, the filter frequency and the filter bandwith (in
        several units)

  - *gain*: a volume changer by _exact_ decibels...

  - *lowpass/highpass*: a biquad filter for either lowpass or highpass
        with settings for the pole count, the filter frequency and the
        filter bandwith (in several units)

  - *mcompand*: a multiband compander with a Linkwitz-Riley crossover
        filter and for each band a compander with attack, release,
        input gain shift, threshold and compression and soft knee;
        again the companders only allow a simple transfer function

  - *overdrive*: a simple tanh distortion with gain and colour
        specification

  - *phaser*: a phaser effect with sine or triangle modulation

  - *reverb*: a reverb effect (based on Freeverb) with several
        parameters for the room (like size and HF damping) as well as
        a possible predelay

  - *tremolo*: a tremolo effect with sine modulation using a
        double-sideband suppressed carrier modulation

Installation
-----------------

The installation is as follows:

   1. Close the Reaper application or your DAW using ReaJS (if open).

   2. Make a subdirectory "Dr_TT" in either the "Effects" directory of
      the Reaper installation (typically in "\Program
      Files\Reaper\Effects") or - if your DAW uses some different
      directory for JSFX files - in that directory.

   3. Copy over all *.jsfx and *.jsfx-inc files from the distribution
      into this directory.  If helpful, also add the documentation
      from the root directory.

   4. Restart Reaper (or your other DAW).  You should now be able to
      select the plugins from the JSFX folder (they are all prefixed
      with "SoX").

Alternatively -&nbsp;and much easier!&nbsp;- you can use the
[ReaPack][reference:reapack] plugin and do an automatic install via
the `index.xml` file in this repository.

After the installation via ReaPack all the effects can be found in the
effects list of the Reaper installation.

Testing the Plugins
-------------------

If you want to run the test, you also have to have a SoX installation.
The test script "makeTestFiles.bat" in the Test directory assumes that
SoX is available in the program search path.

The test script produces several sound and noise files and applies SoX
audio effects to produces result audio files.

The Reaper project file "testSoxPlugins.rpp" references those test and
result files and applies the corresponding effect plugins.  Ideally
(because the result files have inverted phase), everything should
cancel out.

Details
-------

The detailed user manual can be found *[here][reference:manual]*.


[reference:SoX]: http://sox.sourceforge.net/
[reference:ReaJS]: https://www.reaper.fm/reaplugs/
[reference:reapack]: https://reapack.com/
[reference:manual]: https://github.com/prof-spock/SoX-Plugins-JSFX/raw/master/JSFXSOX-Plugins-Documentation.pdf