public with sharing class CTPeopleTracingController {
    public static List<People_Tracing__c> getTraces(String recordId) {
        List<People_Tracing__c> records = [
            SELECT
                Id,
                Name,
                Contact_Date__c,
                Contact_Type__c,
                Person_1__c,
                Person_1__r.Health_Status__c,
                Person_2__c,
                Person_2__r.Health_Status__c
            FROM People_Tracing__c
            WHERE Person_1__c = :recordId OR Person_2__c = :recordId
            ORDER BY Contact_Date__c DESC
        ];
        return records;
    }

    public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> newPeopleTracing) {
        List<People_Tracing__c> dupes = new List<People_Tracing__c>();
        Set<Id> person = new Set<Id>();
        for (People_Tracing__c npt : newPeopleTracing) {
            person.add(npt.Person_1__c);
            person.add(npt.Person_2__c);
        }
        List<People_Tracing__c> existingRecords = [
            SELECT
                Id,
                Name,
                Contact_Date__c,
                Contact_Type__c,
                Person_1__c,
                Person_1__r.Health_Status__c,
                Person_2__c,
                Person_2__r.Health_Status__c
            FROM People_Tracing__c
            WHERE Person_1__c IN :person OR Person_2__c IN :person
        ];
        Map<Id, Set<Id>> mapPeopleTracing = new Map<Id, Set<Id>>();
        if (existingRecords != null && existingRecords.size() > 0) {
            for (People_Tracing__c exist : existingRecords) {
                if (!mapPeopleTracing.containsKey(exist.Person_1__c)) {
                    mapPeopleTracing.put(exist.Person_1__c, new Set<Id>());
                }
                mapPeopleTracing.get(exist.Person_1__c).add(exist.Person_2__c);
                if (!mapPeopleTracing.containsKey(exist.Person_2__c)) {
                    mapPeopleTracing.put(exist.Person_2__c, new Set<Id>());
                }
                mapPeopleTracing.get(exist.Person_2__c).add(exist.Person_1__c);
            }
            for (People_Tracing__c npt : newPeopleTracing) {
                if (
                    (mapPeopleTracing.containsKey(npt.Person_1__c) && mapPeopleTracing.get(npt.Person_1__c).contains(npt.Person_2__c)) ||
                    mapPeopleTracing.containsKey(npt.Person_2__c) && mapPeopleTracing.get(npt.Person_2__c).contains(npt.Person_1__c)
                ) {
                    dupes.add(npt);
                }
            }
        }
        return dupes;
    }
}
