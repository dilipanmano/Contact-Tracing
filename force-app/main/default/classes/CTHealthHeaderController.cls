public with sharing class CTHealthHeaderController {
    @AuraEnabled
    public static Map<String, Integer> getPersonHealthStatusCount() {
        Map<String, Integer> result = CTPersonController.getHealthStatusCount();
        if (result != null && result.size() > 0) {
            return result;
        }
        return null;
    }

    @AuraEnabled
    public static Map<String, Integer> getLocationHealthStatusCount() {
        Map<String, Integer> result = CTLocationController.getStatusCount();
        if (result != null && result.size() > 0) {
            return result;
        }
        return null;
    }
}
