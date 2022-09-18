public with sharing class CTLocationController {
  public static List<Location__c> getRecentStatusChanges() {
    List<Location__c> records = [
      SELECT
        Name,
        Id,
        Address__c,
        Pincode__c,
        Red_Score__c,
        Status_Update_Date__c,
        Status__c
      FROM Location__c
      ORDER BY Status_Update_Date__c DESC
      LIMIT 100
    ];
    return records;
  }

  public static List<Location__c> searhPeople(String searchTerm) {
    String s = searchTerm + '%';
    List<Location__c> records = [
      SELECT
        Name,
        Id,
        Address__c,
        Pincode__c,
        Red_Score__c,
        Status_Update_Date__c,
        Status__c
      FROM Location__c
      WHERE Name LIKE :s OR Pincode__c LIKE :s OR Address__c LIKE :s
      ORDER BY Status_Update_Date__c DESC
    ];
    return records;
  }

  public static Location__c getPersonById(String locationId) {
    List<Location__c> records = [
      SELECT
        Name,
        Id,
        Address__c,
        Pincode__c,
        Red_Score__c,
        Status_Update_Date__c,
        Status__c
      FROM Location__c
      WHERE Id = :locationId
    ];
    if (records != null && records.size() > 0) {
      return records[0];
    }
    return null;
  }

  public static Map<String, Integer> getStatusCount() {
    Map<String, Integer> mapHealthPerson = new Map<String, Integer>();
    for (AggregateResult healthStatus : [
      SELECT Status__c, Count(Id) locationCount
      FROM Location__c
      GROUP BY Status__c
    ]) {
      mapHealthPerson.put(
        (String) healthStatus.get('Status__c'),
        (Integer) healthStatus.get('locationCount')
      );
    }
    return mapHealthPerson;
  }
}
