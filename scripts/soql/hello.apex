List<loan__Loan_Account__c> clContract=[SELECT Id, 
                                                Name, 
                                                loan__Account__c,
                                                loan__Reschedule_Status__c, 
                                                loan__Job_Thread_Count__c, 
                                                loan__Migration_Date__c, 
                                                loan__Loan_Status__c, 
                                                loan__Thread_Number__c,
                                                loan__Loan_Account_External_Id__c,
                                                Discount_Amount__c,
                                                loan__Loan_Amount__c,
                                                loan__Interest_Rate__C,
                                                loan__Disbursal_Date__c,
                                                loan__Interest_Posting_Frequency__c,
                                                loan__Loan_Product_Name__r.loan__Loan_Parameters__r.loan__Minimum_Interest_Period__c,
                                                loan__Loan_Product_Name__r.loan__Loan_Parameters__r.loan__Minimum_Interest_Option__c,
                                                loan__Loan_Product_Name__r.loan__Loan_Parameters__r.loan__Skip_Amortization_Schedule_Generation__c,
                                                loan__Loan_Product_Name__r.loan__Loan_Parameters__r.loan__Auto_Change_Deposit_Rate__c,
                                                loan__Loan_Product_Name__r.loan__Loan_Parameters__r.loan__External_Id__c,
                                                (select id,name from CL_Loans__r)
                                            FROM loan__Loan_Account__c 
                                            WHERE 
                                            loan__Loan_Account_External_Id__c='134039'
                                            AND loan__Loan_Status__c in('Active - Good Standing','Active - Bad Standing')];

BPPostMigrationInsertionJob objn = new BPPostMigrationInsertionJob(Date.today(),Date.today());
objn.execute(null, clContract);


BPPostMigrationInsertionJob obj=new BPPostMigrationInsertionJob(Date.ValueOf('2023-01-20'),Date.valueOf('2023-01-20'));
obj.setMigrationState(3);
Database.executeBatch(obj,500);

loan.WriteOffFactory factory=new loan.WriteOffFactory();
loan.WriteOff2 obj=factory.getWriteOff2API();
System.debug(obj.writeOffLoansNew(new Set<Id>{'aDE03000000L3Wv'}));

loan.WriteOffFactory factory=new loan.WriteOffFactory();
loan.WriteOff obj=factory.getWriteOffAPI();
// System.debug(
  obj.writeOffLoans(new Set<Id>{'aDE03000000L3Wv'});
  // );

loan.LoanActionWriteOffInvocable.LoanActionWriteOffParameter params=new loan.LoanActionWriteOffInvocable.LoanActionWriteOffParameter();
params.loanId='aDE03000000L3Wv';
params.flag=1;
List<loan.LoanActionWriteOffInvocable.LoanActionWriteOffParameter> paramsList=new List<loan.LoanActionWriteOffInvocable.LoanActionWriteOffParameter>{params};
System.debug(loan.LoanActionWriteOffInvocable.writeOffLoans(paramsList));

Database.executeBatch(new GLAccountsBatchJob(),200); 

CIBCACHFileGeneration obj=new CIBCACHFileGeneration();
System.debug(obj.getEntries(null,[SELECT id,Name FROM loan__Disbursal_Txn_Distribution__c where id='aCL1Q000000QXAr']));


SELECT loan__Account__c Id  FROM loan__Loan_Account__c GROUP BY loan__Account__c HAVING Count(loan__Account__c)>0 LIMIT 2000



PlaintiffStatementBatch job =  new PlaintiffStatementBatch();
Database.executeBatch(job,400);

LawyerStatementBatch job =  new LawyerStatementBatch();
Database.executeBatch(job,500);

