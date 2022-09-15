public with sharing class CTLocationTracingController {
  public static List<Location_Tracing__c> getVisitors(String locationId) {
    List<Location_Tracing__c> records = [
      SELECT
        Id,
        Person__c,
        Location__c,
        Visit_Date__c,
        Person__r.Token__c,
        Person__r.Health_Status__c
      FROM Location_Tracing__c
      WHERE Id = :locationId
      ORDER BY Visit_Date__c DESC
    ];
    return records;
  }

  public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds) {
    List<Location_Tracing__c> records = [
      SELECT Id, Person__c, Location__c
      FROM Location_Tracing__c
      WHERE Person__c IN :personIds AND Visit_Date__c = LAST_N_DAYS:10
    ];
    return records;
  }

  public static List<Location_Tracing__c> getLocationsByLocationIds(Set<Id> locationIds) {
    List<Location_Tracing__c> records = [
      SELECT Id, Person__c, Location__c
      FROM Location_Tracing__c
      WHERE Location__c IN :locationIds AND Visit_Date__c = LAST_N_DAYS:10
    ];
    return records;
  }
}
