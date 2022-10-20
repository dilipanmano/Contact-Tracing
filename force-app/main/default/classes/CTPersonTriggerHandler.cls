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

    List<Id> alreadyProcessed = new List<Id>();
    alreadyProcessed.addAll(redStatus);
    Set<Id> orangeStatus = new Set<Id>();
    Set<Id> yellowStatus = new Set<Id>();

    orangeStatus.addAll(
      CTPersonController.getCohabitants(redStatus, alreadyProcessed)
    );

    yellowStatus.addAll(
      CTPersonController.getNeighbours(redStatus, alreadyProcessed)
    );

    Set<id> primary = CTPersonController.getPrimaryContacts(
      redStatus,
      alreadyProcessed
    );
    orangeStatus.addAll(primary);

    yellowStatus.addAll(
      CTPersonController.getCohabitants(primary, alreadyProcessed)
    );
  }
}