List<Generate_CL_Contract__e> contractEventList=new List<Generate_CL_Contract__e>();
for(Pending_Transactions__c pendingTranscation:[select id,name,Request__c,Bulk_Funding_message__c from Pending_Transactions__c where Request__r.name in ('R-122270','R-122271','R-122272','R-122273','R-122274','R-122275','R-122276','R-122277','R-122278','R-122279','R-122280','R-122281','R-122282','R-122283','R-122284','R-122285','R-122286','R-122287','R-122288','R-122289','R-122290','R-122291','R-122292','R-122293','R-122294','R-122295','R-122296','R-122297','R-122298','R-122299','R-122300','R-122301','R-122302','R-122303','R-122304','R-122305','R-122306','R-122307','R-122308','R-122309','R-122310','R-122311','R-122312','R-122313','R-122314','R-122315','R-122316','R-122317','R-122318','R-122319','R-122320','R-122321','R-122322','R-122323','R-122324','R-122325','R-122326','R-122327','R-122328','R-122329','R-122330','R-122331','R-122332','R-122333','R-122334','R-122335','R-122336','R-122337','R-122338','R-122339','R-122340','R-122341','R-122342','R-122343','R-122344','R-122345','R-122346','R-122347','R-122348','R-122349','R-122350','R-122351','R-122352','R-122353','R-122354','R-122355','R-122356','R-122357','R-122358','R-122359','R-122360','R-122361','R-122362','R-122363','R-122364','R-122365','R-122366','R-122367','R-122368','R-122369','R-122370','R-122371','R-122372','R-122373','R-122374','R-122375','R-122376','R-122377','R-122378','R-122379','R-122380','R-122381','R-122382','R-122383','R-122384','R-122385','R-122386','R-122387','R-122388','R-122389','R-122390','R-122391','R-122392','R-122393','R-122394','R-122395','R-122396','R-122397','R-122398','R-122399','R-122400','R-122401','R-122402','R-122403','R-122404','R-122405','R-122406','R-122407','R-122408','R-122409','R-122410','R-122411','R-122412','R-122413','R-122414','R-122415','R-122416','R-122417','R-122418','R-122419','R-122420','R-122421','R-122422','R-122423','R-122424','R-122425','R-122426','R-122427','R-122428','R-122429','R-122430','R-122431','R-122432','R-122433','R-122434','R-122435','R-122436','R-122437','R-122438','R-122439','R-122440','R-122441','R-122442','R-122443','R-122444','R-122445','R-122446','R-122447','R-122448','R-122449','R-122450','R-122451','R-122452','R-122453','R-122454','R-122455','R-122456','R-122457','R-122458','R-122459','R-122460','R-122461','R-122462','R-122463','R-122464','R-122465','R-122466','R-122467','R-122468','R-122469','R-122470','R-122471','R-122472','R-122473','R-122474','R-122475','R-122476','R-122477','R-122478','R-122479','R-122480','R-122481','R-122482','R-122483','R-122484','R-122485','R-122486','R-122487','R-122488','R-122489','R-122490','R-122491','R-122492','R-122493','R-122494','R-122495','R-122496','R-122497','R-122498','R-122499','R-122500','R-122501','R-122502','R-122503','R-122504','R-122505','R-122506','R-122507','R-122508','R-122509','R-122510','R-122511','R-122512','R-122513','R-122514','R-122515','R-122516','R-122517','R-122518','R-122519','R-122520','R-122521','R-122522','R-122523','R-122524','R-122525','R-122526','R-122527','R-122528','R-122529','R-122530','R-122531','R-122532','R-122533','R-122534','R-122535','R-122536','R-122537','R-122538','R-122539','R-122540','R-122541','R-122542','R-122543','R-122544','R-122545','R-122546','R-122547','R-122548','R-122549','R-122550','R-122551','R-122552','R-122553','R-122554','R-122555','R-122556','R-122557','R-122558','R-122559','R-122560','R-122561','R-122562','R-122563','R-122564','R-122565','R-122566','R-122567','R-122568','R-122569','R-122570','R-122571','R-122572','R-122573','R-122574','R-122575','R-122576','R-122577','R-122578','R-122579','R-122580','R-122581','R-122582','R-122583','R-122584','R-122585','R-122586','R-122587','R-122588','R-122589','R-122590','R-122591','R-122592','R-122593','R-122594','R-122595','R-122596','R-122597','R-122598','R-122599','R-122600','R-122601','R-122602','R-122603','R-122604','R-122605','R-122606','R-122607','R-122608','R-122609','R-122610','R-122611','R-122612','R-122613','R-122614','R-122615','R-122616','R-122617','R-122618','R-122619','R-122620','R-122621','R-122622','R-122623','R-122624','R-122625','R-122626','R-122627','R-122628','R-122629','R-122630','R-122631','R-122632','R-122633','R-122634','R-122635','R-122636','R-122637','R-122638','R-122639','R-122640','R-122641','R-122642','R-122643','R-122644','R-122645','R-122646','R-122647','R-122648','R-122649','R-122650','R-122651','R-122652','R-122653','R-122654','R-122655','R-122656','R-122657','R-122658','R-122659','R-122660','R-122661','R-122662','R-122663','R-122664','R-122665','R-122666','R-122667','R-122668','R-122669','R-122670','R-122671','R-122672','R-122673','R-122674','R-122675','R-122676','R-122677','R-122678','R-122679','R-122680','R-122681','R-122682','R-122683','R-122684','R-122685','R-122686','R-122687','R-122688','R-122689','R-122690','R-122691','R-122692','R-122693','R-122694','R-122695','R-122696','R-122697','R-122698','R-122699','R-122700','R-122701','R-122702','R-122703','R-122704','R-122705','R-122706','R-122707','R-122708','R-122709','R-122710','R-122711','R-122712','R-122713','R-122714','R-122715','R-122716','R-122717','R-122718','R-122719','R-122720','R-122721','R-122722','R-122723','R-122724','R-122725','R-122726','R-122727','R-122728','R-122729','R-122730','R-122731','R-122732','R-122733','R-122734','R-122735','R-122736','R-122737','R-122738','R-122739','R-122740','R-122741','R-122742','R-122743','R-122744','R-122745','R-122746','R-122747','R-122748','R-122749','R-122750','R-122751','R-122752','R-122753','R-122754','R-122755','R-122756','R-122757','R-122758','R-122759','R-122760','R-122761','R-122762','R-122763','R-122764','R-122765','R-122766','R-122767','R-122768','R-122769','R-122770','R-122771','R-122772','R-122773','R-122774','R-122775','R-122776','R-122777','R-122778','R-122779','R-122780','R-122781','R-122782','R-122783','R-122784','R-122785','R-122786','R-122787','R-122788','R-122789','R-122790','R-122791','R-122792','R-122793','R-122794','R-122795','R-122796','R-122797','R-122798','R-122799','R-122800','R-122801','R-122802','R-122803','R-122804','R-122805','R-122806','R-122807','R-122808','R-122809','R-122810','R-122811','R-122812','R-122813','R-122814','R-122815','R-122816','R-122817','R-122818','R-122819')]){
    Generate_CL_Contract__e contractEventInstance = new Generate_CL_Contract__e();
    contractEventInstance.Request_Id__c=pendingTranscation.Request__c;
    contractEventInstance.Pending_Transcation_Id__c=pendingTranscation.Id;
    contractEventInstance.Message__c=pendingTranscation.Bulk_Funding_message__c;
    contractEventList.add(contractEventInstance);  
}
List<Database.SaveResult> results = EventBus.publish(contractEventList);
System.debug(results);

