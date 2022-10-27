public with sharing class CTLocationTracingTriggerHandler {
  public static void checkDuplicates(
    List<Location_Tracing__c> newLocationTracing
  ) {
    List<Location_Tracing__c> dupes = CTLocationTracingController.checkDuplicates(
      newLocationTracing
    );
    for (Location_Tracing__c pt : dupes) {
      pt.addError('Duplicate record ' + pt.Location__c);
    }
  }
}
