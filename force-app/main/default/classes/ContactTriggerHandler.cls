public with sharing class ContactTriggerHandler {
  public static void activeContactCountInsert(List<Contact> newContacts) {
    Set<Id> accountIds = new Set<Id>();
    for (Contact c : newContacts) {
      if (c.AccountId != null) {
        accountIds.add(c.AccountId);
      }
    }
    AccountContactService.updateAccount(accountIds);
  }

  public static void activeContactCountUpdate(
    List<Contact> newContacts,
    Map<Id, Contact> contactOldMap
  ) {
    Set<Id> accountIds = new Set<Id>();

    for (Contact c : newContacts) {
      if (
        c.AccountId != null &&
        c.Active__c != contactOldMap.get(c.Id).Active__c
      ) {
        accountIds.add(c.AccountId);
      }
      if (c.AccountId != contactOldMap.get(c.Id).AccountId) {
        accountIds.add(contactOldMap.get(c.Id).AccountId);
        accountIds.add(c.AccountId);
      }
    }
    AccountContactService.updateAccount(accountIds);
  }

  public static void activeContactCountDelete(List<Contact> oldContacts) {
    Set<Id> accountIds = new Set<Id>();
    for (Contact c : oldContacts) {
      if (c.AccountId != null) {
        accountIds.add(c.AccountId);
      }
    }
    AccountContactService.updateAccount(accountIds);
  }

  public static void activeContactCountUndelete(List<Contact> newContacts) {
    Set<Id> accountIds = new Set<Id>();
    for (Contact c : newContacts) {
      if (c.AccountId != null) {
        accountIds.add(c.AccountId);
      }
    }
    AccountContactService.updateAccount(accountIds);
  }
}
