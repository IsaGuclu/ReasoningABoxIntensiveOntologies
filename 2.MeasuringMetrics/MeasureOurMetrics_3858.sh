#!/bin/bash
folder="/home/ktgroup/Desktop/isa/Datasets/3858/"
newFileName="OurMetrics.csv"
java -Xss1g -Xms2g -Xmx10g -cp OWL2Predictions.jar sid.owl2predictions.utils.DirectoryStatistics $folder
java -Xss1g -Xms2g -Xmx10g -cp OWL2Predictions.jar sid.owl2predictions.utils.ComplexityMetricsDirectoryCalculator $folder $newFileName