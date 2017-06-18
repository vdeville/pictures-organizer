#!/usr/bin/env sh

# Colors:
COLORRESET="\033[0m"
COLORBOLD="\033[1m"
COLORLIGHTRED="\033[91m"
COLORLIGHYELLOW="\033[93m"
COLORLIGHGREEN="\033[92m"
COLORLIGHCYAN="\033[96m"

# Check the path if properly given
if [ $# -eq 0 ]
  then
    echo "${COLORLIGHCYAN}============================================${COLORRESET}"
    echo " ${COLORLIGHYELLOW}Please specify the folder path of pictures ${COLORRESET}"
    echo "${COLORLIGHCYAN}============================================${COLORRESET}"
    echo ""
    echo "Ex: ./script.sh /path/to/pictures/"
    echo ""
    exit
fi


echo "${COLORLIGHYELLOW}Are sure you had sort all .JPG files ? (${COLORLIGHGREEN}yes${COLORRESET} ${COLORLIGHYELLOW}/ ${COLORLIGHTRED}no${COLORLIGHYELLOW})${COLORRESET}"
read areyousure

if [ ${areyousure} != "yes" ]
then
    exit 0
fi

BASEDIR=${1}

JPGFILES=${BASEDIR}/jpg/
RAWFILES=${BASEDIR}/raw/
JUNKFILES=${BASEDIR}/junk/

KEEPCOUNTDOWN=0
JUNKCOUNTDOWN=0

mkdir -p ${JPGFILES}
mkdir -p ${RAWFILES}
mkdir -p ${JUNKFILES}

# For each pictures in folder
for file in ${BASEDIR}*
do
  file=$(basename ${file})
  extension="${file##*.}"
  filename="${file%.*}"

  # Check JPG files
  if [ "$extension" == "JPG" ] ; then
      mv ${BASEDIR}${filename}.JPG ${JPGFILES}
      mv ${BASEDIR}${filename}.CR2 ${RAWFILES}
      ((KEEPCOUNTDOWN++))
  fi
done

# Junk all residual files
for file in ${BASEDIR}*
do
  if [ -f ${file} ] ; then
    mv ${file} ${JUNKFILES}
    ((JUNKCOUNTDOWN++))
  fi
done

echo "${COLORLIGHGREEN}${COLORBOLD}${KEEPCOUNTDOWN}${COLORRESET}${COLORLIGHGREEN} saved pictures ${COLORRESET}"
echo "${COLORLIGHTRED}${COLORBOLD}${JUNKCOUNTDOWN}${COLORRESET}${COLORLIGHTRED} deleted pictures ${COLORRESET}"

exit 0


