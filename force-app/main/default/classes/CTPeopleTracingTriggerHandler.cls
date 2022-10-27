public with sharing class CTPeopleTracingTriggerHandler {
  public static void checkDuplicates(List<People_Tracing__c> newPeopleTracing) {
    List<People_Tracing__c> dupes = CTPeopleTracingController.checkDuplicates(
      newPeopleTracing
    );
    for (People_Tracing__c pt : dupes) {
      pt.addError(
        'Duplicate record ' +
        pt.Person_1__c +
        ' ' +
        pt.Person_2__c
      );
    }
  }
}
