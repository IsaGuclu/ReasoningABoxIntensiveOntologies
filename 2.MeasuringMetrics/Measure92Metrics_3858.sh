#!/bin/bash
folder="/home/ktgroup/Desktop/isa/Datasets/3858/"
java -Xss1g -Xms2g -Xmx10g -cp Metrics92.jar edu.monash.infotech.owl2metrics.imports.Metrics92Harvester $folder