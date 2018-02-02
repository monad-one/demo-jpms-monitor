#!/bin/bash
set -e

echo "--- COMPILATION & PACKAGING ---"

echo " > creating clean directories"
rm -rf classes
mkdir classes
rm -rf mods
mkdir mods
rm -rf mods-gamma
mkdir mods-gamma

echo " > creating monitor.observer"
javac9 \
	-d classes/monitor.observer \
	$(find monitor.observer -name '*.java')
jar9 --create \
	--file mods/monitor.observer.jar \
	-C classes/monitor.observer .

echo " > creating monitor.observer.alpha"
javac9 \
	--module-path mods \
	-d classes/monitor.observer.alpha \
	$(find monitor.observer.alpha -name '*.java')
jar9 --create \
	--file mods/monitor.observer.alpha.jar \
	-C classes/monitor.observer.alpha .


echo " > creating monitor.observer.beta"
javac9 \
	--module-path mods \
	-d classes/monitor.observer.beta \
	$(find monitor.observer.beta -name '*.java')
jar9 --create \
	--file mods/monitor.observer.beta.jar \
	-C classes/monitor.observer.beta .


echo " > creating monitor.observer.gamma"
javac9 \
	--module-path mods \
	-d classes/monitor.observer.gamma \
	$(find monitor.observer.gamma -name '*.java')
jar9 --create \
	--file mods-gamma/monitor.observer.gamma.jar \
	-C classes/monitor.observer.gamma .


echo " > creating monitor.observer.zero (plain JAR)"
javac9 \
	--class-path 'mods/*' \
	-d classes/monitor.observer.zero \
	$(find monitor.observer.zero -name '*.java')
cp -r monitor.observer.zero/src/main/resources/META-INF classes/monitor.observer.zero
jar9 --create \
	--file mods/monitor.observer.zero.jar \
	-C classes/monitor.observer.zero .


echo " > creating monitor.statistics"
javac9 \
	--module-path mods \
	-d classes/monitor.statistics \
	$(find monitor.statistics -name '*.java')
jar9 --create \
	--file mods/monitor.statistics.jar \
	-C classes/monitor.statistics .

echo " > creating monitor.persistence"
javac9 \
	--module-path mods \
	-d classes/monitor.persistence \
	$(find monitor.persistence -name '*.java')
jar9 --create \
	--file mods/monitor.persistence.jar \
	-C classes/monitor.persistence .

echo " > creating monitor.rest"
# spark is required as an automatic module, so copy it to mods
cp libs/spark-core-* mods/spark.core.jar
javac9 \
	--module-path mods \
	-d classes/monitor.rest \
	$(find monitor.rest -name '*.java')
jar9 --create \
	--file mods/monitor.rest.jar \
	-C classes/monitor.rest .

echo " > creating monitor"
javac9 \
	--module-path mods \
	-d classes/monitor \
	$(find monitor -name '*.java')
jar9 --create \
	--file mods/monitor.jar \
	--main-class monitor.Main \
	-C classes/monitor .
