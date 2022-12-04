public with sharing class CTRecentChangesController {
    @AuraEnabled
    public static List<Person__c> getRecentPersonHealthChanges() {
        List<Person__c> result = CTPersonController.getRecentHealthChanges();
        if (result != null && result.size() > 0) {
            return result;
        }
        return null;
    }

    @AuraEnabled
    public static List<Location__c> getRecentLocationHealthChanges() {
        List<Location__c> result = CTLocationController.getRecentStatusChanges();
        if (result != null && result.size() > 0) {
            return result;
        }
        return null;
    }

    @AuraEnabled
    public static List<Person__c> searchPeople(String searchTerm) {
        List<Person__c> result = CTPersonController.searhPeople(searchTerm);
        if (result != null && result.size() > 0) {
            return result;
        }
        return null;
    }

    @AuraEnabled
    public static List<Location__c> searchLocation(String searchTerm) {
        List<Location__c> result = CTLocationController.searhLocation(searchTerm);
        if (result != null && result.size() > 0) {
            return result;
        }
        return null;
    }
}
