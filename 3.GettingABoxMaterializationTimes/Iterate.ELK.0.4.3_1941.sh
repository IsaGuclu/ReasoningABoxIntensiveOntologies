#!/bin/bash
file="/home/ktgroup/Desktop/isa/ScriptsJars/files_1941.txt"
while IFS= read -r line
do
	echo "Processing $line"
	timeout 30m java -Xss1g -Xms2g -Xmx10g -cp ELK.0.4.3.jar TimeHarvester /home/ktgroup/Desktop/isa/Datasets/1941/$line
        if [$? -eq 124]; then
		echo "$line timeout">>"/home/ktgroup/Desktop/isa/ScriptsJars/ELK_timesout_1941.txt"
	fi
done <"$file"