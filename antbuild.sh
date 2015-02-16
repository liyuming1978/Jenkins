#!/bin/bash
function checkerror()
{
	if [ $? -ne "0" ] ; then
		exit 1
	fi
}

#---------------------------------------------------------------------------------------------
/home/lym/android-sdk-linux/tools/android update project -p ${WORKSPACE} -n hevcplayer -t 1
sync
sed -i '$d' build.xml
echo "    <import file=\"findbugs_ant.xml\" />" >> build.xml
#echo "    <import file=\"ndk-build.xml\" />" >> build.xml
echo "</project>" >> build.xml

/home/lym/android-sdk-linux/tools/lint --xml ${WORKSPACE}/lint-results.xml ${WORKSPACE}

if [ -d ${WORKSPACE}/jni/ ]
then
	cppcheck ${WORKSPACE}/jni -j4 --enable=all --xml 2> ${WORKSPACE}/cppcheck-result.xml
	/home/lym/work/android-ndk-r10c/ndk-build -B
	checkerror
fi

ant clean debug findbugs
checkerror
