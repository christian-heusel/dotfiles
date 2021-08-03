#!/bin/bash
#
# Developed by Fred Weinhaus 9/29/2018 .......... revised 9/29/2018
#
# ------------------------------------------------------------------------------
# 
# Licensing:
# 
# Copyright © Fred Weinhaus
# 
# My scripts are available free of charge for non-commercial use, ONLY.
# 
# For use of my scripts in commercial (for-profit) environments or 
# non-free applications, please contact me (Fred Weinhaus) for 
# licensing arrangements. My email address is fmw at alink dot net.
# 
# If you: 1) redistribute, 2) incorporate any of these scripts into other 
# free applications or 3) reprogram them in another scripting language, 
# then you must contact me for permission, especially if the result might 
# be used in a commercial or for-profit environment.
# 
# My scripts are also subject, in a subordinate manner, to the ImageMagick 
# license, which can be found at: http://www.imagemagick.org/script/license.php
# 
# ------------------------------------------------------------------------------
# 
####
#
# USAGE: videoglitch [-c colors] [-d distance] [-a amplitude ] [-n number] 
# [-t thickness] [-j jaggedness] [-r reseed] infile outfile
# 
# USAGE: videoglitch [-h|-help]
# 
# OPTIONS:
# 
# -c     colors         colors to use in channel separation; choices are: red-cyan, 
#                       green-magenta and blue-yellow; default=red-cyan
# -d     distance       separation distance of colors; integer (positive or negative); 
#                       default=-5
# -a     amplitude      amplitude of distortion; integer>=0; default=45
# -n     number         number of non-glitch spacer segments; integer>0; default=5
# -t     thickness      thickness (height) of non-glitch spacer segments; integer>=0; 
#                       default=25
# -j     jaggedness     jaggedness of glitches; integer>0; default=20
# -r     reseed         seed value for random number generator used for the glitches; 
#                       integer>=0; default=101
# 
###
# 
# NAME: VIDEOGLITCH 
# 
# PURPOSE: To apply a video glitch effect to an image.
# 
# DESCRIPTION: VIDEOGLITCH applies a video glitch effect to an image. The effect is 
# composed of two parts. The first part is to make a horizontal separation between 
# the red and cyan coloring channels. The second part is to add random horizontal 
# offsets. The random offsets are created from a one column random image with height 
# the same as the input image. Then random height constant gray segments are randomly  
# placed over and replacing parts of the random column image. This image is then  
# expanded horizontally to fill the the width of the input image and used as a 
# displacement map applied to the input image.
# 
# ARGUMENTS: 
# 
# -c colors ... COLORS to use in channel separation. The choices are: red-cyan (rc), 
# green-magenta (gm) and blue-yellow (by). The default=red-cyan.
# 
# -d distance ... DISTANCE is the separation distance of the red-cyan channels in the 
# output. Values are integers (positive or negative which controls the direction). 
# The default=-5.
# 
# -a amplitude ... AMPLITUDE of the horizontal distortion of the glitches. Values 
# are integers>=0. The default=45.
# 
# -n number ... NUMBER of non-glitch gray spacer segments in the displacement map. 
# Values are integers>0. The default=5.
# 
# -t thickness ... THICKNESS (or height) of the non-glitch spacer segments. Values 
# are integers>=0. The default=25.
# 
# -j jaggedness ... JAGGEDNESS of the glitches. Values are integers>0. The default=20.
# 
# -r reseed ... RESEED is the initial seed value for the random number generator. 
# Values are integers>=0. Default=101.
# 
# NOTE: This script is not designed for images with transparency.
# 
# CAVEAT: No guarantee that this script will work on all platforms, 
# nor that trapping of inconsistent parameters is complete and 
# foolproof. Use At Your Own Risk. 
# 
######
# 

# set default values
colors="red-cyan"
distance=-5
amplitude=45
number=5
thickness=25
jaggedness=20
reseed=101


# set directory for temporary files
dir="."    # suggestions are dir="." or dir="/tmp"

