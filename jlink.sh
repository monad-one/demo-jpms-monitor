#!/bin/bash
set -e

echo "--- DELETING IMAGES ---"
rm -rf jdk-minimal
rm -rf jdk-monitor

echo ""
echo "--- DEPENDENCIES ON PLATFORM MODULES ---"
jdeps -summary -recursive \
	--module-path mods \
	--module monitor \
	--add-modules monitor.observer.alpha,monitor.observer.beta \
| grep java.

echo ""
echo "--- CREATE JAVA.BASE IMAGE ---"
jlink \
	--output jdk-base \
	--module-path /opt/jdk-9/jmods \
	--add-modules java.base

echo ""
echo "--- LIST JAVA.BASE IMAGE MODULES ---"
jdk-base/bin/java --list-modules

echo ""
echo "--- CREATE MONITOR IMAGE ---"
jlink \
	--output jdk-monitor \
	--module-path /opt/jdk-9/jmods:mods \
	--add-modules monitor,monitor.observer.alpha,monitor.observer.beta \
	--launcher monitor=monitor

echo ""
echo "--- LIST MONITOR IMAGE MODULES ---"
jdk-monitor/bin/java --list-modules

echo ""
echo "--- LAUNCH MONITOR IMAGE MODULES ---"
jdk-monitor/bin/monitor
