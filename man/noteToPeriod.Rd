% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/01supporting_functions.r
\name{noteToPeriod}
\alias{noteToPeriod}
\title{Extract period value for a specific note}
\usage{
noteToPeriod(note = "C-3", finetune = 0)
}
\arguments{
\item{note}{\code{character} string representing a note and octave for which the
ProTracker period value needs to be determined}

\item{finetune}{\code{integer} value ranging from -8 up to 7. A value used to
tune an audio sample.}
}
\value{
Returns the \code{numeric} ProTracker period value for a corresponding
note, octave and \code{fineTune()}. Returns 0 if a note could not be found in the
table.
}
\description{
Extracts the ProTracker period value for a specific note.
}
\details{
ProTracker uses a \link{period_table} to link period values to certain
octaves and notes. This function serves to look up corresponding
period values for specific notes and octaves.
}
\examples{
## Determine the period value corresponding with note 'A-3':
noteToPeriod("A-3")

## get the period values for notes 'A-3' and 'A#3' with finetune at -1:
noteToPeriod(c("A-3", "A#3"), -1)

## get the period values for note 'A-3' with finetune at 0 and 1:
noteToPeriod("A-3", 0:1)

}
\seealso{
Other period.operations: 
\code{\link{note}()},
\code{\link{octave}()},
\code{\link{periodToChar}()},
\code{\link{period_table}},
\code{\link{sampleRate}}

Other note.and.octave.operations: 
\code{\link{noteUp}()},
\code{\link{note}()},
\code{\link{octave}()},
\code{\link{periodToChar}()},
\code{\link{sampleRate}}
}
\author{
Pepijn de Vries
}
\concept{note.and.octave.operations}
\concept{period.operations}
