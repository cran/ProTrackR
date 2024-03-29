% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/09playing_routines.r
\name{playingtable}
\alias{playingtable}
\alias{playingtable,PTModule-method}
\title{Generate a table for playing a PTModule object}
\usage{
\S4method{playingtable}{PTModule}(
  mod,
  starting.position = 1,
  max.duration = 2 * 60,
  speed = 6,
  tempo = 125,
  video = c("PAL", "NTSC"),
  play.once = T,
  verbose = T
)
}
\arguments{
\item{mod}{An object of class \code{\link{PTModule}}.}

\item{starting.position}{A \code{numeric} starting position index.
Determines where in the \code{\link{patternOrder}} table of the module to
start generating the playingtable.}

\item{max.duration}{A \code{numeric} value indicating the maximum
length in seconds of the pattern information returned. By default set
to 120 seconds (2 minutes). As some modules can be very long,
or contain infinite loops or position jumps, the maximum duration
is required to break out of the routine for generating the table.}

\item{speed}{Default speed to use when it is not specified in the
pattern data. See \link[=ProTrackR-package]{ProTrackR} documentation for more info on
\verb{speed' and }tempo'.}

\item{tempo}{Default tempo to use when it is not specified in the
pattern data.  See \link[=ProTrackR-package]{ProTrackR} documentation for more info on
\verb{speed' and }tempo'.}

\item{video}{The video mode of a Commodore Amiga affects timing routines.
This mode can be specified with this argument and
is represented by a \code{character} string that can have either the value
'\href{https://en.wikipedia.org/wiki/PAL}{PAL}'
or '\href{https://en.wikipedia.org/wiki/NTSC}{NTSC}'. PAL is used by default.}

\item{play.once}{A \code{logical} value. When set to \code{TRUE},
the routine will stop adding data to the table when the starting
position (\code{starting.position}) is reach once again. Warning:
may not work correctly when the last pattern contains a pattern
break. Will be overruled when the \code{maximum.duration} is reached
before the end of the song.}

\item{verbose}{A \code{logical} value. Suppresses a progress report
from being printed to the \code{\link[base:sink]{base::sink}} when set to \code{FALSE}.
The default value is \code{TRUE}.}
}
\value{
Returns a \code{data.frame} with pattern rows put in the right
order. Information contained in the returned table is described in the
'Details' section
}
\description{
This method generates a table (\code{data.frame}) in which information
from the pattern tables are put in the right order and in a comprehensive
format.
}
\details{
This method generates a table (\code{data.frame}) in which information
from the pattern tables (\code{\link{PTPattern}}) are put in the right
order, taking into account pattern breaks, position jumps and pattern
loops (see also \link[=ProTrackR-package]{ProTrackR} documentation,
section on effect commands). The information is put in
a comprehensive format in a \code{data.frame}, with the following columns:
\describe{
\item{row}{Row number index of the original
\code{\link{PTPattern}} object.}
\item{filter}{A \code{logical} value indicating whether the
Amiga hardware audio filter was either turned on or off using
effect command E00/E01 (see also \link[=ProTrackR-package]{ProTrackR} documentation,
section on effect commands).}
\item{speed}{Number of 'ticks' per row as set with the Fxy
effect commands in the module.}
\item{tempo}{The tempo as specified by the Fxy commands in the module.}
\item{delay}{The delay that should be applied to the row as
specified with the EEx effect command in the module.}
\item{effect.track1..4}{The effect code (\code{raw}) as specified in each of the
4 tracks in the module.}
\item{effect.mag.track1..4}{The effect magnitude (\code{raw}) as specified
for each of the 4 tracks in the module.}
\item{sample.nr.track1..4}{The sample index number (\code{numeric}) as specified for
each of the 4 tracks in the module.}
\item{note.track1..4}{The note (\code{factor}) as specified for each of
the four tracks in the module.}
\item{position}{The positions index number (\code{numeric}) from the
\code{\link{patternOrder}} table in the module.}
\item{duration}{Playback duration of the corresponding row in seconds.}
\item{cum_duration}{Cumulative playback duration of the corresponding row in seconds.}
}
}
\examples{
\dontrun{
data(mod.intro)
pt <- playingtable(mod.intro)
}
}
\seealso{
Other module.operations: 
\code{\link{PTModule-class}},
\code{\link{appendPattern}()},
\code{\link{clearSamples}()},
\code{\link{clearSong}()},
\code{\link{deletePattern}()},
\code{\link{fix.PTModule}()},
\code{\link{modToWave}()},
\code{\link{moduleSize}()},
\code{\link{patternLength}()},
\code{\link{patternOrderLength}()},
\code{\link{patternOrder}()},
\code{\link{playMod}()},
\code{\link{rawToPTModule}()},
\code{\link{read.module}()},
\code{\link{trackerFlag}()},
\code{\link{write.module}()}
}
\author{
Pepijn de Vries
}
\concept{module.operations}