List<Pending_Transactions__c> contractEventList=new List<Pending_Transactions__c>();
for(Pending_Transactions__c pendingTranscation:[select id,Law_Firm__r.Name,Request__r.Name,Bulk_Funding_message__c,Request__r.Application__c,Request__r.CL_Contract__c, Request__r.CL_Contract__r.Name  from Pending_Transactions__c where createdDate =LAST_N_DAYS:2 and Law_Firm__r.Name='Litwiniuk LLP' and Bulk_Funding_message__c !=null and Request__r.CL_Contract__c =null order by Request__r.Name]){
    pendingTranscation.Bulk_Funding_message__c=null;
    contractEventList.add(pendingTranscation);
}
update contractEventList;
List<Database.SaveResult> results = EventBus.publish(contractEventList);
System.debug(results);

List<Id> loanAccId=new List<Id>{'aDEDC000000L4LA4A0'};//Id's of loan accounts separated by comma if there are many
Date disbursementDate=Date.valueOf('2023-03-01');//Date for which we need the disbursals.
List<clcommon__Disbursement_Plan__c> disbPlanList=[SELECT Id,
                                                    Application__c,
                                                    Application__r.Payment_Mode__c,
                                                    Application__r.Bank_Account__c,
                                                    loan__Loan_Account__c,
                                                    loan__Loan_Account__r.loan__Loan_Status__c,
                                                    Disbursement_Date__c,
                                                    clcommon__Amount__c,
                                                    Admin_Fee__c,
                                                    clcommon__Start_Date__c,
                                                    clcommon__Terms__c,
                                                    clcommon__Frequency__c,
                                                    End_Date__c,
                                                    Funds_Disbursed__c,
                                                    Tax_Amount__c
                                                FROM clcommon__Disbursement_Plan__c
                                                WHERE (loan__Loan_Account__r.loan__Loan_Status__c =: 
                                                    CustomConstants.CL_CONTRACT_STATUS_ACTIVE_GOOD_STANDING)
                                                AND Disbursement_Date__c =:disbursementDate
                                                AND loan__Loan_Account__c in:loanAccId
                                                AND Funds_Disbursed__c =: false];
