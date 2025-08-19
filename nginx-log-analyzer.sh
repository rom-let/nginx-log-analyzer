#! /bin/bash

logFile=${1}

getTopIps(){
	TopIps=$(awk '{print $1}' ${1} | sort | uniq -cd | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}') #can work this way too
}

getTopPaths(){
	TopPaths=$(cat ${1} | awk '{print $7}' | sort | uniq -cd | sort -nr | head -n5 | awk '{print $2 " - " $1 " requests"}')
}

getTopCodes(){
	TopCodes=$(cat ${1} | awk -F '"' '{print $3}' | awk '{print $1}' |  sort | uniq -cd | sort -nr | head -n5 | awk '{print $2 " - " $1 " requests"}')
	# Problem : not every code are at the same awk place. how to get only codes ? -> change field separator to the common separator of all cases (") then awk again to take only the field we’re interested in
}
getTopAgents(){
	TopAgents=$(cat ${1} | awk -F '"' '{print $6}' |  sort | uniq -cd | sort -nr | head -n5 | awk '{for(i=2;i<=NF;i++) printf "%s " , $i; print "- " $1 " requests"}')
}
getTopIps ${logFile}
getTopPaths ${logFile}
getTopCodes ${logFile}
getTopAgents ${logFile}

echo -e "\nTop 5 IP addresses with the most requests:\n${TopIps}" 
echo -e "\nTop 5 most requested paths:\n${TopPaths}"
echo -e "\nTop 5 response status codes:\n${TopCodes}"
echo -e "\nTop 5 user agents:\n${TopAgents}"
