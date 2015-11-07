#' Manipulate and play ProTracker Modules. A description of the package,
#' ProTracker effect commands and test cases.
#'
#' The ProTrackR package can import and export module files from the music tracker
#' ProTracker from the Commodore Amiga machine. This package can also render
#' and play module files. Furthermore, the package provides the means to manipulate and analyse
#' the modules.
#'
#' ProTracker is a popular music tracker to sequence music on a Commodore
#' Amiga machine. This package offers the opportunity to import, export, manipulate
#' an play ProTracker module files. Even though the file format could be considered
#' archaic, it still remains popular to this date. This package intends to contribute
#' to this popularity and therewith keeping the legacy of ProTracker and the
#' Commodore Amiga alive.
#'
#' Some experience with ProTracker (or any other
#' music tracker) will promote the ease of use of this package. However,
#' the provided documentation and exernal links should help you,
#' when you're starting from scratch. A good place to start reading
#' this manual would be the documentation of the \code{\link{PTModule-class}},
#' which describes the structure of a ProTracker module and how it is
#' implemented in this package. You should also have a look at the documentation
#' of the \code{\link{PTPattern}}, \code{\link{PTTrack}}, \code{\link{PTCell}} and
#' \code{\link{PTSample}} classes, which are all elements of the
#' \code{\link{PTModule}}.
#' @section Future developments:
#' This package is far from perfect, but it is in such a state that it can
#' be useful to others, and have therefore published it. There's much room
#' for improvement and I intend to work on that.
#' However, as I'm working on this project in my spare time, developments
#' may not move forwards as fast as I'd like them to, or may eventually even
#' come to a halt. Keeping this disclaimer in mind, there are some minor
#' revisions I will try to work on the coming time.
#'
#' Currently, not all effect commands are implemented, although most common
#' ones are. I will work on implementing the remaining effect commands (see
#' also section below). ProTracker also has specific interpretations that
#' are currently not all implemented correctly. I will also try to fix this
#' in future versions.
#'
#' Sample switching (that is when a module switches from one sample number
#' to another, without specifying a new note) is also something that is implemented
#' differently by varying module players. This package currently does not implement
#' such switches conform ProTracker specs. This will also be addressed in
#' future versions.
#'
#' I also realise that the documentation of this package may be a bit cryptic
#' at some points. I would like to improve it where I can, but for that I need a
#' fresh perspective from the users. So please feel free to provide constructive
#' feedback such that I can improve the quality of this package.
#' @section ProTracker Effect Commands:
#' As explained before, effect commands are composed of a three hexadecimal digits.
#' The first digit indicates the type of effect, trigger or jump should be applied,
#' the latter two digits indicate the magnitude of the effect. An exception are
#' commands starting with the digit `E', for which the first two digits specify
#' the type of effect and only the last digit represents the magnitude. Below
#' all available effect commands (or codes if you will) are listed with the
#' magnitudes labelled `x' or `xy'. The overview shows which commands are used
#' for which kind of effect and whether it is implemented (between brackets) in
#' the playing routines of this package.
#'
#' But first a few words on speed and tempo in ProTracker. Both are two sides of
#' the same coin, both affect the overall speed with which patterns are played.
#' Speed is defined as the number of `ticks' per pattern row and tempo sets
#' the duration of each tick.
#' So by increasing the speed value, or decreasing the tempo, the overall playing
#' speed of the pattern table is reduced. At the default tempo of 125, the duration
#' of a tick equals the vertical blank period of the monitor (1/50 seconds for PAL
#' and 1/60 seconds NTSC video systems). They can be set with the Fxy command.
#'
#' On the Commodore Amiga the chip responsible for audio output (Paula),
#' the audio playback of samples can be controlled by the user in two ways:
#' the playback rate of the sample can be changed by specifying `period'
#' values (see e.g. \code{\link{periodToSampleRate}}) and specifying a
#' volume which is linearly scaled between 0 (silent) and 64 (maximum).
#' Period and volumes can only be changed at the start of each tick. This is
#' why the effects will be affected by the speed setting, but not the tempo.
#'
#' And now, without further ado, the overview of effect commands:
#' \describe{
#' \item{ 0xy - Arpeggio (Partly implemented)}{This effect alternates the pitch each tick to simulate a chord. xy needs to be greater then 00. First the specified note is played, then the pitch is increased with x semitones, then with y semitones.}
#' \item{ 1xy - Porta up (Implemented)}{Decrease the period value with xy every tick but the first.}
#' \item{ 2xy - Porta down (Implemented)}{Increase the period value with xy every tick but the first.}
#' \item{ 3xy - Porta to note (Implemented)}{Change the period value with xy every tick but the first, until the specified target note is reached.}
#' \item{ 4xy - Vibrato (Implemented)}{Oscillate the pitch with magnitude x. Where y relates to the oscillation frequency.}
#' \item{ 5xy - Porta to note + Volume slide (Implemented)}{A combination of effects 3xy and Axy.}
#' \item{ 6xy - Vibrato + Volume slide (Implemented)}{A combination of effects 4xy and Axy.}
#' \item{ 7xy - Tremolo (Implemented)}{Oscillate the volume with magnitude x. Where y relates to the oscillation frequency.}
#' \item{ 8xy - Not implemented (Not implemented)}{This effect command is not implemented in ProTracker, nor will it be in this package.}
#' \item{ 9xy - Set sample offset (Implemented)}{This effect causes the note to start playing at an offset (of 256 times xy samples) into the sample,
#' instead of just from the start.}
#' \item{ Axy - Volume slide (Implemented)}{Change the volume every but the first tick: increase with x, decrease with y.}
#' \item{ Bxy - Position jump (Implemented)}{Jump to position xy of the \code{\link{patternOrder}} table.}
#' \item{ Cxy - Set volume (Implemented)}{Set the volume with xy.}
#' \item{ Dxy - Pattern break (Implemented)}{Break to row xy in the next pattern. Note: xy is (even though it is a hexadecimal) interpreted as a decimal.}
#' \item{ E0x - Turn filter on/off (Implemented)}{If x is even, the (emulated) hardware filter is turned on (for all tracks). It is turned off if x is odd.}
#' \item{ E1x - Porta up (fine) (Implemented)}{The period value is decreased with x, at the first tick.}
#' \item{ E2x - Porta down (fine) (Implemented)}{The period value is increased with x, at the first tick.}
#' \item{ E3x - Glissando Control (Not yet implemented)}{This effect causes a change in the effect 3xy (porta to note).  It toggles
#' whether to do a smooth slide or whether to slide in jumps of semitones. When x is 0 it uses a smooth slide, non-zero values will result in jumps.}
#' \item{ E4x - Vibrato Waveform (Not yet implemented)}{This effect set the waveform for the vibrato command to follow. With x is 0, a sine wave is used, with 1 ramp down, with 2 or 3 a square wave. Values ranging from 4 up to 7 use the same wave forms, but doesn't retrigger it when a new note is played.}
#' \item{ E5x - Set finetune (Partly implemented)}{Set the finetune with x, where x is interpreted as a signed nybble.}
#' \item{ E6x - Pattern loop (Implemented)}{Set pattern loop start with E60, and loop x times when x is non-zero.}
#' \item{ E7x - Tremolo waveform (Not yet implemented)}{Same as E4x, but this controls the wave form for the tremolo effect (7xy) rather than the vibrato effect.}
#' \item{ E8x - Not implemented (Not implemented)}{According to official documentation this command is not implemented in ProTracker, but it is. Applies a filter on a looped sample, therewith destroying the original sample data.}
#' \item{ E9x - Retrigger note (Implemented)}{Retrigger the note every x-th tick.}
#' \item{ EAx - Volume slide up (fine) (Implemented)}{Increase the volume with x at the first tick.}
#' \item{ EBx - Volume slide down (fine) (Implemented)}{Decrease the volume with x at the first tick.}
#' \item{ ECx - Cut note (Implemented)}{Cut the volume of the note to zero after x ticks.}
#' \item{ EDx - Delay note (Implemented)}{The note is triggered with a delay of x ticks.}
#' \item{ EEx - Pattern delay (Implemented)}{The duration of the row is multiplied by (x + 1).}
#' \item{ EFx - Not implemented (Not implemented)}{According to official documentation this command is not implemented in ProTracker, but it is. It flips sample data in a looped sample, therewith destroying the original sample data.}
#' \item{ Fxy - Set speed or tempo (Implemented)}{When xy is smaller then 32, it sets the speed in ticks per row. When xy is greater than 31, it will set the tempo, which is inversely related to the duration of each tick. Speed and tempo can be defined in combination. }
#' }
#' @section Test cases:
#' The interpretation of the effect commands can be tedious. They often vary
#' between module players. Even ProTracker can have a quirky (and unexpected) ways
#' of handling the effect commands. This package aims at staying as close to
#' ProTracker `standards' as possible.
#'
#' The current version already implements most effect commands and common quirks
#' when it comes to their interpretation. My subjective estimate is that it will
#' correctly play roughly 90\% of the ProTracker modules on \href{http://www.modarchive.org}{ModArchive}. Some
#' Less common unexpected behaviour is documented by the team behind \href{http://wiki.openmpt.org/Main_Page}{OpenMPT}, for which they developed
#' several test cases. The table below shows which test cases this package passes
#' and which it does not. It is the intention to pass more of the tests in future
#' versions.
#' \tabular{ll}{
#'  Test module \tab Status\cr
#'  \href{http://wiki.openmpt.org/Development:_Test_Cases/MOD\%23AmigaLimitsFinetune.mod}{AmigaLimitsFinetune.mod} \tab Does not pass.\cr
#'  \href{http://wiki.openmpt.org/Development:_Test_Cases/MOD\%23ArpWraparound.mod}{ArpWraparound.mod} \tab Does not pass.\cr
#'  \href{http://wiki.openmpt.org/Development:_Test_Cases/MOD\%23DelayBreak.mod}{DelayBreak.mod} \tab Pass.\cr
#'  \href{http://wiki.openmpt.org/Development:_Test_Cases/MOD\%23finetune.mod}{finetune.mod} \tab Does not pass.\cr
#'  \href{http://wiki.openmpt.org/Development:_Test_Cases/MOD\%23PatLoop-Break.mod}{PatLoop-Break.mod} \tab Pass.\cr
#'  \href{http://wiki.openmpt.org/Development:_Test_Cases/MOD\%23PatternJump.mod}{PatternJump.mod} \tab Pass.\cr
#'  \href{http://wiki.openmpt.org/Development:_Test_Cases/MOD\%23PortaSmpChange.mod}{PortaSmpChange.mod} \tab Does not pass.\cr
#'  \href{http://wiki.openmpt.org/Development:_Test_Cases/MOD\%23PortaTarget.mod}{PortaTarget.mod} \tab Pass.\cr
#'  \href{http://wiki.openmpt.org/Development:_Test_Cases/MOD\%23PTInstrSwap.mod}{PTInstrSwap.mod} \tab Does not pass.\cr
#'  \href{http://wiki.openmpt.org/Development:_Test_Cases/MOD\%23ptoffset.mod}{ptoffset.mod} \tab Does not pass.\cr
#'  \href{http://wiki.openmpt.org/Development:_Test_Cases/MOD\%23PTSwapEmpty.mod}{PTSwapEmpty.mod} \tab Does not pass.\cr
#'  \href{http://wiki.openmpt.org/Development:_Test_Cases/MOD\%23VibratoReset.mod}{VibratoReset.mod} \tab Pass.
#' }
#' @docType package
#' @name ProTrackR
#' @aliases EffectCommands
#' @author Pepijn de Vries
#' @references
#' Some basic information on ProTracker:
#' \url{https://en.wikipedia.org/wiki/Protracker}
#'
#' Some basic information on music trackers in general:
#' \url{https://en.wikipedia.org/wiki/Music_tracker}
#'
#' A tutorial on ProTracker on YouTube:
#' \url{https://www.youtube.com/playlist?list=PLVoRT-Mqwas9gvmCRtOusCQSKNQNf6lTc}
#'
#' Some informal but extensive technical documentation on ProTracker:
#' \url{ftp://amigaremix.com/pub/documents/format_documentation/Protracker\%20effects\%20(FireLight)\%20(.mod).txt}
#' \url{http://www.chemie.fu-berlin.de/chemnet/doc/tracker-4.31/technotes}
#' @importFrom audio play wait
#' @importFrom graphics plot
#' @importFrom lattice xyplot
#' @importFrom methods as new validObject
#' @importFrom signal butter filter
#' @importFrom stats aggregate approx
#' @importFrom tuneR mono readMP3 readWave Wave writeWave
NULL
