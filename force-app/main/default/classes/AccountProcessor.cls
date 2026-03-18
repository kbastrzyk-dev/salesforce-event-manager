public with sharing class AccountProcessor {
    
    public static void createAccounts() {
        List<Account> accountsToInsert = new List<Account>();
        for(Integer i = 1; i <= 5; i++) {
            Account newAcc = new Account();
            newAcc.Name = 'Astro Test ' + i;
            accountsToInsert.add(newAcc);
        }
        
        insert accountsToInsert;
        
    }
    public static void updateTestAccounts() {
        List<Account> accountsToUpdate = new List<Account>();
        for(Account acc : [SELECT Name, Id FROM Account WHERE Name LIKE 'Astro%']) {
            acc.Name = acc.Name + ' - Updated';
            accountsToUpdate.add(acc);
        }
        update accountsToUpdate;
    }
}