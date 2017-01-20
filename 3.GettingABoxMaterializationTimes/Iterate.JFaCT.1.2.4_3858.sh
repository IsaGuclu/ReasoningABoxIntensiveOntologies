#!/bin/bash
file="/home/ktgroup/Desktop/isa/ScriptsJars/files_3858.txt"
while IFS= read -r line
do
	echo "Processing $line"
	timeout 30m java -Xss1g -Xms2g -Xmx10g -cp JFaCT.1.2.4.jar TimeHarvester /home/ktgroup/Desktop/isa/Datasets/3858/$line
        if [$? -eq 124]; then
		echo "$line timeout">>"/home/ktgroup/Desktop/isa/ScriptsJars/JFaCT_timesout_3858.txt"
	fi
done <"$file"