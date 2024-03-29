% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/08coercion.r
\docType{methods}
\name{PTPattern-method}
\alias{PTPattern-method}
\alias{PTPattern,raw,missing-method}
\alias{PTPattern,matrix,missing-method}
\alias{PTPattern,PTModule,numeric-method}
\alias{PTPattern<-}
\alias{PTPattern<-,PTModule,numeric,PTPattern-method}
\title{Coerce to or replace PTPattern}
\usage{
\S4method{PTPattern}{raw,missing}(x)

\S4method{PTPattern}{matrix,missing}(x)

\S4method{PTPattern}{PTModule,numeric}(x, pattern)

\S4method{PTPattern}{PTModule,numeric,PTPattern}(x, pattern) <- value
}
\arguments{
\item{x}{Object (any of \code{raw} data, a 64 by 16 \code{matrix} of \code{raw} data, a 64 by 4 \code{matrix} of \code{character} strings,
or a \code{PTModule})
to coerce to a \code{\link{PTPattern}}. See details below for the
required format of \code{x}.}

\item{pattern}{When \code{x} is a \code{PTModule}, provide an index
of the pattern that needs to be coerced to a \code{PTPattern}. Note that
ProTracker uses indices for patterns that start at zero, whereas R uses indices
that start at one. Hence add one to an index obtained from a \code{PTModule}
object (e.g., \code{x$pattern.order}).}

\item{value}{An object of \code{\link{PTPattern}} with which the \code{\link{PTPattern}}
object at the specified \code{index} in object \code{x} needs to be replaced.}
}
\value{
When \code{PTPattern} is used, a \code{PTPattern} object
based on \code{x} is returned.

When \verb{PTPattern<-} is used, object \code{x} is returned in which
the selected \code{PTPattern} is replaced with \code{value}.
}
\description{
This method will coerce a set of objects to a \code{PTPattern} object. It can also
be used to select specific patterns from \code{PTModule} objects and replace
the selected \code{PTPattern}.
}
\details{
Method to coerce \code{x} to class \code{\link{PTPattern}}.

When \code{x} is a 64 by 16 \code{matrix} of \code{raw} data, each row
implicitly represents the \code{\link{PTCell}} objects of each of the
four tracks. Each \code{\link{PTCell}} consists of four \code{raw}
values. The values in each row are formatted accordingly, where the values of the
cells of each track are concatenated. See \code{\linkS4class{PTCell}} documentation for
more details on the \code{raw} format of a \code{\link{PTCell}} object.

When \code{x} is a 64 by 16 \code{matrix} of \code{character} representations
of \code{\link{PTCell}} objects, the \code{character} representation must be
conform the specifications as documented at the \code{\linkS4class{PTCell}}.

When \code{x} is of class \code{\link{PTModule}}, the \code{PTPattern} at the
specified index (\code{pattern}) is returned, or can be replaced.
}
\examples{
## This will create an 'empty' PTPattern with
## all 0x00 values, which is equivalent to
## new("PTPattern"):
PTPattern(as.raw(0x00))

## Create a PTPattern based on repeated
## PTCell character representations:
pat <- PTPattern(matrix("F#2 1A 20A", 64, 4))

data("mod.intro")

## Replace the first pattern in the patternOrder
## table in mod.intro with 'pat' (don't forget to
## add one (+1) to the index):
PTPattern(mod.intro,
          patternOrder(mod.intro)[1] + 1) <- pat
}
\seealso{
Other pattern.operations: 
\code{\link{MODPlugToPTPattern}()},
\code{\link{PTPattern-class}},
\code{\link{PTPatternToMODPlug}()},
\code{\link{appendPattern}()},
\code{\link{deletePattern}()},
\code{\link{pasteBlock}()},
\code{\link{patternLength}()},
\code{\link{patternOrderLength}()},
\code{\link{patternOrder}()}
}
\author{
Pepijn de Vries
}
\concept{pattern.operations}
