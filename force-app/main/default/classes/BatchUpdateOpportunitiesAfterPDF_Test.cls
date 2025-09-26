@isTest
private class BatchUpdateOpportunitiesAfterPDF_Test {
    @isTest static void test() {
        Test.startTest();
        Campaign cmp = new Campaign (Name = 'TestCampaign', StartDate = Date.parse('01.05.22'), Ordre_permanent__c = false, EndDate = Date.parse('30.05.22'), Extern_key__c = 'TestCampaign12');
        insert cmp;

        Campaign cmp2 = new Campaign (Name = 'TestCampaign', StartDate = Date.parse('01.05.22'), Ordre_permanent__c = true, EndDate = Date.parse('30.05.22'), Extern_key__c = 'TestCampaign1245');
        insert cmp2;

        Contact cnt = new Contact (Salutation = 'Madame', Entete_Lettre_Remerciement__c = 'Madame', FirstName = 'Catherine', LastName = 'Fouss', MailingStreet = 'Street2', MailingCity = 'Luxembourg',
        MailingCountry = 'Luxembourg', MailingPostalCode = '789654', Acknowledgement__c = 'Once a year', Maternal_Language_1__c = 'français', Statut_Juridique__c='P');
        insert cnt;

        CampaignMember cm2 = new CampaignMember (CampaignId = cmp.Id, ContactId = cnt.Id);
        insert cm2;

        Opportunity oppannuel1 = new Opportunity (Name = 'oppannuel1', npsp__Primary_Contact__c = cnt.Id, CampaignId = cmp.Id, Amount = 300, CloseDate = Date.parse('11.05.22'), PDF_cree__c = false, StageName = 'Closed Lost');
        insert oppannuel1;
        Opportunity oppannuel2 = new Opportunity (Name = 'oppannuel2', npsp__Primary_Contact__c = cnt.Id, CampaignId = cmp.Id, Amount = 700, CloseDate = Date.parse('18.05.22'), PDF_cree__c = false, StageName = 'Closed Lost');
        insert oppannuel2;
        
        List<npsp__Trigger_Handler__c> npsptriggers = [SELECT npsp__Object__c, npsp__Active__c FROM npsp__Trigger_Handler__c WHERE npsp__Object__c = 'Opportunity'];
        
        BatchUpdateOpportunitiesAfterPDFCreate mybatch = new BatchUpdateOpportunitiesAfterPDFCreate(cmp.Id, 'getDataAnnuel');
        Id batchId = Database.executeBatch(mybatch, 2);

        BatchUpdateOpportunitiesAfterPDFCreate mybatch2 = new BatchUpdateOpportunitiesAfterPDFCreate(cmp2.Id, 'getDataAnnualEnt');
        Id batchId2 = Database.executeBatch(mybatch2, 2);

        BatchUpdateOpportunitiesAfterPDFCreate mybatch4 = new BatchUpdateOpportunitiesAfterPDFCreate(cmp2.Id, 'getDataOP');
        Id batchId4 = Database.executeBatch(mybatch4, 2);

        BatchUpdateOpportunitiesAfterPDFCreate mybatch5 = new BatchUpdateOpportunitiesAfterPDFCreate(cmp2.Id, 'getDataOPEnt');
        Id batchId5 = Database.executeBatch(mybatch5, 2);

        BatchUpdateCampaignMembersAfterPDF mybatch3 = new BatchUpdateCampaignMembersAfterPDF(cmp2.Id, 'getDataAnnuel');
        Id batchId3 = Database.executeBatch(mybatch3, 2);

        BatchUpdateCampaignMembersAfterPDF mybatch6 = new BatchUpdateCampaignMembersAfterPDF(cmp2.Id, 'getDataAnnualEnt');
        Id batchId6 = Database.executeBatch(mybatch6, 2);

        BatchUpdateCampaignMembersAfterPDF mybatch7 = new BatchUpdateCampaignMembersAfterPDF(cmp2.Id, 'getDataOP');
        Id batchId7 = Database.executeBatch(mybatch7, 2);

        BatchUpdateCampaignMembersAfterPDF mybatch8 = new BatchUpdateCampaignMembersAfterPDF(cmp2.Id, 'getDataOPEnt');
        Id batchId8 = Database.executeBatch(mybatch8, 2);

        Test.stopTest();
    }
}