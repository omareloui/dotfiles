#!/usr/bin/env bash

src="$1"
output="$(basename "$src" .pdf).compressed.pdf"

if [[ ! -f "$src" ]]; then
	echo "You have to provide source file."
	exit 1
fi

gs \
	-q \
	-dNOPAUSE \
	-dBATCH \
	-dSAFER \
	-sDEVICE=pdfwrite \
	-dCompatibilityLevel=1.4 \
	-dNOTRANSPARENCY \
	-dPDFSETTINGS=/screen \
	-dEmbedAllFonts=true \
	-dSubsetFonts=true \
	-dColorImageDownsampleType=/Bicubic \
	-dColorImageResolution=144 \
	-dGrayImageDownsampleType=/Bicubic \
	-dGrayImageResolution=144 \
	-dMonoImageDownsampleType=/Bicubic \
	-dMonoImageResolution=144 \
	-sOutputFile="$output" \
	"$src"
