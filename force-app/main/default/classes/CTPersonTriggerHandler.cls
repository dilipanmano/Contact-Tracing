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
}
