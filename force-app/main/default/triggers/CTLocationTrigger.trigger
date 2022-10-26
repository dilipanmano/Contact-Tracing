trigger CTLocationTrigger on Location__c(
  before insert,
  after insert,
  before update,
  after update
) {
  switch on Trigger.OperationType {
    when BEFORE_INSERT {
      CTLocationTriggerHandler.setStatus(Trigger.new);
    }
    when BEFORE_UPDATE {
      CTLocationTriggerHandler.setStatusUpdateDate(Trigger.new, Trigger.oldMap);
    }
    when AFTER_UPDATE {
      CTLocationTriggerHandler.locationStatusRed(Trigger.new, Trigger.oldMap);
    }
  }
}
