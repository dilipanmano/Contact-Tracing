public with sharing class CTPersonTriggerHandler {
  public static void setToken(List<Person__c> newPerson) {
    for (Person__c p : newPerson) {
      p.Token__c = CTPersonController.getToken(p.Mobile__c);
    }
  }

  public static void setStatus(List<Person__c> newPerson) {
    for (Person__c p : newPerson) {
      p.Health_Status__c = 'Green';
    }
  }

  public static void setStatusUpdateDate(
    List<Person__c> newPerson,
    Map<Id, Person__c> oldPersonMap
  ) {
    for (Person__c p : newPerson) {
      if (p.Health_Status__c != oldPersonMap.get(p.Id).Health_Status__c) {
        p.Status_Update_Date__c = System.now().date();
      }
    }
  }

  public static void setHealthStatus(
    List<Person__c> newPerson,
    Map<Id, Person__c> oldPersonMap
  ) {
    Set<Id> statusChange = new Set<Id>();
    Set<Id> redStatus = new Set<Id>();
    for (Person__c person : newPerson) {
      if (
        person.Health_Status__c != oldPersonMap.get(person.Id).Health_Status__c
      ) {
        statusChange.add(person.Id);
      }
      if (
        person.Health_Status__c == 'red' &&
        oldPersonMap.get(person.Id).Health_Status__c != 'red'
      ) {
        redStatus.add(person.Id);
      }
    }
    List<Person__c> personUpdate = new List<Person__c>();
    Set<Id> alreadyProcessed = new Set<Id>();
    alreadyProcessed.addAll(redStatus);
    Set<Id> orangeStatus = new Set<Id>();
    Set<Id> yellowStatus = new Set<Id>();

    orangeStatus.addAll(
      CTPersonController.getCohabitants(redStatus, alreadyProcessed)
    );

    Set<id> primary = CTPersonController.getPrimaryContacts(
      redStatus,
      alreadyProcessed
    );
    orangeStatus.addAll(primary);

    yellowStatus.addAll(
      CTPersonController.getNeighbours(redStatus, alreadyProcessed)
    );

    yellowStatus.addAll(
      CTPersonController.getCohabitants(primary, alreadyProcessed)
    );

    for (Id pid : orangeStatus) {
      personUpdate.add(new Person__c(Id = pid, Health_Status__c = 'Orange'));
    }

    for (Id pid : yellowStatus) {
      personUpdate.add(new Person__c(Id = pid, Health_Status__c = 'Yellow'));
    }
    if (personUpdate != null && personUpdate.size() > 0) {
      update personUpdate;
    }

    List<Location_Tracing__c> locationTraces = CTLocationTracingController.getLocationsByPersonIds(
      statusChange
    );
    if (locationTraces != null || locationTraces.size() > 0) {
      Set<Id> locationIds = new Set<Id>();
      for (Location_Tracing__c loc : locationTraces) {
        locationIds.add(loc.Location__c);
      }
    }
  }
}
