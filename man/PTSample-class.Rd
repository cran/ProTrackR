% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/05PTSample.r
\docType{class}
\name{PTSample-class}
\alias{PTSample-class}
\alias{PTSample}
\title{The PTSample class}
\description{
This class holds audio fragments with meta-information, to be used in
\code{\link{PTModule}} objects.
}
\details{
This class holds audio fragments with meta-information (so-called samples),
to be used in \code{\link{PTModule}} objects. This class extends
the \code{\link[tuneR:Wave]{tuneR::Wave}} class from \code{\link[tuneR:tuneR]{tuneR::tuneR}}. It therewith inherits
all properties and cool methods available from the \code{\link[tuneR:tuneR]{tuneR::tuneR}} package.
This allows you, for instance, to generate power spectra (\code{\link[tuneR:powspec]{tuneR::powspec}})
of them. You can also plot the waveform with the \code{\link[tuneR:plot-Wave]{plot-Wave}} method.
See \code{\link[tuneR:tuneR]{tuneR::tuneR}} for all possibilities with \code{\link[tuneR:Wave]{tuneR::Wave}}
objects.
If you want you can also explicitly coerce \code{\link{PTSample}} to
\code{\link[tuneR:Wave]{tuneR::Wave}} objects like this: \code{as(new("PTSample"), "Wave")}.

The \code{\link{PTSample}} class has some slots that are additional to the
\code{\link[tuneR:Wave]{tuneR::Wave}} class, as ProTracker requires additional information on
the sample with respect to its name, fine tune, volume and loop positions.
The \code{\link{PTSample}} class restricts the enherited \code{\link[tuneR:Wave]{tuneR::Wave}}
class such that it will only hold 8 bit, mono, pcm waves with a maximum of
\code{2*0xffff = 131070} samples, as per ProTracker standards. The length should
always be even.

\code{PTSample}s can be imported and exported using the
\code{\link{read.sample}} and \code{\link{write.sample}} methods respectively.
\code{\link[tuneR:Wave]{tuneR::Wave}} objects and \code{raw} data can be coerced to
\code{PTSample}s with the \code{\link{PTSample-method}}.
}
\section{Slots}{

\describe{
\item{\code{name}}{A \code{vector} of length 22 of class \code{raw}, representing
the name of the \code{PTSample}. It is often used to include
descriptive information in a \code{\link{PTModule}}. The name
of a sample can be extracted or replaced with the \code{\link{name}} method.}

\item{\code{finetune}}{Single value of class \code{raw}. The \code{\link{loNybble}}
of the \code{raw} value, represents the sample fine tune value ranging from -8 up to
7. This value is used to tweak the playback sample rate, in order to tune it.
Negative values will lower the sample rate of notes, positive values will
increase the sample rate of notes. Period values corresponding to specific
notes and fine tune values are stored in the \code{\link{period_table}}.
The fine tune value can be extracted or replace with the \code{\link{fineTune}}
method.}

\item{\code{volume}}{Single value of class \code{raw}. The raw data corresponds with
the default playback volume of the sample. It ranges from 0 (silent) up to
64 (maximum volume). The volume value can be extracted or replaced with the
\code{\link{volume}} method.}

\item{\code{wloopstart}}{A \code{vector} of length 2 of class \code{raw}. The \code{raw}
data represent a single unsigned number representing the starting position of
a loop in the sample. It should have a value of \code{0} when there is no loop.
Its value could range from \code{0} up to \code{0xffff}. To get the actual position
in bytes the value needs to be multiplied with 2 and can therefore only be
can only be even. The sum of the loop start position and the loop length should
not exceed the \code{\link{sampleLength}}. Its value can be extracted or
replaced with the \code{\link{loopStart}} method.}

\item{\code{wlooplen}}{A \code{vector} of length 2 of class \code{raw}. The \code{raw}
data represent a single unsigned number representing the length of
a loop in the sample. To get the actual length in bytes, this value needs to
be multiplied by 2 and can therefore only be even. It should have a value of
\code{2} when there is no loop.
Its value could range from \code{2} up to \code{2*0xffff} (= \code{131070}) and
can only be even (it can be \code{0} when the sample is empty). The sum of the
loop start position and the loop length should
not exceed the \code{\link{sampleLength}}. Its value can be extracted or
replaced with the \code{\link{loopLength}} method.}

\item{\code{left}}{Object of class \code{numeric} representing the waveform of the
left channel. Should be \code{integer} values ranging from 0 up to 255.
It can be extracted or replaced with the \code{\link{waveform}} method.}

\item{\code{right}}{Object of class \code{numeric} representing the right channel.
This slot is inherited from the \code{\link[tuneR:Wave]{tuneR::Wave}} class and should be
\code{numeric(0)} for all \code{PTSample}s, as they are all mono.}

\item{\code{stereo}}{Object of class \code{logical} whether this is a stereo representation.
This slot is inherited from the \code{\link[tuneR:Wave]{tuneR::Wave}} class. As
\code{PTSample}s are always mono, this slot should have the value \code{FALSE}.}

\item{\code{samp.rate}}{Object of class \code{numeric} representing the sampling rate.}

\item{\code{bit}}{Object of class \code{numeric} representing the bit-wise quality.
This slot is inherited from the \code{\link[tuneR:Wave]{tuneR::Wave}} class. As
\code{PTSample}s are always of 8 bit quality, the value of this slot
should always be 8.}

\item{\code{pcm}}{Object of class \code{logical} indicating whether wave format is PCM.
This slot is inherited from the \code{\link[tuneR:Wave]{tuneR::Wave}} class, for
\code{PTSample}s its value should always be \code{TRUE}.}
}}

\seealso{
Other sample.operations: 
\code{\link{PTSample-method}},
\code{\link{fineTune}()},
\code{\link{loopLength}()},
\code{\link{loopSample}()},
\code{\link{loopStart}()},
\code{\link{loopState}()},
\code{\link{name}},
\code{\link{playSample}()},
\code{\link{read.sample}()},
\code{\link{sampleLength}()},
\code{\link{volume}()},
\code{\link{waveform}()},
\code{\link{write.sample}()}
}
\author{
Pepijn de Vries
}
\concept{sample.operations}
