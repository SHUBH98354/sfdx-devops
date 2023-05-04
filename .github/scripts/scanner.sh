echo y | sf plugins install @salesforce/sfdx-scanner
sf scanner --help
sf scanner:run --format table --target force-app/main --normalize-severity -c "Security,Best Practices,Performance,Code Style,Design,Error Prone,ECMAScript 6,Possible Errors,Variables,Stylistic Issues"