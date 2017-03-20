#!/bin/bash

echo ""
echo "--- LAUNCH ---"

echo " > dry-run monitor"
echo ""

# the classpath is needed for Spark's dependencies;
# add the optional dependency stats.fancy
java9 \
	--module-path mods \
	--class-path "libs/*" \
	--add-modules stats.fancy \
	--dry-run \
	--module monitor
