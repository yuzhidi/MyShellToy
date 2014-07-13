#!/bin/bash
git status . > gitstatout
cat -n gitstatout
read input
for i in $input
	do
		if [ $i -gt 0 ];then
			echo "$i is number"
		else
			echo "$i is not number"
			# regular express to get %d-%d lines
		fi
	done

