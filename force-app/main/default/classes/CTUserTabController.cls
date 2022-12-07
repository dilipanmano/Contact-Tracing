public with sharing class CTUserTabController {
    @AuraEnabled
    public static UserInformation getUserDetails(String recordId) {
        Person__c person = CTPersonController.getPersonById(recordId);
        List<People_Tracing__c> traces = CTPeopleTracingController.getTraces(recordId);

        UserInformation userInfo = new UserInformation();
        if (person != null) {
            userInfo.name = person.Name;
            userInfo.token = person.Token__c;
            userInfo.statusUpdatedOn = person.Status_Update_Date__c;
            userInfo.phone = person.Mobile__c;
            userInfo.status = person.Health_Status__c;
        }

        if (traces != null && traces.size() > 0) {
            List<ContactInformation> contacts = new List<ContactInformation>();
            Set<Id> uniqueIds = new Set<Id>();
            uniqueIds.add(recordId);
            for (People_Tracing__c trace : traces) {
                ContactInformation ci = new ContactInformation();
                if (!uniqueIds.contains(trace.Person_1__c)) {
                    ci.Id = trace.Person_1__c;
                    ci.token = trace.Person_1__r.Health_Status__c;
                    ci.contactDate = trace.Contact_Date__c;
                    ci.status = trace.Person_1__r.Health_Status__c;
                }
                if (!uniqueIds.contains(trace.Person_2__c)) {
                    ci.Id = trace.Person_2__c;
                    ci.token = trace.Person_2__r.Health_Status__c;
                    ci.contactDate = trace.Contact_Date__c;
                    ci.status = trace.Person_2__r.Health_Status__c;
                }
                contacts.add(ci);
            }

            userInfo.contact = contacts;
            userInfo.contactsCount = contacts.size();
        }

        return userInfo;
    }

    public class UserInformation {
        @AuraEnabled
        public String name;
        @AuraEnabled
        public String token;
        @AuraEnabled
        public Date statusUpdatedOn;
        @AuraEnabled
        public String phone;
        @AuraEnabled
        public String status;
        @AuraEnabled
        public List<ContactInformation> contact;
        @AuraEnabled
        public Integer contactsCount;
    }

    public class ContactInformation {
        @AuraEnabled
        public String Id;
        @AuraEnabled
        public String token;
        @AuraEnabled
        public Date contactDate;
        @AuraEnabled
        public String status;
    }
}
