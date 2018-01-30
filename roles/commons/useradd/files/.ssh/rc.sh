#!/bin/bash

url="https://hooks.slack.com/services/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"

readonly USER=`whoami`
readonly HOST=`hostname`

ip=`who | awk '{print $5}' | cut -d '(' -f 2 | sed -e 's/)//g'`
user=`w -hsi | awk '{print $1}'`
day=`lastlog | grep -w "${USER}" | awk '{print $4}'`
month=`lastlog | grep -w "${USER}" | awk '{print $5}'`
date=`lastlog | grep -w "${USER}" | awk '{print $6}'`
time=`lastlog | grep -w "${USER}" | awk '{print $7}'`

payload="payload={
  \"attachments\": [
    {
      \"color\": \"#36a64f\",
            \"title\": \"SSH Connection has established.\",
      \"fallback\": \"SSH Connection has established.\",
      \"fields\": [
        {
          \"title\": \"HOSTNAME\",
          \"value\": \"${HOST}\",
          \"short\": true
        },
        {
          \"title\": \"Date / Time\",
          \"value\": \"${month} ${date} (${day})  ${time}\",
          \"short\": true
        },
                {
                  \"title\": \"User Name\",
                  \"value\": \"${user}\",
                  \"short\": true
                },
        {
          \"title\": \"from\",
          \"value\": \"${ip}\",
          \"short\": true
        }
      ]
    }
  ]
}"

curl -m 5 --data-urlencode "${payload}" "${url}" > /dev/null 2>&1
