#! /bin/sh
###########################################################
# this script is used for build HiCamera apk for different
# branch
#
#
############################################################

YYMMDDMMSS=

function funGetTime() {
	yy=`date +%Y`
	mm=`date +%m`
	dd=`date +%d`
	FF=`date +%F`
	HH=`date +%H`
	MM=`date +%M`
	SS=`date +%S`
	YYMMDDMMSS=$FF-$HH$MM$SS
}

# cmd shorten
GITCB="git rev-parse --abbrev-ref HEAD"

tmpBranch=

# camera branch
CameraRemoteBranch="m4_ss4020"
CameraCarloIconCommit="60dc6be"
CameraPath="$HOME/work/HiCamera3.0"

# project branch
ProjectPath="/mnt/sdc1/sz_SS4020"
ProjectRemoteBranch="CD_QSLFW01_S10A_SOURCE"
ProjectCarloIconCommit="14622f5"

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

curBranch=`$GITCB`
echo $curBranch

# If NOT need check branch, commt out
# TODO: add paramters to open/close branch check
if [[ $CameraRemoteBranch != $curBranch ]]
	then
		echo -e "\033[31m$ERROR_STRING_0\033[0m"
		git checkout $CameraRemoteBranch
		exit 1
fi

#get latest code
git pull

funGetTime
tmpBranch=$curBranch-$YYMMDDMMSS
echo "create temp branch:$tmpBranch"
git checkout -b $tmpBranch

echo -e "\033[33m###########################################################
 Enter project
###########################################################"
echo -ne "\033[0m";

cd $ProjectPath
PWD=`pwd`
echo $PWD

curBranch=`$GITCB`
echo $curBranch
# If NOT need check branch, commt out
# TODO: add paramters to open/close branch check
if [[ $ProjectRemoteBranch != $curBranch ]]
	then
		echo -e "\033[31m$ERROR_STRING_0\033[0m"
		git checkout $ProjectRemoteBranch
		exit 1
fi

# git pull by needed
# git pull

tmpBranch=$curBranch-$YYMMDDMMSS
echo "create temp branch:$tmpBranch"
git checkout -b $tmpBranch

echo -e "\033[33m###########################################################
build project
###########################################################"
echo -ne "\033[0m";

#update files
sh  touchHiCameraGallery2.sh

#build

#rename apk ?? for push ?? or push after echo build?

echo -e "\033[33m###########################################################
build carlo
###########################################################"
echo -ne "\033[0m";

cd $CameraPath
git revert $CameraCarloIconCommit -n

#commit if need
git commit -m "revert $CameraCarloIconCommit for $CameraRemoteBranch build carlo"

cd $ProjectPath
git revert $ProjectCarloIconCommit -n

git commit -m "git revert $ProjectCarloIconCommit for $ProjectRemoteBranch build carlo"

#build


echo -e "\033[33m###########################################################
push apks
###########################################################"
echo -ne "\033[0m";


#cp 10a apk

#cp 11a apk
