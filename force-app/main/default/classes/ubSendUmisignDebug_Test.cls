@isTest
public with sharing class ubSendUmisignDebug_Test {
  @TestSetup
  private static void setup() {
    FlexCompos__Signature_Provider_Key__c s = new FlexCompos__Signature_Provider_Key__c(
      FlexCompos__Key__c = 'test'
    );
    insert s;

    Contact c = new Contact(LastName = 'c');
    insert c;

    FlexCompos__Paperwork__c p = new FlexCompos__Paperwork__c(
      FlexCompos__Contact__c = c.Id,
      FlexCompos__Envelope_Id__c = '0000'
    );
    insert p;

    ContentVersion version = new ContentVersion(
      Title = 'Test',
      PathOnClient = 'Test.pdf',
      VersionData = Blob.valueOf('Test Content')
    );
    insert version;

    version = [
      SELECT ContentDocumentId
      FROM ContentVersion
      WHERE Id = :version.Id
    ];

    List<ContentDocument> documents = [
      SELECT Id, Title, LatestPublishedVersionId
      FROM ContentDocument
    ];

    ContentDocumentLink cdl = new ContentDocumentLink();
    cdl.LinkedEntityId = p.Id;
    cdl.ContentDocumentId = documents[0].Id;
    cdl.shareType = 'V';

    insert cdl;
  }

@isTest
    private static void testSendToSign() {
        FlexCompos__Paperwork__c p = [
            SELECT Id
            FROM FlexCompos__Paperwork__c
            WHERE FlexCompos__Contact__r.LastName = 'c'
        ];

        ubSendUmisignDebug.paramRequest request = new ubSendUmisignDebug.paramRequest(p.Id, 'Sign');

        Test.startTest();
        // Perform your test logic here
        List<String> result = ubSendUmisignDebug.request(new List<ubSendUmisignDebug.paramRequest>{request});
        Test.stopTest();

        System.assertEquals(1, result.size());
        System.assertEquals('Created', result[0]);
    }

    @isTest
    private static void testSendToVerify() {
        FlexCompos__Paperwork__c p = [
            SELECT Id
            FROM FlexCompos__Paperwork__c
            WHERE FlexCompos__Contact__r.LastName = 'c'
        ];

        ubSendUmisignDebug.paramRequest request = new ubSendUmisignDebug.paramRequest(p.Id, 'Verify');

        Test.startTest();
        // Perform your test logic here
        List<String> result = ubSendUmisignDebug.request(new List<ubSendUmisignDebug.paramRequest>{request});
        Test.stopTest();

        System.assertEquals(1, result.size());
        System.assertEquals('Signed', result[0]);
    }
}