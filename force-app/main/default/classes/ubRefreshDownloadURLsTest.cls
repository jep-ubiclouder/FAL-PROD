@isTest
private class ubRefreshDownloadURLsTest {
    
    @testSetup
    static void setupTestData() {
        // Create test FlexCompos__Paperwork__c records
        ContentVersion contentVersion = new ContentVersion(
            Title = 'Penguins',
            PathOnClient = 'Penguins.jpg',
            VersionData = Blob.valueOf('Test Content'),
            IsMajorVersion = true
            );
            insert contentVersion;    
            List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
       
           
     Contact dummy = new Contact(LastNAme = 'dummy');
        insert dummy;
       FlexCompos__Paperwork__c PPW = new FlexCompos__Paperwork__c(
          FlexCompos__Uploaded__c = true,
          FlexCompos__Approved__c = true,
          FlexCompos__Contact__c = dummy.Id,
          FlexCompos__Download_URL__c = 'https://old-domain.com/download/123'

        );
        insert PPW;
    
    ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.LinkedEntityId = PPW.Id;
            cdl.ContentDocumentId = documents[0].Id;
            cdl.shareType = 'V';

            insert cdl;
    }
    @isTest
    static void testBatchExecution_WithValidContentDistribution() {
        // Get test paperwork records
            ubRefreshDownloadURLs batchJob = new ubRefreshDownloadURLs();
        Database.executeBatch(batchJob, 5);
    }
    
   
}