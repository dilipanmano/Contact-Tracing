public with sharing class CTPersonController {
  public static String getToken(String mobile) {
    Blob targetBlob = Blob.valueOf(mobile);
    Blob hash = Crypto.generateDigest('MD5', targetBlob);
    String encryptMob = EncodingUtil.base64Encode(hash);
    return encryptMob;
  }

  public static List<Person__c> getRecentHealthChanges() {
    List<Person__c> records = [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      ORDER BY Status_Update_Date__c DESC
      LIMIT 100
    ];
    return records;
  }

  public static List<Person__c> searhPeople(String searchTerm) {
    String s = searchTerm + '%';
    List<Person__c> records = [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      WHERE Name LIKE :s OR Mobile__c LIKE :s OR Token__c LIKE :s
      ORDER BY Status_Update_Date__c DESC
    ];
    return records;
  }

  public static Person__c getPersonById(String personId) {
    List<Person__c> records = [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      WHERE Id = :personId
    ];
    if (records != null && records.size() > 0) {
      return records[0];
    }
    return null;
  }

  public static Map<String, Integer> getHealthStatusCount() {
    Map<String, Integer> mapHealthStatusCount = new Map<String, Integer>();
    for (AggregateResult healthStatus : [
      SELECT Health_Status__c, Count(Id) personCount
      FROM Person__c
      GROUP BY Health_Status__c
    ]) {
      mapHealthStatusCount.put(
        (String) healthStatus.get('Health_Status__c'),
        (Integer) healthStatus.get('personCount')
      );
    }

    return mapHealthStatusCount;
  }

  public static Set<Id> getCohabitants(Set<Id> personIds) {
    List<String> healthStatus = new List<String>{ 'Green', 'Yellow' };
    List<People_Tracing__c> peopleTraces = [
      SELECT Id, Person_1__c, Person_2__c
      FROM People_Tracing__c
      WHERE
        Contact_Type__c = 'Cohabitant'
        AND (Person_1__c IN :personIds
        OR Person_2__c IN :personIds)
        AND (Person_1__r.Health_Status__c IN :healthStatus
        OR Person_2__r.Health_Status__c IN :healthStatus)
    ];
    Set<Id> cohabitants = new Set<Id>();
    for (People_Tracing__c p : peopleTraces) {
      if (!personIds.contains(p.Person_1__c)) {
        cohabitants.add(p.Person_1__c);
      }
      if (!personIds.contains(p.Person_2__c)) {
        cohabitants.add(p.Person_2__c);
      }
    }
    return cohabitants;
  }

  public static Set<Id> getNeighbours(Set<Id> personIds) {
    List<People_Tracing__c> peopleTraces = [
      SELECT Id, Person_1__c, Person_2__c
      FROM People_Tracing__c
      WHERE
        Contact_Type__c = 'Neighbours'
        AND (Person_1__c IN :personIds
        OR Person_2__c IN :personIds)
        AND (Person_1__r.Health_Status__c = 'Green'
        OR Person_2__r.Health_Status__c = 'Green')
    ];
    Set<Id> neighbours = new Set<Id>();
    for (People_Tracing__c p : peopleTraces) {
      if (!personIds.contains(p.Person_1__c)) {
        neighbours.add(p.Person_1__c);
      }
      if (!personIds.contains(p.Person_2__c)) {
        neighbours.add(p.Person_2__c);
      }
    }
    return neighbours;
  }

  public static Set<Id> getPrimaryContacts(Set<Id> personIds) {
    List<String> healthStatus = new List<String>{ 'Green', 'Yellow' };
    List<People_Tracing__c> peopleTraces = [
      SELECT Id, Person_1__c, Person_2__c
      FROM People_Tracing__c
      WHERE
        Contact_Type__c = 'Other'
        AND (Person_1__c IN :personIds
        OR Person_2__c IN :personIds)
        AND Contact_Date__c = LAST_N_DAYS:10
        AND (Person_1__r.Health_Status__c IN :healthStatus
        OR Person_2__r.Health_Status__c IN :healthStatus)
    ];
    Set<Id> primaryContacts = new Set<Id>();
    for (People_Tracing__c p : peopleTraces) {
      if (!personIds.contains(p.Person_1__c)) {
        primaryContacts.add(p.Person_1__c);
      }
      if (!personIds.contains(p.Person_2__c)) {
        primaryContacts.add(p.Person_2__c);
      }
    }
    return primaryContacts;
  }

  public static Set<Id> getSecondaryContacts(Set<Id> primaryontactIds) {
    List<String> healthStatus = new List<String>{ 'Green', 'Yellow' };
    List<People_Tracing__c> peopleTraces = [
      SELECT Id, Person_1__c, Person_2__c
      FROM People_Tracing__c
      WHERE
        Contact_Type__c = 'Other'
        AND (Person_1__c IN :primaryontactIds
        OR Person_2__c IN :primaryontactIds)
        AND Contact_Date__c = LAST_N_DAYS:10
        AND (Person_1__r.Health_Status__c IN :healthStatus
        OR Person_2__r.Health_Status__c IN :healthStatus)
    ];
    Set<Id> secondaryContacts = new Set<Id>();
    for (People_Tracing__c p : peopleTraces) {
      if (!primaryontactIds.contains(p.Person_1__c)) {
        secondaryContacts.add(p.Person_1__c);
      }
      if (!primaryontactIds.contains(p.Person_2__c)) {
        secondaryContacts.add(p.Person_2__c);
      }
    }
    return secondaryContacts;
  }
}
