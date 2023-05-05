cd sfdmu/firstrun
# sfdx plugins:install sfdmu
if [ "$SOURCE_ORG_ALIAS" = "Production" ]; 
then
    echo $PRODUCTION_DOMAIN | sf sfdmu:run --sourceusername csvfile --targetusername $SOURCE_ORG_ALIAS
else
    yes y  | sf sfdmu:run --sourceusername csvfile --targetusername $SOURCE_ORG_ALIAS
fi
#This will print the MissingParentRecordsReport csv file in console
if [ -f MissingParentRecordsReport.csv ];
then
    cat MissingParentRecordsReport.csv
fi