echo ${SECRET_URL_PATH} > ./CI_SFDX_URL.txt && 
cat ./CI_SFDX_URL.txt
sf org login sfdx-url --sfdx-url-file ./CI_SFDX_URL.txt --set-default --alias ${SOURCE_ORG_ALIAS}
# sfdx force:auth:sfdxurl:store -f ./CI_SFDX_URL.txt -a ${SOURCE_ORG_ALIAS} -d
