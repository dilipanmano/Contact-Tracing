trigger ContactTrigger on Contact(after insert, after update, after delete, after undelete) {
  switch on Trigger.OperationType {
    when AFTER_INSERT {
      ContactTriggerHandler.activeContactCountInsert(Trigger.new);
    }
    when AFTER_UPDATE {
      ContactTriggerHandler.activeContactCountUpdate(
        Trigger.new,
        Trigger.oldMap
      );
    }
    when AFTER_DELETE {
      ContactTriggerHandler.activeContactCountDelete(Trigger.old);
    }
    when AFTER_UNDELETE {
      ContactTriggerHandler.activeContactCountUndelete(Trigger.new);
    }
  }
}
