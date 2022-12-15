public with sharing class CTLocationTabController {
    @AuraEnabled
    public static LocationInformation getLocationDetails(string recordId) {
        Location__c location = CTLocationController.getLocationById(recordId);
        List<Location_Tracing__c> traces = CTLocationTracingController.getVisitors(recordId);

        LocationInformation li = new LocationInformation();
        if (li != null) {
            li.Name = location.Name;
            li.Address = location.Address__c;
            li.Pincode = location.Pincode__c;
            li.redScore = Integer.valueOf(location.Red_Score__c);
            li.Status = location.Status__c;
            li.statusUpdateDate = location.Status_Update_Date__c;
        }

        List<visitorInformation> visitorList = new List<visitorInformation>();

        if (traces != null && traces.size() > 0) {
            for (Location_Tracing__c trace : traces) {
                visitorInformation vi = new visitorInformation();
                vi.Name = trace.Person__r.Name;
                vi.Token = trace.Person__r.Token__c;
                vi.healthStatus = trace.Person__r.Health_Status__c;
                vi.visitDate = trace.Visit_Date__c;
                visitorList.add(vi);
            }

            li.visitors = visitorList;
        }

        return li;
    }

    public class LocationInformation {
        @AuraEnabled
        public String Name;
        @AuraEnabled
        public String Address;
        @AuraEnabled
        public String Pincode;
        @AuraEnabled
        public Integer redScore;
        @AuraEnabled
        public String Status;
        @AuraEnabled
        public Date statusUpdateDate;
        @AuraEnabled
        public List<visitorInformation> visitors;
    }

    public class visitorInformation {
        @AuraEnabled
        public String Name;
        @AuraEnabled
        public String healthStatus;
        @AuraEnabled
        public String Token;
        @AuraEnabled
        public Date visitDate;
    }
}
