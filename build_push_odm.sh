#! /bin/sh
#printf "%s\n" "$HOME"
CMD="cd $HOME/work/HiCamera3.0"
#'A Practice guide to linux' 8.3.1 said, '',"",is different
#CMD='cd $HOME/work/HiCamera3.0' # wrong
#CMD="'cd' $HOME'/work/HiCamera3.0'" # wrong
echo $CMD
$CMD
CMD="git branch |grep \*"
echo $CMD
HiCameraBranch=`$CMD`
