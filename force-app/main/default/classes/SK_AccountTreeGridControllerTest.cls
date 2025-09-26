@isTest
public class SK_AccountTreeGridControllerTest {
    @isTest public static void testWarmTemp() {
        Account a = new Account(Name='TESTULTIMATEPARENT');
        a.type='Foundation';
        a.Email_Corporate__c='UP@test.lu';
        a.Phone='00352269111';
        insert a;
            
        Account b = new Account(Name='TESTPARENT');
        b.type ='Foundation';
        b.ParentId = a.Id;
        b.Email_Corporate__c='P@test.lu';
        b.Phone='00352269112';
        insert b;
        
        Account c = new Account(Name='TESTCHILD');
        c.type='Foundation';
        c.Email_Corporate__c='C@test.lu';
        c.Phone='00352269113';
        c.ParentId=b.Id;
        insert c;
            
        
        
        List<Account> result = SK_AccountTreeGridCmpController.findHierarchyData(c.Id);
        
        List<Account> testresult = [SELECT Id,name,type,Email_Corporate__c,Phone,parentId
                       FROM Account 
                       WHERE  Name='TESTULTIMATEPARENT' OR Name='TESTPARENT' OR Name='TESTCHILD'];
        System.assertEquals(testresult,result);
    }
}