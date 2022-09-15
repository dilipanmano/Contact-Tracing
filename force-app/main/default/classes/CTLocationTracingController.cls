public with sharing class CTLocationTracingController {
  public static List<Location_Tracing__c> getVisitors(String locationId) {
    List<Location_Tracing__c> records = [
      SELECT Id, Name, Person__c, Location__c, Visit_Date__c
      FROM Location_Tracing__c
      WHERE Id = :locationId
      ORDER BY Visit_Date__c DESC
    ];
    return records;
  }
}
