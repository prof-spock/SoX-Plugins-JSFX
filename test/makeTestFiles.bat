@ECHO OFF
REM generate SOX test files for cancellation test

REM --- sox command path ---
SET sox=sox

REM --- internal configuration ---
SET soxFileType=.flac
SET soxFileSettings=-b 24 -r 44100
SET durationInSecondsBy4=4
SET durationInSeconds=16

REM ==========================
REM === prepare test files ===
REM ==========================

ECHO === preparing test files ===
SET soxCommandsSuffix=fade 0.1 -0 pad 1 1

REM -- a stereo noise file with two bursts --
SET fileListA=-v 0.2 noise-partA%soxFileType% -v 0.6 noise-partA%soxFileType%
SET fileListA=%fileListA% %fileListA%
SET soxCommands=synth %durationInSecondsBy4% pinknoise
%sox% -n %soxFileSettings% noise-partA%soxFileType% %soxCommands%
%sox% %fileListA% noiseA%soxFileType% %soxCommandsSuffix%
SET soxCommands=synth %durationInSeconds% sine 135 tremolo 0.5
%sox% -n %soxFileSettings% noiseB%soxFileType% %soxCommands%
%sox% -M noiseA%soxFileType% noiseB%soxFileType% noise%soxFileType%

REM -- two sine files, one with a sweep --
SET soxCommands=synth %durationInSeconds% sine 100-5000 gain -6 remix 1 1
%sox% -n %soxFileSettings% sine-sweep%soxFileType% %soxCommands% %soxCommandsSuffix%

SET soxCommands=synth %durationInSeconds% sine 500 remix 1 1
%sox% -n %soxFileSettings% sine-500Hz%soxFileType% %soxCommands% %soxCommandsSuffix%

REM =====================
REM === perform tests ===
REM =====================

SET soxCommands=allpass 1050 3q
CALL :makeTest noise allpass

SET soxCommands=band 1222 2.3q
CALL :makeTest noise band

SET soxCommands=bandpass -c 520 2o
CALL :makeTest noise bandpass

SET soxCommands=bandreject 1531 1q
CALL :makeTest noise bandreject

SET soxCommands=bass -1.23 536 2q
CALL :makeTest sine-sweep bass

SET soxCommands=biquad 0.3 -0.5 0.3 2 -0.4 0.1
CALL :makeTest noise biquad

SET soxCommands=compand 0.02,0.15 -4:-60,0,-20 +4.5
CALL :makeTest noise compander

SET soxCommands=equalizer 520 2o -3
CALL :makeTest sine-sweep equalizer

SET soxCommands=gain -7.5
CALL :makeTest noise gain

SET soxCommands=highpass -1 2750
CALL :makeTest sine-sweep highpass

SET soxCommands=lowpass -2 250 2o
CALL :makeTest noise lowpass

SET soxCommands=overdrive 3 40
CALL :makeTest noise overdrive

SET soxCommands=mcompand "0.02,0.15 4:-60,0,-20 +4.5" 1000
SET soxCommands=%soxCommands% "0.15,0.4 -20,0,-10 -2"
CALL :makeTest noise mcompander

SET soxCommands=phaser 0.6 0.66 3 0.6 0.5 -t
CALL :makeTest noise phaser
CALL :makeTest sine-sweep phaser

SET soxCommands=reverb 60 22 87.5 34.88 20 -3
CALL :makeTest noise reverb

SET soxCommands=treble +2.75 5200 2o
CALL :makeTest noise treble

SET soxCommands=tremolo 0.395 94.67
CALL :makeTest sine-500Hz tremolo

GOTO :EOF

REM ============================================================

:makeTest
    SET sourceStem=%1
    SET category=%2

    ECHO === %category% (%sourceStem%) test === %soxCommands%
    %sox% %sourceStem%%soxFileType% %sourceStem%-%category%test%soxFileType% %soxCommands%
GOTO :EOF
