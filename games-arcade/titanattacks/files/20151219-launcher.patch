--- titanattacks.sh	2015-12-18 19:13:46.000000000 -0500
+++ titanattacks.patched.sh	2017-10-15 20:11:09.032148605 -0400
@@ -7,47 +7,16 @@
 SCRIPT="`basename \"$0\"`"
 GAMEDIR="${HOME}/.titan_attacks"
 LOGFILE="${GAMEDIR}/${SCRIPT}.log"
-INSTDIR="`dirname \"$0\"`" ; cd "${INSTDIR}" ; INSTDIR="`pwd`"
+INSTDIR="/opt/titanattacks-20151219"
+cd "${INSTDIR}"
 
 [[ ! -d "${GAMEDIR}" ]] && mkdir -m 0755 "${GAMEDIR}"
 
-if [ 1 == 0 ]
-then
-	# 32 bit only
-	JVM="./bin/java32"
-	BOOTCLASSPATH="./lib/rt32.jar"
-
-elif [ `uname -m` == "i686" ]
-then
-	JVM="./bin/java32"
-	BOOTCLASSPATH="./lib/rt32.jar"
-
-	# Decompress JVM on first run
-	if [ ! -d "bin" ]
-	then
-		./7za_i386 x jvm.7z
-		chmod u+x bin/java32
-		rm -f 7za_* jvm.7z
-	fi
-else
-	JVM="./bin/java64"
-	BOOTCLASSPATH="./lib/rt64.jar"
-
-	# Decompress JVM on first run
-	if [ ! -d "bin" ]
-	then
-		./7za_amd64 x jvm.7z
-		chmod u+x bin/java64
-		rm -f 7za_* jvm.7z
-	fi
-fi
-
 # XMODIFIERS is cleared here to prevent SCIM screwing up keyboard input
-_JAVA_OPTIONS= XMODIFIERS= "${JVM}" \
+_JAVA_OPTIONS= XMODIFIERS= "java" \
     -server \
-    -Xbootclasspath/p:${BOOTCLASSPATH} \
     -Djava.library.path="${INSTDIR}" \
-    -Dorg.lwjgl.librarypath="${INSTDIR}" \
+    -Dorg.lwjgl.librarypath="/usr/lib64/lwjgl-2.9" \
     -Dorg.lwjgl.util.NoChecks=false \
     -Djava.net.preferIPv4Stack=true \
     -Dnet.puppygames.applet.Launcher.resources=resources-hib.dat \
