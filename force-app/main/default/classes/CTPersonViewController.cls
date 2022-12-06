public with sharing class CTPersonViewController {
    @AuraEnabled
    public static void changeStatusToRed(String personId) {
        try {
            Person__c p = new Person__c(Id=personId);
            p.Health_Status__c = 'Red';
            system.debug('p '+p);
            update p;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
