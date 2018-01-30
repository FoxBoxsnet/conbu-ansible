#!/bin/bash

WEBHOOKURL="https://hooks.slack.com/services/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"


MESSAGEFILE=$(mktemp)
cat $1 > ${MESSAGEFILE}
CHANNEL="web-mgnt-notice"
BOTNAME="bot test"
FACEICON=":raising_hand:"
TMPFILE1=$(mktemp)
TMPFILE2=$(mktemp)
TIMESTAMP=`date +%s`


MESSAGE_FROM=`cat ${MESSAGEFILE} | grep -m 1 -e 'From:.*' | sed -e 's/^From:\s//'`
MESSAGE_TO=`cat ${MESSAGEFILE} | grep -e '^To:\s.*' | sed -e 's/^To:\s//'`
MESSAGE_SUBJECT=`cat ${MESSAGEFILE} | grep -m 1 -e 'Subject:' | sed -e 's/^Subject: //'`

cat ${MESSAGEFILE} | grep -m 1 'Status:.*' -A 1000 | sed -e 's/^Status:.*//' > ${TMPFILE1}
cat ${TMPFILE1} | tr '\n' '\\' | sed 's/\\/\\n/g' > ${TMPFILE2}
MESSAGE_BODY=$(cat ${TMPFILE2})

payload="payload={
  \"attachments\": [
    {
      \"color\": \"good\",
      \"fields\": [
        {
            \"title\": \"From:\",
            \"value\": \"${MESSAGE_FROM}\",
            \"short\": true
        },
        {
            \"title\": \"To:\",
            \"value\": \"${MESSAGE_TO}\",
            \"short\": true
        },
        {
            \"title\": \"Subject:\",
            \"value\": \"${MESSAGE_SUBJECT}\",
            \"short\": false
        }
      ]
    },
    {
      \"title\": \"Message Body:\",
      \"text\": \"${MESSAGE_BODY}\",
      \"footer\": \"Forward mail to Slack\",
      \"ts\": \"${TIMESTAMP}\"
    }
  ]
}"

curl -s -S -X POST --data-urlencode "${payload}" "${WEBHOOKURL}" >/dev/null

if [ -f "${MESSAGEFILE}" ] ; then
    rm -f ${MESSAGEFILE}
fi

if [ -f "${TMPFILE1}" ] ; then
    rm -f ${TMPFIL1}
fi

if [ -f "${TMPFIL2}" ] ; then
    rm -f ${TMPFILE2}
fi

exit 0
