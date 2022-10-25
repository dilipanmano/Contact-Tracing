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

  public static void updateRedScore(Set<id> locationIds) {
    AggregateResult[] redPeoplePerLocation = [
      SELECT Location__c, COUNT(Id) total
      FROM Location_Tracing__c
      WHERE
        Person__r.Health_Status__c = 'Red'
        AND Location__c IN :locationIds
        AND Visit_Date__c = Last_N_Days:10
      GROUP BY Location__c
    ];

    List<Location__c> locationUpdate = new List<Location__c>();
    for (AggregateResult ar : redPeoplePerLocation) {
      String Locid = String.valueOf(ar.get('Location__c'));
      Integer redScore = Integer.valueOf(ar.get('total'));
      String status = getStatus(redScore);
      locationUpdate.add(
        new Location__c(Id = Locid, Red_Score__c = redScore, Status__c = status)
      );
    }

    if (locationUpdate != null && locationUpdate.size() > 0) {
      update locationUpdate;
    }
  }

  public static String getStatus(Integer redScore) {
    if (redScore == 0) {
      return 'Green';
    } else if (redscore <= 5) {
      return 'Yellow';
    } else if (redscore <= 10) {
      return 'Orange';
    } else {
      return 'Red';
    }
  }
}