DisbursementPlanBatch objectDisb=new DisbursementPlanBatch();
objectDisb.execute(null,disbPlanList);



List<Id> lawyerAccId=new List<Id>{'0030j00000MK19J'};//Id's of loan accounts separated by comma if there are many
Date endDate=Date.Today().addMonths(-1).toStartOfMonth().addDays(-1);

System.debug('statement generation date =='+endDate);
List<Lawyer_Statements__c> lawyerStatements=new List<Lawyer_Statements__c>([SELECT Id,
                                                    Lawyer__c,
                                                    Lawyer__r.Email,
                                                    Lawyer__r.Alternate_Emails__c,
                                                    Lawyer__r.CC_Emails__c,
                                                    Lawyer__r.HasOptedOutOfEmail
                                                FROM Lawyer_Statements__c
                                                WHERE End_Date__c =: endDate
                                                AND Lawyer__c in:lawyerAccId]);

EmailStatementBatch objectDisb=new EmailStatementBatch();
objectDisb.execute(null,lawyerStatements);

Database.executeBatch(new EmailStatementBatch(),200);

HandlePipelinedEventsUtil obj=HandlePipelinedEventsUtil.getInstance();
HandlePipelinedEventsUtil.getInstance().pushEvent('Hi');
HandlePipelinedEventsUtil.getInstance().pushEvent('Hi2');
HandlePipelinedEventsUtil.getInstance().pushEvent('Hi3');
HandlePipelinedEventsUtil.getInstance().pushEvent('Hi4');
HandlePipelinedEventsUtil.getInstance().pushEvent('Hi5');
HandlePipelinedEventsUtil.getInstance().pushEvent('Hi6');
HandlePipelinedEventsUtil.getInstance().pushEvent('Hi7');
HandlePipelinedEventsUtil.getInstance().pushEvent('Hi8');
HandlePipelinedEventsUtil.getInstance().publishEvents();

System.debug(Schema.getGlobalDescribe().get('Generate_CL_Contract__e'));
for(Schema.SObjectType types:Schema.getGlobalDescribe().get('Generate_CL_Contract__e')){
    System.debug(types);
}

String recordId = 'aDI03000000L0Qp';
List<ProcessInstanceWorkitem> workItems = [
    SELECT Id, ProcessInstanceId 
    FROM ProcessInstanceWorkitem 
    WHERE ProcessInstance.TargetObjectId = :recordId 
  ];
