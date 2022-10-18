// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

Set<Id> personIds = new Set<id>();
personIds.add('a035g000007EAlpAAG');

system.debug(CTPersonController.getCohabitants(personIds));
