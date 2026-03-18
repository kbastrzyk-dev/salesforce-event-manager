public with sharing class AccountDataController {
    
    // The annotation that exposes this method to Lightning Web Components
    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(Id accountId) {
        // Query for contacts attached to the specific account
        return [SELECT Id, Name, Title FROM Contact WHERE AccountId = :accountId LIMIT 5];
    }
}