List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
for(ProcessInstanceWorkitem workItem : workItems){
  Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
  req.setWorkitemId(workItem.Id);
  //Valid values are: Approve, Reject, or Removed. 
  //Only system administrators can specify Removed.
  req.setAction('Approve');
  req.setComments('Your Comment.');
  requests.add(req);
}
Approval.ProcessResult[] processResults = Approval.process(requests);



actionObj.waiveCharge(null,null,null);
actionObj.waiveCharge(((Id)('aDE03000000L0oN')),new List<loan__Loan_Account__c>{new loan__Loan_Account__c(Id='aDE03000000L0oN')},10.00);


actionObj.waiveCharge(((Id)('aDE03000000L0oN')),new List<loan__Fee__c>{new loan__Fee__c(Id='aCZ03000000CdbN')},10.1);

actionObj.waiveCharge(((Id)('aDE03000000L0oN')),new List<loan__Charge__c>{new loan__Charge__c(Id='aBj03000000L4a1')},10.0);

//Principal Adjustment
loan.LoanActionFactory actionFactory=new loan.LoanActionFactory();
loan.LoanAction actionObj=actionFactory.getLoanActionAPI();
actionObj.adjustPrincipal('aDE03000000L3l2',Date.valueOf('2023-03-28'),-200,'Waiver For Write-Off');

//Interest Waive
loan.LoanActionFactory actionFactory=new loan.LoanActionFactory();
loan.LoanAction12 actionObj=actionFactory.getLoanAction12API();
actionObj.waiveInterest('aDE03000000L3Wb',200.00,Date.valueOf('2023-03-28'));

String queryString='select id,name,loan__Disbursal_Date__c, loan__Fees_Remaining__c,loan__Loan_Parameters__r.loan__Minimum_Interest_Period__c,loan__Loan_Parameters__r.loan__Minimum_Interest_Period_Date__c,loan__Loan_Parameters__r.loan__Minimum_Interest_Amount__c,loan__Loan_Parameters__r.SystemModstamp  from loan__Loan_Account__c where loan__Disbursal_Date__c <=LAST_N_DAYS:180 and loan__Loan_Parameters__c !=null and loan__Total_Amount_Paid__c =0 and loan__Loan_Status__c =\'Active - Good Standing\' and loan__Fees_Remaining__c>0 and id in (select loan__Loan_Account__c from loan__Charge__c where (loan__Fee__r.Name=\'Minimum Interest Prepayment Penalty Fee\') and loan__Waive__c=false ) ORDER by loan__Loan_Parameters__r.SystemModstamp DESC';
// Database.query(queryString);
Database.executeBatch(new WaiveChargeBulkJob(queryString),1);

select id,name from loan__Loan_Account__c where loan__Loan_Status__c like 'Active%'


select id,name FROM genesis__Applications__c where createdDate=LAST_N_DAYS:7


BP_StopAccrualOnProblemLoan.stopAccrual(new list<Id>{'a1IDC000000DO7p'});

//This is to create the reference of disbursal Transaction
String externalId='noone1';
loan__Loan_Disbursal_Transaction__c disbursal =  new loan__Loan_Disbursal_Transaction__c();
disbursal.loan__Disbursal_Date__c = Date.valueOf('2022-07-22');
disbursal.loan__Disbursed_Amt__c=1500;
disbursal.loan__Financed_Amount__c=0;
disbursal.loan__Loan_Account__c='aDE03000000L3WqGAK'; 
disbursal.loan__External_Id__c=externalId; 
//disbursal.loan__Mode_of_Payment__c = loanContract.loan__Payment_Mode__c;

