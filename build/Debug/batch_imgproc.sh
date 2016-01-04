#!/bin/sh
# image_process.sh - usage: ./image_process.sh root_dir

ROOTDIR=$1
IMGDIR=$ROOTDIR"ScreenShot"
COMMAND="./cvutils"

function valid {
if [[ ! -d "$1" ]]; then
	mkdir $1
fi
}

contour_folder=`echo $IMGDIR | sed 's/ScreenShot/Contours\//'`
valid $contour_folder
marks_folder=`echo $IMGDIR | sed 's/ScreenShot/Marks\//'`
valid $marks_folder

function call_utils {
    if [[ -e "$1" ]];then
        $COMMAND $2 
    fi
}

for src_file in `find $IMGDIR -type f -regex ".*\.bmp"`;do
    echo $src_file
	dst_file=`echo $src_file | sed 's/ScreenShot/Body/'`
    call_utils $dst_file "contours $src_file $dst_file -dst=$contour_folder"
	position_txt=`echo $src_file | sed 's/ScreenShot/Position/' | sed 's/.*/&\.txt/'` 
    call_utils $position_txt "marks $src_file -text=$position_txt -dst=$marks_folder" 
#    	if [[ -e "$dst_file" ]]; then
#    		$COMMAND contours $src_file $dst_file -dst=$contour_folder
#    	fi
#    	position_txt=`echo $src_file | sed 's/ScreenShot/Position/' | sed 's/.*/&\.txt/'` 
#    	if [[ -e "$position_txt" ]]; then
#    		$COMMAND marks $src_file -text=$position_txt -dst=$marks_folder
#    	fi
done
