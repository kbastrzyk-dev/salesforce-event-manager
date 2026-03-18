public with sharing class AttendeeTriggerHandler {
    public static void handleBeforeInsert(List<Attendee__c> newAttendees) {
        // Creating new set to store the event ids.
        Set<Id> eventsIds = new Set<Id>();
        for(Attendee__c att : newAttendees) {
            // Adding the event to that set.
            eventsIds.add(att.Event__c);
            
        }
        // querying events and storing them in a map
        Map<Id, Event__c> eventMap = new Map<Id, Event__c>([SELECT Id, Max_Capacity__c, Registered_Attendees__c FROM Event__c WHERE Id IN :eventsIds]);
        for(Attendee__c att : newAttendees) {
            // Getting the parent event from the map.
            Event__c parentEvent = eventMap.get(att.Event__c);
            // Checking if the event is at max capacity.
            if(parentEvent.Registered_Attendees__c >= parentEvent.Max_Capacity__c) {
                att.Registration_Status__c = 'Waitlisted';
            } else {
                // If not set as 'Registered'
                att.Registration_Status__c = 'Registered';
            }
        }
    }
    public static void handleBeforeUpdate(List<Attendee__c> newAttendees, Map<Id, Attendee__c> oldMap) {
        // Creating a new set to store the event ids
        Set<Id> eventsIds = new Set<Id>();
        //  Only collect Event Ids if the user is changing the status TO 'Registered'
        for(Attendee__c att : newAttendees) {
            Attendee__c oldAtt = oldMap.get(att.Id);
            if(att.Registration_Status__c == 'Registered' && oldAtt.Registration_Status__c != 'Registered') {
                // 2. If so, add the event id to the set
                eventsIds.add(att.Event__c);
            }
        }
        // If nobody is changing their status to 'Registered', we can just exit the method
        if(eventsIds.isEmpty()) {
            return;
        }
        // Query the events based on the collected ids and store them in a map
        Map<Id, Event__c> eventMap = new Map<Id, Event__c>([SELECT Id, Max_Capacity__c, Registered_Attendees__c FROM Event__c WHERE Id IN :eventsIds]);
        //loop through attendees again and throw an error if the event is full
        for(Attendee__c att : newAttendees) {
            Attendee__c oldatt = oldMap.get(att.Id);
            if(att.Registration_Status__c == 'Registered' && oldatt.Registration_Status__c != 'Registered') {
                Event__c parentEvent = eventMap.get(att.Event__c);
                // Checking the capacity
                if(parentEvent.Registered_Attendees__c >= parentEvent.Max_Capacity__c) {
                    // adding error
                    att.addError('This event is at max capacity. You cannot change your registration status to Registered');
                }
            }
        }
    }
    public static void handleAfterUpdate(List<Attendee__c> newAttendees, Map<Id, Attendee__c> oldMap) {
        // creating a Set to store Cancelled Event Ids
        Set<Id> eventIdsWithCancellations = new Set<Id>();
        // Check if someone who was 'Registered' changed to 'Canceled'
        for(Attendee__c att : newAttendees) {
            Attendee__c oldAtt = oldMap.get(att.Id);
            if(att.Registration_Status__c == 'Canceled' && oldAtt.Registration_Status__c == 'Registered') {
                // If so, add the event id to the set
                eventIdsWithCancellations.add(att.Event__c);
            }
        }
        // If nobody changed from 'Registered' to 'Canceled', we can just exit the method
        if(eventIdsWithCancellations.isEmpty()) {
            return;
        }
        // We need to query to find out which attendees are the longest waitlisted for those events
        List<Attendee__c> waitlistedAttendees = [SELECT Id, Registration_Status__c, Event__c FROM Attendee__c WHERE Event__c IN:eventIdsWithCancellations AND Registration_Status__c = 'Waitlisted' ORDER BY CreatedDate ASC LIMIT 1];
        // If we find any waitlisted attendees, we will change their status to 'Registered'
        if(!waitlistedAttendees.isEmpty()) {
            List<Attendee__c> attendeesToUpdate = new List<Attendee__c>();

            for(Attendee__c waitlistedAtt : waitlistedAttendees) {
                    waitlistedAtt.Registration_Status__c = 'Registered';
                    attendeesToUpdate.add(waitlistedAtt);
            }
        
        // update database
        update attendeesToUpdate;
        }
    }
}