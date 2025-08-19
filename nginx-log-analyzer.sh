#! /bin/bash

logFile=${1}

getTopIps(){
	TopIps=$(awk '{print $1}' ${1} | sort | uniq -cd | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}') #can work this way too
}

getTopPaths(){
	TopPaths=$(cat ${1} | awk '{print $7}' | sort | uniq -cd | sort -nr | head -n5 | awk '{print $2 " - " $1 " requests"}')
}

getTopCodes(){
	echo "test"
	TopCodes=$(cat ${1} | awk -F '"' '{print $3}' | awk '{print $1}' |  sort | uniq -cd | sort -nr | head -n5 | awk '{print $2 " - " $1 " requests"}')
	# Problem : not every code are at the same awk place. how to get only codes ? -> change field separator to the common separator of all cases (") then awk again to take only the field we’re interested in
}

getTopIps ${logFile}
getTopPaths ${logFile}
getTopCodes ${logFile}
echo -e "\nTop 5 IP addresses with the most requests:\n${TopIps}" 
echo -e "\nTop 5 most requested paths:\n${TopPaths}"
echo -e "\nTop 5 response status codes:\n${TopCodes}"
