#! /bin/sh
###########################################################
# this script is used for build HiCamera apk for different
# branch
#
#
############################################################

YYMMDDMMSS=
APKNAME_TEL=
APKNAME_CARLO=

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

Project_Out="out/target/product/ckt82_we_jb5/system/app/"
function funcBuild() {
    #update files #build
	APKNAME_TEL=Gallery2.apk_$YYMMDDMMSS
	echo  -e "\033[33mAPKNAME_TEL=$APKNAME_TEL\033[0m"

    ./touchHiCameraGallery2.sh && ./mkGallery2.sh && \
    mv "$Project_Out"Gallery2.apk "$Project_Out"$APKNAME_TEL && \
    md5sum "$Project_Out"$APKNAME_TEL
}

function funcBuildCarlo() {
    #update files #build
    APKNAME_CARLO=Gallery2.apk_"$YYMMDDMMSS"_carlo
	echo  -e "\033[33mAPKNAME_TEL=$APKNAME_CARLO\033[0m"

    ./touchHiCameraGallery2.sh && ./mkGallery2.sh && \
    mv "$Project_Out"Gallery2.apk "$Project_Out"$APKNAME_CARLO && \
    md5sum "$Project_Out"$APKNAME_CARLO
}
# cmd shorten
GITCB="git rev-parse --abbrev-ref HEAD"

tmpBranch=

# camera branch

CameraPath="$HOME/work/HiCamera3.0/"

#TODO argument project name, help list project
#4020
#CameraRemoteBranch="m4_ss4020"
#CameraCarloIconCommit="60dc6be"

#4040
CameraRemoteBranch="m4_SS4040"
CameraCarloIconCommit="ff99e2d"


# project branch

#4020
#ProjectPath="/mnt/sdc1/sz_SS4020/"
#ProjectRemoteBranch="CD_QSLFW01_S10A_SOURCE"
#ProjectCarloIconCommit="14622f5"

#4040
ProjectPath="/mnt/sdc1/sz_ss4040/"
ProjectRemoteBranch="cd_slfqplus_s10a_source"
ProjectCarloIconCommit="70738df"

ProjectTelcelCommit1="a6846cb"  # [Fix Bug][SS4040 Telcel (slfqplus_s10a)][SmartPause_B03][The Smart pause is active by default but this not works the first time
ProjectTelcelCommit2="f03a4d9"  #[Description]解决墨西哥反馈的问题2: Take a photo and in dowloads pictures > options > details > Please change the format date > For the format dd month year.

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

#echo rm
ls "$Project_Out"app/Gallery2.apk_*
rm "$Project_Out"app/Gallery*
#rename apk ?? for push ?? or push after echo build?
funcBuild

# DEBUG
# exit 0

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

git revert $ProjectTelcelCommit1 -n

git commit -m "git revert $ProjectTelcelCommit1 for $ProjectRemoteBranch build carlo"

git revert $ProjectTelcelCommit2 -n

git commit -m "git revert $ProjectTelcelCommit2 for $ProjectRemoteBranch build carlo"
#build
funcBuildCarlo

echo -e "\033[33m###########################################################
push 10 apks
###########################################################"
echo -ne "\033[0m";

M4_PROJECT_PUSH_PATH="/mnt/sdc1/ss4040/mt6582_jb5/"

#cp 10a apk
M4_4040_10A="cd_slfqplus_s10a"
cd $M4_PROJECT_PUSH_PATH
pwd

CurPushBranch=`$GITCB`
echo "CurPushBranch:$CurPushBranch"

if [[ $M4_4040_10A != $CurPushBranch ]]
	then
		echo -e "\033[31m$ERROR_STRING_0\033[0m"
		git checkout $M4_4040_10A
fi

git pull

M4_TEMP_BRANCH="$M4_4040_10A"_$YYMMDDMMSS
git checkout -b $M4_TEMP_BRANCH

Goldsand_Gallery2="goldsand/app/Gallery2/Gallery2.apk"

cp $ProjectPath$Project_Out$APKNAME_TEL $Goldsand_Gallery2

md5sum $Goldsand_Gallery2
git add $Goldsand_Gallery2

git commit -m "push  $ProjectPath$Project_Out$APKNAME_TEL "

git push origin "$M4_TEMP_BRANCH":refs/for/$M4_4040_10A



echo -e "\033[33m###########################################################
push 11 apks
###########################################################"
echo -ne "\033[0m";
#CP 11a apk

M4_4040_S11A="cd_slfqplus10a_s11a"
git checkout $M4_4040_S11A

git pull

M4_TEMP_BRANCH="$M4_4040_S11A"_$YYMMDDMMSS
git checkout -b $M4_TEMP_BRANCH

cp $ProjectPath$Project_Out$APKNAME_CARLO $Goldsand_Gallery2

md5sum $Goldsand_Gallery2
git add $Goldsand_Gallery2

git commit -m "push $ProjectPath$Project_Out$APKNAME_CARLO"

git push origin "$M4_TEMP_BRANCH":refs/for/$M4_4040_S11A






