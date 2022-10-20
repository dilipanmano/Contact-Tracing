trigger CTPersonTrigger on Person__c(
  before insert,
  after insert,
  before update,
  after update,
  before delete,
  after delete,
  after undelete
) {
  switch on Trigger.OperationType {
    when Before_Insert {
      CTPersonTriggerHandler.setStatus(Trigger.new);
      CTPersonTriggerHandler.setToken(Trigger.new);
    }
    when Before_Update {
      CTPersonTriggerHandler.setStatusUpdateDate(Trigger.new, Trigger.oldMap);
    }

    when After_Update {
      CTPersonTriggerHandler.setHealthStatus(Trigger.new, Trigger.oldMap);
    }
  }
}
