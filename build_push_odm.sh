#! /bin/sh
###########################################################
# this script is used for build HiCamera apk for different
# branch
#
#
############################################################

GITCB="git rev-parse --abbrev-ref HEAD"
CameraWorkingBranch="m4_ss4020"
CameraPath="$HOME/work/HiCamera3.0"
ProjectPath="/mnt/sdc1/sz_SS4020"
ProjectBranch=
echo -e "\033[33m###########################################################
 check HiCamera3.0 branch
###########################################################"
echo -ne "\033[0m";
#printf "%s\n" "$HOME"
CMD="cd $CameraPath"
#'A Practice guide to linux' 8.3.1 said, '',"",is different
#CMD='cd $HOME/work/HiCamera3.0' # wrong
#CMD="'cd' $HOME'/work/HiCamera3.0'" # wrong
echo $CMD
$CMD

HiCameraBranch=`$GITCB`
echo $HiCameraBranch

echo -e "\033[33m###########################################################
 inter project
###########################################################"
echo -ne "\033[0m";

cd $ProjectPath
PWD=`pwd`
echo $PWD
ProjectPath=`$GITCB`
echo $ProjectPath
