if [ -f DEPLOY_ORG.txt ]
then
    if grep -q '<name>ApexClass</name>' package/package.xml;
    then 
        VALIDATION_OUTPUT=$(cat ./DEPLOY_ORG.txt) 
        DEPLOYMENT_STRING=${VALIDATION_OUTPUT#*Deploy ID: }
        echo $DEPLOYMENT_STRING
        FINAL_DEPLOY_ID=${DEPLOYMENT_STRING:0:18}
        echo $FINAL_DEPLOY_ID
        sfdx force:source:deploy -q $FINAL_DEPLOY_ID -u $SOURCE_ORG_ALIAS
    else
        sfdx force:source:deploy -u $SOURCE_ORG_ALIAS -x package/package.xml
    fi
fi
