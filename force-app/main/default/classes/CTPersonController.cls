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
}
