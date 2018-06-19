#!/bin/bash

SEP="^#LOCAL_CHANGES$"
REPO_FILE=.config/i3/config
LOCAL_FILE=$HOME/${REPO_FILE}
TEMP_FILE=merge.tmp

sed -e "/${SEP}/q" ${REPO_FILE} > ${TEMP_FILE}
sed -e "0,/${SEP}/d" ${LOCAL_FILE} >> ${TEMP_FILE}
#mv ${TEMP_FILE} ${LOCAL_FILE}