List<loan__Disbursal_Txn_Distribution__c> disbursalDistributionList=new List<loan__Disbursal_Txn_Distribution__c>();
loan__Disbursal_Txn_Distribution__c disbursalDistributionInstance=new loan__Disbursal_Txn_Distribution__c();
disbursalDistributionInstance.loan__Distribution_Amount__c=1500;
disbursalDistributionInstance.loan__Name_of_Entity__c='Admin Fee';
disbursalDistributionInstance.loan__Loan_Disbursal_Transaction__r=new loan__Loan_Disbursal_Transaction__c(loan__External_Id__c=externalId);
//disbursalDistributionInstance.loan__Distribution_Type__c=distributionType;
disbursalDistributionList.add(disbursalDistributionInstance);
insert disbursal;
insert disbursalDistributionList;

SetLoanWriteOffBalances.createLPT(new List<Id>{'aDt03000000Kyyw'});


actionObj.waiveCharge(((Id)('aDE03000000L0oN')),new List<Id>{'aBj03000000L4a1'},10);


//Set Of loanId for which the writeoff needs to be appled. In case of multiple separated with comma.
Set<Id> loanContractIdSet=new Set<Id>{'aDE1Q000000HvDpWAK'};

List<loan__Loan_Account__c> clContractListBeforeUpdate=new List<loan__Loan_Account__c>();
List<loan__Loan_Account__c> clContractListAfterUpdate=new List<loan__Loan_Account__c>();
List<loan__Charge__c> minIntFeeList=new List<loan__Charge__c>();
List<loan__Loan_Account__c> CLcontractList=new List<loan__Loan_Account__c>([SELECT id,
                                                                                  Name,
                                                                                  loan__Excess__c,
                                                                                  loan__Is_Interest_Posting_Enabled__c,
                                                                                  Total_Interest_Accrued__c,
                                                                                  loan__Loan_Parameters__r.loan__Minimum_Interest_Amount__c,
                                                                                  loan__Loan_Parameters__r.loan__Minimum_Interest_Period_Date__c,
                                                                                  loan__Is_Capitalization_Enabled__c
                                                                                FROM loan__Loan_Account__c 
                                                                                WHERE id IN:loanContractIdSet
                                                                                AND loan__Excess__c>0]);

List<loan__Fee__c> feeList=[SELECT id,
                                  name 
                                FROM loan__Fee__c 
                                WHERE Name='Minimum Interest Prepayment Penalty Fee'];

loan.GlobalLoanUtilFacade loanUtil = new loan.GlobalLoanUtilFacade();
Date sodDate=loanUtil.getCurrentSystemDate();

List<loan__Loan_Payment_Transaction__c> loanPaymentList=new List<loan__Loan_Payment_Transaction__c>();
Integer count=0;
for(loan__Loan_Account__c clContractInstance:CLcontractList){
	loan__Loan_Account__c clContractBeforeUpdate = new loan__Loan_Account__c();
	loan__Loan_Account__c clContractAfterUpdate = new loan__Loan_Account__c();
  String spreadName='Interest Only';

	clContractBeforeUpdate.Id=clContractInstance.Id;
	clContractBeforeUpdate.loan__Is_Capitalization_Enabled__c=false;
	clContractBeforeUpdate.loan__Is_Interest_Posting_Enabled__c=false;
	clContractListBeforeUpdate.add(clContractBeforeUpdate);
	
	clContractAfterUpdate.Id=clContractInstance.Id;
	clContractAfterUpdate.loan__Is_Capitalization_Enabled__c=true;
	clContractAfterUpdate.loan__Is_Interest_Posting_Enabled__c=true;
	clContractListAfterUpdate.add(clContractAfterUpdate);

  if(clContractInstance.loan__Loan_Parameters__r.loan__Minimum_Interest_Period_Date__c !=null 
      && clContractInstance.loan__Loan_Parameters__r.loan__Minimum_Interest_Period_Date__c>=sodDate
      && clContractInstance.loan__Loan_Parameters__r.loan__Minimum_Interest_Amount__c>0){
    Decimal chargeAmt=clContractInstance.loan__Loan_Parameters__r.loan__Minimum_Interest_Amount__c-clContractInstance.Total_Interest_Accrued__c;
    System.debug(chargeAmt);
    if(chargeAmt>0){
      loan__Charge__c charge = new loan__Charge__c();
      charge.loan__Loan_Account__c = clContractInstance.Id;
      charge.loan__Fee__c = feeList[0].Id;
      charge.loan__Date__c = sodDate;
      charge.loan__Transaction_Creation_Date__c = sodDate;
      charge.loan__Original_Amount__c = chargeAmt;
      charge.loan__Total_Amount_Due__c = chargeAmt;
      minIntFeeList.add(charge);
      spreadName='Default Interest Fees';
    }
  }
  loan__Loan_Payment_Transaction__c lpt = new loan__Loan_Payment_Transaction__c();
  lpt.loan__Loan_Account__c = clContractInstance.id;
  lpt.loan__Transaction_Date__c = sodDate;
  lpt.loan__Transaction_Amount__c = clContractInstance.loan__Excess__c;
  lpt.loan__Payment_Mode__r = new loan__Payment_Mode__c(name='Excess');
  lpt.loan__Loan_Payment_Spread__r=new loan__Loan_Payment_Spread__c(name=spreadName);
  lpt.loan__External_Id__c = String.valueOf(System.now())+String.valueOf(count++);
  lpt.loan__Cleared__c=true;
  loanPaymentList.add(lpt);
}
if(minIntFeeList.size()>0){
  Database.insert(minIntFeeList);
}
if(loanPaymentList.size()>0){
	Database.update(clContractListBeforeUpdate);
	Database.insert(loanPaymentList);
	Database.update(clContractListAfterUpdate);
}


