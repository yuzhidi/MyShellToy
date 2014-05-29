#! /Bin/sh
###########################################################
# this script is used for build HiCamera apk for different
# branch
#
#
############################################################
echo "###########################################################
 this script is used for build HiCamera apk for different branch
###########################################################"

CameraWorkingBranch="m4_ss4020"
CameraPath="$HOME/work/HiCamera3.0"
ProjectPath="/mnt/sdc1/sz_SS4020"

#printf "%s\n" "$HOME"
CMD="cd $CameraPath"
#'A Practice guide to linux' 8.3.1 said, '',"",is different
#CMD='cd $HOME/work/HiCamera3.0' # wrong
#CMD="'cd' $HOME'/work/HiCamera3.0'" # wrong
echo $CMD
$CMD
CMD="git rev-parse --abbrev-ref HEAD"
echo $CMD
HiCameraBranch=`$CMD`
echo $HiCameraBranch


