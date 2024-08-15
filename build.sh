#!/bin/bash
if [[ "$*" =~ -b ]]; then
./mvnw verify
fi

if [[ "$*" =~ -U ]]; then
    jars_file="JARS.txt"
    jarArray=($(<"$jars_file"))
  OPENFIRE_PLUGINS="http://161.35.28.94:8081/artifactory/simple/appx-maven-release/co/kartngo"
  ary=($JARS)

  jars_file="JARS.txt"
  if [[ ! -f "$jars_file" ]]; then
      echo "Missing $jars_file !"
      exit 1
  fi
  for jarPath in "${jarArray[@]}"; do
    echo "Downloading Jar : $jarPath"
    jarFile="${jarPath%%/*}"
    jarFile="${jarFile}.jar"
    echo $jarFile
    wget --user $REPO_USER --password $REPO_PASS -O distribution/target/distribution-base/plugins/$jarFile "${OPENFIRE_PLUGINS}/$jarPath"
  done
fi


docker build -t samehkartngo/openfire:dev .