# set up functions to report Usage and Usage with Description
PROGNAME=`type $0 | awk '{print $3}'`  # search for executable on path
PROGDIR=`dirname $PROGNAME`            # extract directory of program
PROGNAME=`basename $PROGNAME`          # base name of program
usage1() 
	{
	echo >&2 ""
	echo >&2 "$PROGNAME:" "$@"
	sed >&2 -e '1,/^####/d;  /^###/g;  /^#/!q;  s/^#//;  s/^ //;  4,$p' "$PROGDIR/$PROGNAME"
	}
usage2() 
	{
	echo >&2 ""
	echo >&2 "$PROGNAME:" "$@"
	sed >&2 -e '1,/^####/d;  /^######/g;  /^#/!q;  s/^#*//;  s/^ //;  4,$p' "$PROGDIR/$PROGNAME"
	}


# function to report error messages
errMsg()
	{
	echo ""
	echo $1
	echo ""
	usage1
	exit 1
	}


# function to test for minus at start of value of second part of option 1 or 2
checkMinus()
	{
	test=`echo "$1" | grep -c '^-.*$'`   # returns 1 if match; 0 otherwise
    [ $test -eq 1 ] && errMsg "$errorMsg"
	}

# test for correct number of arguments and get values
if [ $# -eq 0 ]
	then
	# help information
   echo ""
   usage2
   exit 0
elif [ $# -gt 16 ]
	then
	errMsg "--- TOO MANY ARGUMENTS WERE PROVIDED ---"
else
	while [ $# -gt 0 ]
		do
			# get parameter values
			case "$1" in
		     -help)    # help information
					   echo ""
					   usage2
					   exit 0
					   ;;
			   	-c)    # colors
					   shift  # to get the next parameter
					   # test if parameter starts with minus sign 
					   errorMsg="--- INVALID COLORS SPECIFICATION ---"
					   checkMinus "$1"
					   colors=`echo "$1" | tr "[:upper:]" "[:lower:]"`
					   case "$colors" in
					   		red-cyan|rc) colors="red-cyan" ;;
					   		green-magenta|gm) colors="green-magenta" ;;
					   		blue-yellow|by) colors="blue-yellow" ;;
					   		*) errMsg "--- COLORS=$colors IS NOT A VALID CHOICE ---" ;;
					   esac
					   ;;
				-d)    # get distance
					   shift  # to get the next parameter
					   # test if parameter starts with minus sign 
					   errorMsg="--- INVALID DISTANCE SPECIFICATION ---"
					   #checkMinus "$1"
					   distance=`expr "$1" : '\([-0-9]*\)'`
					   [ "$distance" = "" ] && errMsg "--- DISTANCE=$distance MUST BE AN INTEGER ---"
					   ;;
				-a)    # get amplitude
					   shift  # to get the next parameter
					   # test if parameter starts with minus sign 
					   errorMsg="--- INVALID AMPLITUDE SPECIFICATION ---"
					   checkMinus "$1"
					   amplitude=`expr "$1" : '\([0-9]*\)'`
					   [ "$amplitude" = "" ] && errMsg "--- AMPLITUDE=$amplitude MUST BE A NON-NEGATIVE INTEGER ---"
					   ;;
				-n)    # get number
					   shift  # to get the next parameter
					   # test if parameter starts with minus sign 
					   errorMsg="--- INVALID NUMBER SPECIFICATION ---"
					   #checkMinus "$1"
					   number=`expr "$1" : '\([0-9]*\)'`
					   [ "$number" = "" ] && errMsg "--- NUMBER=$number MUST BE AN INTEGER ---"
					   test1=`echo "$number < 1" | bc`
					   [ $test1 -eq 1 ] && errMsg "--- NUMBER=$number MUST BE AN INTEGER GREATER THAN 0 ---"
					   ;;
				-t)    # get thickness
					   shift  # to get the next parameter
					   # test if parameter starts with minus sign 
					   errorMsg="--- INVALID THICKNESS SPECIFICATION ---"
					   checkMinus "$1"
					   thickness=`expr "$1" : '\([0-9]*\)'`
					   [ "$thickness" = "" ] && errMsg "--- THICKNESS=$thickness MUST BE A NON-NEGATIVE INTEGER ---"
					   ;;
				-j)    # get jaggedness
					   shift  # to get the next parameter
					   # test if parameter starts with minus sign 
					   errorMsg="--- INVALID JAGGEDNESS SPECIFICATION ---"
					   #checkMinus "$1"
					   jaggedness=`expr "$1" : '\([0-9]*\)'`
					   [ "$jaggedness" = "" ] && errMsg "--- JAGGEDNESS=$jaggedness MUST BE AN INTEGER ---"
					   test1=`echo "$jaggedness < 1" | bc`
					   [ $test1 -eq 1 ] && errMsg "--- JAGGEDNESS=$jaggedness MUST BE AN INTEGER GREATER THAN 0 ---"
					   ;;
				-r)    # get reseed
					   shift  # to get the next parameter
					   # test if parameter starts with minus sign 
					   errorMsg="--- INVALID RESEED SPECIFICATION ---"
					   checkMinus "$1"
					   reseed=`expr "$1" : '\([0-9]*\)'`
					   [ "$reseed" = "" ] && errMsg "--- RESEED=$reseed MUST BE A NON-NEGATIVE INTEGER ---"
					   ;;
				 -)    # STDIN and end of arguments
					   break
					   ;;
				-*)    # any other - argument
					   errMsg "--- UNKNOWN OPTION ---"
					   ;;
		     	 *)    # end of arguments
					   break
					   ;;
			esac
			shift   # next option
	done
	#
	# get infile and outfile
	infile="$1"
	outfile="$2"
