#!/bin/bash
javac -source 1.6 -target 1.6 -d . -classpath /usr/share/processing/core/library/core.jar src/*.java
jar -cf library/gifAnimation.jar gifAnimation

