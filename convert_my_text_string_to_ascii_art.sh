#!/usr/bin/env bash
###
###  convert my text string to ascii art
###

if [ -n "$1" ]; then
    MYSTR=$1
fi

if [ -n "$2" ]; then
    LEADCHAR=$2
fi

echo ${MYSTR:=HELLO} ${MYSTR}
echo ${LEADCHAR:=20} ${LEADCHAR}

#dummyLine=$(printf %80s |tr " " " ")
dummyLine=$(printf %80s)

toilet -f bigascii12  "${MYSTR}" > .logo_main
echo -e "$dummyLine" >>  .logo_main
echo -e "$dummyLine" >>  .logo_main
echo -e "$dummyLine" >>  .logo_main
echo -e "$dummyLine" >>  .logo_main

tr ' #' '] ' < .logo_main  > .logo_back

tr '#' ']' < .logo_main > .logo_front

MAXLINE=$(wc -c <<< $(head -n1 .logo_main))
echo MAXLINE= ${MAXLINE}


CNT1=${LEADCHAR}; CNT2=0; while read -r -u 4 line1 && read -r -u 5 line2; do IFS='P'; echo -e "  printf(\"${line1:0:$((MAXLINE-CNT1))} ${line2:$((MAXLINE-${CNT1}-0)):$((CNT1))}\\\n\");"; ((CNT1++)); ((CNT2++)); done 4<.logo_back 5<.logo_front > logo_final

read
### output texts
cat .logo_main .logo_front .logo_back

### delete temp files
#rm -f .logo_main .logo_front .logo_back