fi

# test that infile provided
[ "$infile" = "" ] && errMsg "NO INPUT FILE SPECIFIED"

# test that outfile provided
[ "$outfile" = "" ] && errMsg "NO OUTPUT FILE SPECIFIED"


# setup temporary images
tmpA1="$dir/videoglitch_1_$$.mpc"
tmpB1="$dir/videoglitch_1_$$.cache"
trap "rm -f $tmpA1 $tmpB1; exit 0" 0
trap "rm -f $tmpA1 $tmpB1; exit 1" 1 2 3 15

# read the input image into the temporary cached image and test if valid
convert -quiet "$infile" +repage $tmpA1 ||
	echo "--- FILE $infile DOES NOT EXIST OR IS NOT AN ORDINARY FILE, NOT READABLE OR HAS ZERO size  ---"

# get input dimensions
WxH=`convert -ping $tmpA1 -format "%wx%h" info:`
wd=`echo $WxH | cut -dx -f1`
ht=`echo $WxH | cut -dx -f2`

# create random length lines for constant gray sections to overlay on random column image below 
draw_args="line 0,0"
for ((i=0; i<number; i++)); do
y1=`convert xc: -seed $reseed -format "%[fx:round(($i+1)*$ht/$number + (random()>0.5?1:-1)*$ht/(3*$number))]" info:`
y2=$((y1+$thickness))
draw_args="$draw_args 0,$y1 line 0,$y2"
reseed=$((11*reseed+13))
done
draw_args="$draw_args 0,$ht"
#echo "$draw_args"

# define extra channel swapping depending upon colors chosen
if [ "$colors" = "red-cyan" ]; then
	cproc=""
elif [ "$colors" = "green-magenta" ]; then
	cproc="-separate -swap 0,1 -combine"
elif [ "$colors" = "blue-yellow" ]; then
	cproc="-separate -swap 0,2 -combine"
fi


# Line1 - create stereo pair for offset
# Line2 - create 1 column grayscale random noise image
# Line3 - draw over the noise with constant gray sections
# Line4 - scale the 1 column image down to make more coarse then scale to fill out to image size in width and height
# Line5 - use line4 image as displacement map applied to the stereo image
# Line6 - save output

convert $tmpA1 \( +clone \) -colorspace gray -geometry ${distance}+0 -compose stereo -composite \
	\( -size 1x$ht xc: -seed $reseed +noise random -colorspace gray \
		-fill gray -draw "$draw_args" -alpha off \
		-scale x${jaggedness}% -scale ${wd}X${ht}! \) \
	-define compose:args=${amplitude},0 -compose displace -composite \
	$cproc \
	"$outfile"
	
exit 0



