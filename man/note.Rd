% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/02PTCell.r
\name{note}
\alias{note}
\alias{note,numeric-method}
\alias{note,PTCell-method}
\alias{note<-}
\alias{note<-,PTCell,character-method}
\title{Extract or replace a note}
\usage{
\S4method{note}{numeric}(x)

\S4method{note}{PTCell}(x)

\S4method{note}{PTCell,character}(x) <- value
}
\arguments{
\item{x}{Either a (\code{vector} of) numeric value(s), representing a period
value. It can also be a \code{\link{PTCell}} object.}

\item{value}{A \code{character} string representing the chromatic scale note
with wich the current note needs to be replaced. Should have any of the folling values:
\code{"C-"}, \code{"C#"}, \code{"D-"}, \code{"D#"}, \code{"E-"}, \code{"F-"},
\code{"F#"}, \code{"G-"}, \code{"G#"}, \code{"A-"}, \code{"A#"}, \code{"B-"},
or \code{"--"}.
Right-hand dashes can be omitted from these strings. Both upper and lower case are
accepted.

If an \code{\link{octave}} is not yet specified for \code{PTCell} \code{x},
it will be set to 1.

Assigning a value of \code{"--"} will remove both the note and octave from
object \code{x}.}
}
\value{
For \code{note}, a \code{character} string representing the note
is returned.

For \verb{note<-}, a copy of \code{PTCell} object \code{x} in which the
note is replaced by \code{value} is returned.
}
\description{
Obtain a note from a period value or extract or replace a note of a
\code{\link{PTCell}} object.
}
\details{
Period values are used by ProTracker to set a playback sample rate and in
essence determine the key in which a sound is played. This method can be used
to obtain the note (key) associated with a period value (according to the
ProTracker \code{\link{period_table}}, assuming zero \code{\link{fineTune}}).
If the period value is not in the \code{\link{period_table}}, the note associated
with the period closest to this value in the table is returned.

The note can also be obtained or replaced for a \code{\link{PTCell}} object.
}
\examples{
data("mod.intro")

## get the note of PTCell at pattern #3, track #2,
## row #1 from mod.intro (which is note "C-"):

note(PTCell(mod.intro, 1, 2, 3))

## replace the note of PTCell at pattern #3, track #2,
## row #1 from mod.intro with "A-":

note(PTCell(mod.intro, 1, 2, 3)) <- "A-"

## get the notes associated with the period
## values 200 up to 400:

note(200:400)

}
\seealso{
Other period.operations: 
\code{\link{noteToPeriod}()},
\code{\link{octave}()},
\code{\link{periodToChar}()},
\code{\link{period_table}},
\code{\link{sampleRate}}

Other note.and.octave.operations: 
\code{\link{noteToPeriod}()},
\code{\link{noteUp}()},
\code{\link{octave}()},
\code{\link{periodToChar}()},
\code{\link{sampleRate}}

Other cell.operations: 
\code{\link{PTCell-class}},
\code{\link{PTCell-method}},
\code{\link{effect}()},
\code{\link{sampleNumber}()}
}
\author{
Pepijn de Vries
}
\concept{cell.operations}
\concept{note.and.octave.operations}
\concept{period.operations}
