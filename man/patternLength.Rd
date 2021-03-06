% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/06PTModule.r
\name{patternLength}
\alias{patternLength}
\alias{patternLength,PTModule-method}
\title{Get the number of PTPattern tables in a PTModule}
\usage{
\S4method{patternLength}{PTModule}(x)
}
\arguments{
\item{x}{A \code{\link{PTModule}} object for which the number of
\code{\link{PTPattern}} tables need to be returned.}
}
\value{
Returns a \code{numeric} value representing the number of
\code{\link{PTPattern}} tables in object \code{x}.
}
\description{
Get the number of \code{\link{PTPattern}} tables in a \code{\link{PTModule}}
object.
}
\details{
The number of \code{\link{PTPattern}} tables in a \code{\link{PTModule}}
object should range from 1 up to either 64 or 100. The maximum depends on the
\code{\link{trackerFlag}} of the \code{\link{PTModule}} object.
}
\examples{
data("mod.intro")

## Get the number of pattern tables in mod.intro:
patternLength(mod.intro)

}
\seealso{
Other pattern.operations: 
\code{\link{MODPlugToPTPattern}()},
\code{\link{PTPattern-class}},
\code{\link{PTPattern-method}},
\code{\link{PTPatternToMODPlug}()},
\code{\link{appendPattern}()},
\code{\link{deletePattern}()},
\code{\link{pasteBlock}()},
\code{\link{patternOrderLength}()},
\code{\link{patternOrder}()}

Other module.operations: 
\code{\link{PTModule-class}},
\code{\link{appendPattern}()},
\code{\link{clearSamples}()},
\code{\link{clearSong}()},
\code{\link{deletePattern}()},
\code{\link{fix.PTModule}()},
\code{\link{modToWave}()},
\code{\link{moduleSize}()},
\code{\link{patternOrderLength}()},
\code{\link{patternOrder}()},
\code{\link{playMod}()},
\code{\link{playingtable}()},
\code{\link{rawToPTModule}()},
\code{\link{read.module}()},
\code{\link{trackerFlag}()},
\code{\link{write.module}()}
}
\author{
Pepijn de Vries
}
\concept{module.operations}
\concept{pattern.operations}
