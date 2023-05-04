echo "Delta Check-Only"
# Checking if any metadata changes are in package.xml
if grep -q '<types>' package/package.xml;
then
    sfdx update
    sf deploy metadata -a 54.0 -o $SOURCE_ORG_ALIAS -x package/package.xml -l RunSpecifiedTests -t $(cat ./testclass/testclass.txt) --verbose --dry-run | tee ./DEPLOY_ORG.txt
    # sfdx force:source:deploy -c -u $SOURCE_ORG_ALIAS -x package/package.xml -l RunSpecifiedTests -r $(cat ./testclass/testclass.txt) --verbose | tee ./DEPLOY_ORG.txt
    DEPLOY_EXIT_CODE=${PIPESTATUS[0]}
    if [ $DEPLOY_EXIT_CODE != 0 ]
    then
        exit $DEPLOY_EXIT_CODE;
    fi
else
    exit 0
fi