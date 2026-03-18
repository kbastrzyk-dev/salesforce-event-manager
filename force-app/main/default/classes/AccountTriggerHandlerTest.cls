@isTest
private class AccountTriggerHandlerTest {
    @isTest static void testTechnologyRating() {
        Account testAcc = new Account(Name = 'Test', Industry = 'Technology');
        Test.startTest();
        insert testAcc;
        Test.stopTest();

        Account insertedAcc = [SELECT Name, Industry, Rating FROM Account WHERE Id=:testAcc.Id];
        Assert.areEqual('Hot', insertedAcc.Rating, 'The rating should be set to Hot for Technology industry');
    }
    @isTest static void testPhoneUpdateDescription() {
        Account testAcc = new Account(Name = 'Test', Phone = '111-1111');
        insert testAcc;
        Test.startTest();

        testAcc.Phone = '222-2222';
        update testAcc;
        Test.stopTest();

        Account updatedAcc = [SELECT Name, Phone, Description FROM Account WHERE Id=:testAcc.Id];
        Assert.areEqual('Phone number was recently updated.', updatedAcc.Description, 'The description should indicate that the phone number was updated');
        
    }
}