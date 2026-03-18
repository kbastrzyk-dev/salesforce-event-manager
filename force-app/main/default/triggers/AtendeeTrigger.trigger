trigger AtendeeTrigger on Attendee__c (before insert, before update, after update) {
    if(Trigger.isBefore && Trigger.isInsert) {
        AttendeeTriggerHandler.handleBeforeInsert(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate) {
        AttendeeTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
    if(Trigger.isAfter &&  Trigger.isUpdate) {
        AttendeeTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    }
}