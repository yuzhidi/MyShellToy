#!/bin/sh
echo "please input file type:"
read input
found=
type=`gawk '{print $1}' folders.txt`

for i in $type;
	do echo $i;
	if [[ $input = $i ]]
		then found=$i
	fi
done

if [ -z $found ]
	then  echo "not found!"
	exit 1
fi

echo $found
name=`grep $found folders.txt | gawk '{print $2}'`
#name=`gawk '/$found/ {print $2}' folders.txt`
#name=`gawk ' {print $2}' folders.txt`
echo "actual folder:" $name

if [ -d $name ]
	then echo $name "is exist!"
else
	echo $name "is NOT exist!"
fi
# check the time is older than 7 days

#if you are super user
#rm $name -rf
