@isTest
public with sharing class ContactTriggerHandlerTest {
  @TestSetup
  public static void makeData() {
    List<Account> accountInsert = new List<Account>();
    accountInsert.add(new Account(Name = 'Test 1'));
    accountInsert.add(new Account(Name = 'Test 2'));
    insert accountInsert;

    List<Contact> contactInsert = new List<Contact>();
    contactInsert.add(
      new Contact(
        FirstName = 'Test',
        LastName = 'Contact 1',
        AccountId = accountInsert[0].Id,
        Active__c = true
      )
    );
    contactInsert.add(
      new Contact(
        FirstName = 'Test',
        LastName = 'Contact 2',
        AccountId = accountInsert[0].Id,
        Active__c = true
      )
    );
    contactInsert.add(
      new Contact(
        FirstName = 'Test',
        LastName = 'Contact 3',
        AccountId = accountInsert[0].Id
      )
    );
    contactInsert.add(
      new Contact(
        FirstName = 'Test',
        LastName = 'Contact 4',
        AccountId = accountInsert[0].Id
      )
    );
    contactInsert.add(
      new Contact(
        FirstName = 'Test',
        LastName = 'Contact 5',
        AccountId = accountInsert[1].Id
      )
    );
    insert contactInsert;
  }

  @isTest
  public static void activeContactCountInsertTest2() {
    List<Account> accs = [SELECT id, Name, Active_Contacts__c FROM Account];
    for (Account acc : accs) {
      if (acc.Name == 'Test 1') {
        System.assertEquals(2, acc.Active_Contacts__c); //
      }
      if (acc.Name == 'Test 2') {
        System.assertEquals(0, acc.Active_Contacts__c);
      }
    }
  }

  @isTest
  public static void activeContactCountInsertTestBulk() {
    List<Contact> contactInsert = new List<Contact>();
    Integer i;
    List<Account> accounts = [
      SELECT id, Name, Active_Contacts__c
      FROM Account
      WHERE name = 'Test 1'
    ];
    for (i = 1; i <= 1000; i++) {
      contactInsert.add(
        new Contact(
          FirstName = 'Test',
          LastName = 'Contact ' + i,
          AccountId = accounts[0].Id,
          Active__c = true
        )
      );
    }
    Test.startTest();
    insert contactInsert;
    Test.stopTest();

    List<Account> accs = [SELECT id, Name, Active_Contacts__c FROM Account];
    for (Account acc : accs) {
      if (acc.Name == 'Test 1') {
        System.assertEquals(1002, acc.Active_Contacts__c);
      }
      if (acc.Name == 'Test 2') {
        System.assertEquals(0, acc.Active_Contacts__c);
      }
    }
    List<Contact> con = [SELECT id FROM Contact];
    System.assertEquals(1005, con.size());
  }

  @isTest
  public static void activeContactCountUpdateTest1() {
    List<Contact> cons = [SELECT id, LastName FROM Contact];
    for (Contact con : cons) {
      if (con.LastName == 'Contact 3' || con.LastName == 'Contact 4') {
        con.Active__c = true;
      }
    }

    Test.startTest();
    update cons;
    Test.stopTest();

    List<Account> accs = [SELECT id, Name, Active_Contacts__c FROM Account];
    for (Account acc : accs) {
      if (acc.Name == 'Test 1') {
        System.assertEquals(4, acc.Active_Contacts__c);
      }
      if (acc.Name == 'Test 2') {
        System.assertEquals(0, acc.Active_Contacts__c);
      }
    }
  }

  @isTest
  public static void activeContactCountUpdateTest2() {
    List<Account> accounts = [
      SELECT id, Name, Active_Contacts__c
      FROM Account
      WHERE name = 'Test 2'
    ];
    List<Contact> cons = [SELECT id, LastName FROM Contact];
    List<Contact> contactUpdate = new List<Contact>();
    for (Contact con : cons) {
      if (con.LastName == 'Contact 3' || con.LastName == 'Contact 4') {
        con.Active__c = true;
        con.AccountId = accounts[0].Id;
        contactUpdate.add(con);
      }
    }

    Test.startTest();
    update contactUpdate;
    Test.stopTest();

    List<Account> accs = [SELECT id, Name, Active_Contacts__c FROM Account];
    for (Account acc : accs) {
      if (acc.Name == 'Test 1') {
        System.assertEquals(2, acc.Active_Contacts__c);
      }
      if (acc.Name == 'Test 2') {
        System.assertEquals(2, acc.Active_Contacts__c);
      }
    }
  }
}
