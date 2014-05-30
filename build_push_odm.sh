#! /bin/sh
###########################################################
# this script is used for build HiCamera apk for different
# branch
#
#
############################################################

YYMMDDMMSS=

function funPirnt() {
	echo 'test func'
}

GITCB="git rev-parse --abbrev-ref HEAD"
CameraRemoteBranch="m4_ss4020"
CameraPath="$HOME/work/HiCamera3.0"
ProjectPath="/mnt/sdc1/sz_SS4020"
ProjectBranch=

ERROR_STRING_0="the branch is not right!! exit!"

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

if [[ $CameraRemoteBranch != $HiCameraBranch ]]
	then
		echo -e "\033[31m$ERROR_STRING_0\033[0m"
		exit 1
fi


echo -e "\033[33m###########################################################
 Enter project
###########################################################"
echo -ne "\033[0m";

cd $ProjectPath
PWD=`pwd`
echo $PWD
ProjectPath=`$GITCB`
echo $ProjectPath



funPirnt
