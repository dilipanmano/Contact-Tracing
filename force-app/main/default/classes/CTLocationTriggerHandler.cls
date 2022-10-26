public with sharing class CTLocationTriggerHandler {
  public static void setStatus(List<Location__c> locationIds) {
    for (Location__c l : locationIds) {
      l.Status__c = 'Green';
    }
  }

  public static void setStatusUpdateDate(
    List<Location__c> locationIds,
    Map<Id, Location__c> oldLocationMap
  ) {
    for (Location__c l : locationIds) {
      if (l.Status__c != oldLocationMap.get(l.Id).Status__c) {
        l.Status_Update_Date__c = System.now().date();
      }
    }
  }

  public static void locationStatusRed(
    List<Location__c> locationIds,
    Map<Id, Location__c> oldLocationMap
  ) {
    Set<Id> requiredLocations = new Set<Id>();
    for (Location__c l : locationIds) {
      if (
        l.Status__c != oldLocationMap.get(l.Id).Status__c &&
        l.Status__c == 'Red'
      ) {
        system.debug(l.Name);
        requiredLocations.add(l.Id);
      }
    }
    List<Location_Tracing__c> locationTraces = CTLocationTracingController.getLocationsByLocationIds(
      requiredLocations
    );
    List<Person__c> updatePerson = new List<Person__c>();
    for (Location_Tracing__c trace : locationTraces) {
      Person__c per = new Person__c(
        Id = trace.Person__c,
        Health_Status__c = 'Yellow'
      );
      updatePerson.add(per);
    }
    system.debug(updatePerson);
    if(updatePerson.size()>0){
        update updatePerson;
    }
  }
}
