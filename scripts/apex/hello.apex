// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

List<People_Tracing__c> newPeopleTracing = new List<People_Tracing__c>();
People_Tracing__c p1 = new People_Tracing__c();
People_Tracing__c p2 = new People_Tracing__c();
p1.Person_1__c = 'a035g000007EAlpAAG';
p1.Person_2__c = 'a035g000007EAlvAAG';
newPeopleTracing.add(p1);
//newPeopleTracing.
system.debug(CTPeopleTracingController.checkDuplicates(newPeopleTracing));
