public with sharing class AccountContactService {
  public static void updateAccount(Set<Id> accountIds) {
    List<contact> allContactList = [
      SELECT id, AccountId
      FROM Contact
      WHERE AccountId IN :accountIds AND Active__c = TRUE
    ];

    Map<Id, Decimal> mapAcc = new Map<Id, Decimal>();
    List<Account> updateAcc = [SELECT ID FROM Account WHERE Id IN :accountIds];

    if (allContactList.size() > 0) {
      for (Contact con : allContactList) {
        if (!mapAcc.containsKey(con.AccountId)) {
          mapAcc.put(con.AccountId, 0);
        }
        decimal d = mapAcc.get(con.AccountId) + 1;
        mapAcc.put(con.AccountId, d);
      }
    }

    if (updateAcc.size() > 0) {
      for (Account a : updateAcc) {
        if (!mapAcc.containsKey(a.Id)) {
          a.Active_Contacts__c = 0;
        } else {
          a.Active_Contacts__c = mapAcc.get(a.Id);
        }
      }
      update updateAcc;
    }
  }
}
