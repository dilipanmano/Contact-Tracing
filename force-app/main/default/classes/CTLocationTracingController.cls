public with sharing class CTLocationTracingController {
    public static List<Location_Tracing__c> getVisitors(String locationId) {
        List<Location_Tracing__c> records = [
            SELECT Id, Person__c, Location__c, Visit_Date__c, Person__r.Name, Person__r.Token__c, Person__r.Health_Status__c
            FROM Location_Tracing__c
            WHERE Id = :locationId and Visit_Date__c = LAST_N_DAYS:30
            ORDER BY Visit_Date__c DESC
        ];
        return records;
    }

    public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds) {
        List<Location_Tracing__c> records = [
            SELECT Id, Person__c, Location__c
            FROM Location_Tracing__c
            WHERE Person__c IN :personIds AND Visit_Date__c = LAST_N_DAYS:10
        ];
        return records;
    }

    public static List<Location_Tracing__c> getLocationsByLocationIds(Set<Id> locationIds) {
        List<Location_Tracing__c> records = [
            SELECT Id, Person__c, Location__c, Person__r.Health_Status__c
            FROM Location_Tracing__c
            WHERE Location__c IN :locationIds AND Visit_Date__c = LAST_N_DAYS:10 AND Person__r.Health_Status__c = 'Green'
        ];
        return records;
    }

    public static List<Location_Tracing__c> checkDuplicates(List<Location_Tracing__c> newLocationTracingIds) {
        Set<Id> personList = new Set<Id>();
        Set<Id> locationList = new Set<Id>();
        for (Location_Tracing__c lt : newLocationTracingIds) {
            personList.add(lt.Person__c);
            locationList.add(lt.Location__c);
        }
        List<Location_Tracing__c> existingLT = [
            SELECT Id, Person__c, Location__c
            FROM Location_Tracing__c
            WHERE Person__c IN :personList AND Location__c IN :locationList
        ];
        Map<Id, Set<Id>> mapLocationPerson = new Map<Id, Set<Id>>();
        if (existingLT != null && existingLT.size() > 0) {
            for (Location_Tracing__c lt : existingLT) {
                if (!mapLocationPerson.containsKey(lt.Location__c)) {
                    mapLocationPerson.put(lt.Location__c, new Set<Id>());
                }
                Set<Id> tempPersonIds = mapLocationPerson.get(lt.Location__c);
                tempPersonIds.add(lt.Person__c);
                mapLocationPerson.put(lt.Location__c, tempPersonIds);
            }
        }
        List<Location_Tracing__c> dupes = new List<Location_Tracing__c>();

        for (Location_Tracing__c nlt : newLocationTracingIds) {
            if (mapLocationPerson.containsKey(nlt.Location__c) && mapLocationPerson.get(nlt.Location__c).contains(nlt.Person__c)) {
                dupes.add(nlt);
            }
        }
        return dupes;
    }
}
