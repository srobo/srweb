#!/bin/bash
git log --format='%aN <%aE>' | 
	awk '{arr[$0]++} END{for (i in arr){print arr[i], i;}}' | 
	grep -v BRIAN | 
	sort -rn | 
	grep -v "fail@studentrobotics.org" | 
	cut -d\  -f2- > AUTHORS

if [ "$1" == "-e" ]
then
	nano AUTHORS
fi
