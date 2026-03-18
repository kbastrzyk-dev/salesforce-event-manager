public with sharing class AccountTriggerHandler {
    public static void handleBeforeInsert(List<Account> newAccounts) {
        for(Account acc : newAccounts) {
            if(acc.Industry == 'Technology') {
                acc.Rating = 'Hot';
            } 
        }
    }
    public static void handleBeforeUpdate(List<Account> newAccounts, Map<Id, Account> OldAccountMap) {
        for(Account acc: newAccounts) {
            Account oldAcc = OldAccountMap.get(acc.Id);
            if(acc.Phone != oldAcc.Phone) {
                acc.Description = 'Phone number was recently updated.';
            }
        }
    }
}