String queryString='SELECT ';
queryString+='id FROM Account';
queryString+=' WHERE Name != null ';
String finalQueryString=String.escapeSingleQuotes(queryString);
System.debug(finalQueryString);
Database.query(finalQueryString);






keytool -importkeystore -srckeystore serverkey.jks -destkeystore serverkey.pkcs -srcstoretype JKS -deststoretype PKCS12
openssl pkcs12 -in serverkey.pkcs -out serverkey.pem 
openssl rsa -in serverkey.pem -out private_nopass.key


{
  "sub": "vivek@challenger.com.prod.ci",
  "iss": "3MVG9iLRabl2Tf4iiWva9uQ3QGE0qsKbodKyRD13JBkCNCjN4ia5C9LukhVut7JjWbtOHxRh47bsO.So7VAG1",
  "aud": "https://test.salesforce.com",
  "exp": "1678620471"
}

ExcessLPTCreationInvocable.createExcessLPT(new List<Id>{'aDE1Q000000ITU5WAO'});

eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJ2aXZla0BjaGFsbGVuZ2VyLmNvbS5wcm9kLmNpIiwiaXNzIjoiM01WRzlpTFJhYmwyVGY0aWlXdmE5dVEzUUdFMHFzS2JvZEt5UkQxM0pCa0NOQ2pONGlhNUM5THVraFZ1dDdKaldidE9IeFJoNDdic08uU283VkFHMSIsImF1ZCI6Imh0dHBzOi8vdGVzdC5zYWxlc2ZvcmNlLmNvbSIsImV4cCI6IjE2Nzg2MjA0NzEifQ.PbHoL6m_9jU1V6Dk2IL_vEOdPZlXHTfv_r4jSJhB_QV-C-CTx5BLIj5SJfSXznh2YavQfMJPKVU__FMjG-rwZBxv3yWZN7YnCDW6DtlTbWKB1BaGwJJ08ZJLjFnpSzUUqvPOAxG2hanZi794tjn3Sp6B2ZOQBefN7bJo2A0U1eOVQizJ8Nt56-Y-lA52AZN9gsRy8nGAwT0wZ-GQtY81FrlN1vd5CBqPcJxtUVoMPazefhTeCKZWJ4b9e5_GeCKeTIyZ0XWdIIN--L-zKIr2o5CvBLxZ7eSTLLflpwhCxr0ZhnlEhXnogu18B3Gj7h-B4LchrRSfMelA_3A3RagN8Q