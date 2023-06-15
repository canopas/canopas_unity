 file='VERSION'
 fileData=`cat $file`
 IFS='.'
 read -a versionValue <<< "$fileData"
 buildNumber=$(( ${versionValue[0]} * 1000000 + ${versionValue[1]} * 10000 + ${{ github.run_number }} ))
 IFS=''
 buildName="${versionValue[0]}.${versionValue[1]}.${{ github.run_number }}"
 echo "Generating android build $buildName $buildNumber"