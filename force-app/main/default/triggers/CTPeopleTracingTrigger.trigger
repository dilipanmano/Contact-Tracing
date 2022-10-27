trigger CTPeopleTracingTrigger on People_Tracing__c(before insert) {
  switch on Trigger.OperationType {
    when BEFORE_INSERT {
      CTPeopleTracingTriggerHandler.checkDuplicates(Trigger.new);
    }
  }
}
