#!/bin/bash

echo ""
echo "--- LAUNCH ---"

echo " > run monitor"
echo ""

# the classpath is needed for Spark's dependencies
# (because spark.core is an automatic module and actually required,
#  monitor.observer.zero would be resolved as well and does not need
#  to be added explicitly; it is still done for clarity)
java9 \
	--module-path mods \
	--class-path "libs/*" \
	--add-modules monitor.observer.zero \
	--module monitor
