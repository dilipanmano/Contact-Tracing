public with sharing class CTPeopleTracingController {
  public static List<People_Tracing__c> getTraces(String recordId) {
    List<People_Tracing__c> records = [
      SELECT
        Id,
        Name,
        Contact_Date__c,
        Contact_Type__c,
        Person_1__c,
        Person_2__c
      FROM People_Tracing__c
      WHERE Id = :recordId OR Person_1__c = :recordId OR Person_2__c = :recordId
      ORDER BY Contact_Date__c DESC
    ];
    return records;
  }
}
