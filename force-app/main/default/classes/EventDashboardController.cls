public with sharing class EventDashboardController {
    
    @AuraEnabled(cacheable=true)
    public static List<Event__c> getUpcomingEvents() {
        return [
            SELECT Id, Name, Max_Capacity__c, Registered_Attendees__c, Event_Date__c 
            FROM Event__c 
            WHERE Status__c = 'Upcoming'
            ORDER BY Event_Date__c ASC
        ];
    }
}