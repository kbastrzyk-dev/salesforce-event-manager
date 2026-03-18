public class AccountNameStandardizationBatch implements Database.Batchable<SObject> {
    // 1 START Select the data
    public Database.QueryLocator start(Database.BatchableContext bc) {
        // This is to bypass the 50000 SOQL Limit
        return Database.getQueryLocator('SELECT Id, Description, Name FROM Account');
    }
    public void execute(Database.BatchableContext bc, List<Account> scope) {
        // 2.1 Create empty list to update records
        List<Account> accountsToUpdate = new List<Account>();
        // 2.2 Process the data
        for(Account acc : scope) {
            acc.Name = acc.Name + ' - Processed';
            accountsToUpdate.add(acc);
        }
        //2.3 Update the records
        update accountsToUpdate;
    }
    //3 Finish to wrap it up
    public void finish(Database.BatchableContext bc) {
        System.debug('Batch job is complete! :)');
    }
}