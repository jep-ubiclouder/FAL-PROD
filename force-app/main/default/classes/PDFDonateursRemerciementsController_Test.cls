@isTest
public class PDFDonateursRemerciementsController_Test {

    /* public static void testgetData(){
        Campaign cmp = new Campaign (Name = 'TestCampaign', Extern_key__c = 'TestCampaign-2022', Ordre_permanent__c = false);
        insert cmp;
 
        ApexPages.StandardController sc = new ApexPages.StandardController(cmp);
        PDFDonateursRemerciementsController controller = new PDFDonateursRemerciementsController(sc);

        Contact cnt1 = new Contact (Salutation = 'Madame', Entete_Lettre_Remerciement__c = 'Madame', FirstName = 'Marina', LastName = 'Tutaeva', MailingStreet = 'Street1', MailingCity = 'Arlon',
        MailingCountry = 'Belgique', MailingPostalCode = '12365', Acknowledgement__c = 'Once per opportunity', Maternal_Language_1__c = 'français', Statut_Juridique__c='P');
        insert cnt1;
        
        CampaignMember cm1 = new CampaignMember (CampaignId = cmp.Id, ContactId = cnt1.Id);
        insert cm1;

        Opportunity oppper = new Opportunity (EUcom__Contact__c = cnt1.Id, PDF_cree__c = false, CampaignId = cmp.Id, Amount = 250, CloseDate = Date.parse('11.05.22'), npsp__Primary_Contact__c = cnt1.Id);
        Opportunity oppannuel2 = new Opportunity (EUcom__Contact__c = cnt1.Id, PDF_cree__c = false, CampaignId = cmp.Id, Amount = 700, CloseDate = Date.parse('18.05.22'), npsp__Primary_Contact__c = cnt1.Id);
        list<Opportunity> listentrepriseopps = new list<Opportunity>();
        listentrepriseopps.add(oppper);
        listentrepriseopps.add(oppannuel2);

        list<CampaignMember> listcm1 = new list<CampaignMember>();
        listcm1.add(cm1);

        for(Opportunity opget:listentrepriseopps){
            PDFDonateursRemerciementsController.Remerciment donrem = new PDFDonateursRemerciementsController.Remerciment(opget.npsp__Primary_Contact__r.Salutation, opget.npsp__Primary_Contact__r.Entete_Lettre_Remerciement__c, opget.npsp__Primary_Contact__r.FirstName, opget.npsp__Primary_Contact__r.LastName, opget.amount, 
            opget.npsp__Primary_Contact__r.MailingStreet, opget.npsp__Primary_Contact__r.MailingCity, opget.npsp__Primary_Contact__r.MailingCountry, opget.npsp__Primary_Contact__r.MailingPostalCode, 
                                                                        opget.CloseDate, cnt1.Maternal_Language_1__c, cmp.Name);
        
        List<PDFDonateursRemerciementsController.Remerciment> listremerciments = new list<PDFDonateursRemerciementsController.Remerciment>();
        listremerciments.add(donrem);
        }
        controller.getData();
                                                                
    } */

    @isTest 
        public static void testgetDataAnnuel(){
        Campaign cmp = new Campaign (Name = 'TestCampaign', StartDate = Date.parse('01.05.22'), Ordre_permanent__c = false, EndDate = Date.parse('30.05.22'), Extern_key__c = 'TestCampaign12');
        insert cmp;
 
        ApexPages.StandardController sc = new ApexPages.StandardController(cmp);
        PDFDonateursRemerciementsController controller = new PDFDonateursRemerciementsController(sc);

        Contact cnt2 = new Contact (Salutation = 'Madame', Entete_Lettre_Remerciement__c = 'Madame', FirstName = 'Catherine', LastName = 'Fouss', MailingStreet = 'Street2', MailingCity = 'Luxembourg',
        MailingCountry = 'Luxembourg', MailingPostalCode = '789654', Acknowledgement__c = 'Once a year', Maternal_Language_1__c = 'français', Statut_Juridique__c='P');
        insert cnt2;
        
        CampaignMember cm2 = new CampaignMember (CampaignId = cmp.Id, ContactId = cnt2.Id);
        insert cm2;

        Opportunity oppannuel1 = new Opportunity (Name = 'oppannuel1',  StageName = 'Closed Lost', npsp__Primary_Contact__c = cnt2.Id, CampaignId = cmp.Id, Amount = 300, CloseDate = Date.parse('11.05.22'), PDF_cree__c = false);
        insert oppannuel1;
        Opportunity oppannuel2 = new Opportunity (Name = 'oppannuel2',  StageName = 'Closed Lost', npsp__Primary_Contact__c = cnt2.Id, CampaignId = cmp.Id, Amount = 700, CloseDate = Date.parse('18.05.22'), PDF_cree__c = false);
        insert oppannuel2;

        list<CampaignMember> listcm2 = new list<CampaignMember>();
        listcm2.add(cm2);

        PDFDonateursRemerciementsController.RemercimentAnnuel annrem = new PDFDonateursRemerciementsController.RemercimentAnnuel(cnt2.Salutation, cnt2.Entete_Lettre_Remerciement__c, cnt2.FirstName, cnt2.LastName, oppannuel1.amount, 
        cnt2.MailingStreet, cnt2.MailingCity, cnt2.MailingCountry, cnt2.MailingPostalCode, cnt2.Maternal_Language_1__c, cmp.EndDate);
        
        list<Contact> listcontact = new list<Contact>();
        listcontact.add(cnt2);

        List<PDFDonateursRemerciementsController.RemercimentAnnuel> listremercimentannuel = new list<PDFDonateursRemerciementsController.RemercimentAnnuel>();
        listremercimentannuel.add(annrem);
        controller.getDataAnnuel();
    }
 
    
    
    
    
    
    /* @isTest 
        public static void testgetDataEnt(){
        Campaign cmp = new Campaign (Name = 'TestCampaign', StartDate = Date.parse('01.05.22'), EndDate = Date.parse('30.05.22'), Ordre_permanent__c = false, Extern_key__c = 'testcampaign852');
        insert cmp;
 
        ApexPages.StandardController sc = new ApexPages.StandardController(cmp);
        PDFDonateursRemerciementsController controller = new PDFDonateursRemerciementsController(sc);

        Account acc = new Account (Name = 'Acme', billingstreet = 'billingstreet', billingcity = 'billingcity', billingcountry = 'billingcountry', billingpostalcode = '78965');

        Contact cnt1 = new Contact (Salutation = 'Madame', Entete_Lettre_Remerciement__c = 'Madame', FirstName = 'Marina', LastName = 'Tutaeva', MailingStreet = 'Street1', MailingCity = 'Arlon',
        MailingCountry = 'Belgique', MailingPostalCode = '12365', Acknowledgement__c = 'Once per opportunity', Maternal_Language_1__c = 'français', Statut_Juridique__c='S', AccountId = acc.Id);
        insert cnt1;

        CampaignMember cm3 = new CampaignMember (CampaignId = cmp.Id, ContactId = cnt1.Id);
        insert cm3;
        list<CampaignMember> listcm3 = new list<CampaignMember>();
        listcm3.add(cm3);

        list<Opportunity> listentrepriseopps = new list<Opportunity>();
        Opportunity oppannuel1 = new Opportunity (Name = 'oppannuel1',  StageName = 'Closed Lost', npsp__Primary_Contact__c = cnt1.Id, CampaignId = cmp.Id, Amount = 300, CloseDate = Date.parse('11.05.22'), PDF_cree__c = false);
        insert oppannuel1;
        Opportunity oppannuel2 = new Opportunity (Name = 'oppannuel2',  StageName = 'Closed Lost', npsp__Primary_Contact__c = cnt1.Id, CampaignId = cmp.Id, Amount = 700, CloseDate = Date.parse('18.05.22'), PDF_cree__c = false);
        insert oppannuel2;
        listentrepriseopps.add(oppannuel1);
        listentrepriseopps.add(oppannuel2);
        
        for(Opportunity opent:listentrepriseopps){
            PDFDonateursRemerciementsController.RemercimentEntr entrrem = new PDFDonateursRemerciementsController.RemercimentEntr(cnt1.Entete_Lettre_Remerciement__c, acc.name, opent.amount, 
                                                                        acc.billingstreet, acc.billingcity, acc.billingcountry, acc.billingpostalcode,
                                                                        opent.CloseDate, cnt1.Maternal_Language_1__c, cmp.Name);
        
        List<PDFDonateursRemerciementsController.RemercimentEntr> RemercimentEntrs = new list<PDFDonateursRemerciementsController.RemercimentEntr>();
        RemercimentEntrs.add(entrrem);
        }
        controller.getDataEnt2();

    }
 */
    @isTest 
        public static void testgetDataAnnualEnt(){
        Campaign cmp = new Campaign (Name = 'TestCampaign', StartDate = Date.parse('01.05.22'), Ordre_permanent__c = false, EndDate = Date.parse('30.05.22'), Extern_key__c = 'TestCampaign12');
        insert cmp;
 
        ApexPages.StandardController sc = new ApexPages.StandardController(cmp);
        PDFDonateursRemerciementsController controller = new PDFDonateursRemerciementsController(sc);

        Account acc = new Account (Name = 'Acme', billingstreet = 'billingstreet', billingcity = 'billingcity', billingcountry = 'billingcountry', billingpostalcode = '78965');

        Contact cnt2 = new Contact (Salutation = 'Madame', Entete_Lettre_Remerciement__c = 'Madame', FirstName = 'Catherine', LastName = 'Fouss', MailingStreet = 'Street2', MailingCity = 'Luxembourg',
        MailingCountry = 'Luxembourg', MailingPostalCode = '789654', Acknowledgement__c = 'Once a year', Maternal_Language_1__c = 'français', Statut_Juridique__c='ASSOC',  AccountId = acc.Id);
        insert cnt2;
        
        CampaignMember cm2 = new CampaignMember (CampaignId = cmp.Id, ContactId = cnt2.Id);
        insert cm2;

        Opportunity oppannuel1 = new Opportunity (Name = 'oppannuel1',  StageName = 'Closed Lost', npsp__Primary_Contact__c = cnt2.Id, CampaignId = cmp.Id, Amount = 300, CloseDate = Date.parse('11.05.22'), PDF_cree__c = false);
        insert oppannuel1;
        Opportunity oppannuel2 = new Opportunity (Name = 'oppannuel2',  StageName = 'Closed Lost', npsp__Primary_Contact__c = cnt2.Id, CampaignId = cmp.Id, Amount = 700, CloseDate = Date.parse('18.05.22'), PDF_cree__c = false);
        insert oppannuel2;

        list<CampaignMember> listcm2 = new list<CampaignMember>();
        listcm2.add(cm2);

        PDFDonateursRemerciementsController.RemercimentAnnualEntr annrem = new PDFDonateursRemerciementsController.RemercimentAnnualEntr(cnt2.Entete_Lettre_Remerciement__c, acc.Name, oppannuel1.amount, acc.billingcity,
        acc.billingcountry, acc.billingstreet, acc.billingpostalcode, cmp.EndDate, cnt2.Maternal_Language_1__c);
        
        list<Contact> listcontact = new list<Contact>();
        listcontact.add(cnt2);

        List<PDFDonateursRemerciementsController.RemercimentAnnualEntr> listremercimentAnnualEnt = new list<PDFDonateursRemerciementsController.RemercimentAnnualEntr>();
        listremercimentAnnualEnt.add(annrem);
        controller.getDataAnnualEnt();

    }

    @isTest 
        public static void testgetDataOPEnt(){
        Campaign cmp = new Campaign (Name = 'TestCampaign', StartDate = Date.parse('01.05.22'), Ordre_permanent__c = true, EndDate = Date.parse('30.05.22'), Extern_key__c = 'TestCampaign12');
        insert cmp;
 
        ApexPages.StandardController sc = new ApexPages.StandardController(cmp);
        PDFDonateursRemerciementsController controller = new PDFDonateursRemerciementsController(sc);

        Account acc = new Account (Name = 'Acme', billingstreet = 'billingstreet', billingcity = 'billingcity', billingcountry = 'billingcountry', billingpostalcode = '78965');

        Contact cnt2 = new Contact (Salutation = 'Madame', Entete_Lettre_Remerciement__c = 'Madame', FirstName = 'Catherine', LastName = 'Fouss', MailingStreet = 'Street2', MailingCity = 'Luxembourg',
        MailingCountry = 'Luxembourg', MailingPostalCode = '789654', Acknowledgement__c = 'Once per opportunity', Maternal_Language_1__c = 'français', Statut_Juridique__c='ASSOC',  AccountId = acc.Id);
        insert cnt2;
        
        CampaignMember cm2 = new CampaignMember (CampaignId = cmp.Id, ContactId = cnt2.Id);
        insert cm2;

        Opportunity oppannuel1 = new Opportunity (Name = 'oppannuel1',  StageName = 'Closed Lost', npsp__Primary_Contact__c = cnt2.Id, CampaignId = cmp.Id, Amount = 300, CloseDate = Date.parse('11.05.22'), PDF_cree__c = false);
        insert oppannuel1;
        Opportunity oppannuel2 = new Opportunity (Name = 'oppannuel2',  StageName = 'Closed Lost', npsp__Primary_Contact__c = cnt2.Id, CampaignId = cmp.Id, Amount = 700, CloseDate = Date.parse('18.05.22'), PDF_cree__c = false);
        insert oppannuel2;

        list<CampaignMember> listcm2 = new list<CampaignMember>();
        listcm2.add(cm2);

        PDFDonateursRemerciementsController.RemercimentOPEnt companyOP = new PDFDonateursRemerciementsController.RemercimentOPEnt(cnt2.Entete_Lettre_Remerciement__c, acc.Name, oppannuel1.amount, acc.billingcity,
        acc.billingcountry, acc.billingstreet, acc.billingpostalcode, cmp.EndDate, cnt2.Maternal_Language_1__c);
        
        list<Contact> listcontact = new list<Contact>();
        listcontact.add(cnt2);

        List<PDFDonateursRemerciementsController.RemercimentOPEnt> listremercimentOPEnt = new list<PDFDonateursRemerciementsController.RemercimentOPEnt>();
        listremercimentOPEnt.add(companyOP);
        controller.getDataOPEnt();

    }

    @isTest 
        public static void testgetDataOP(){
        Campaign cmp = new Campaign (Name = 'TestCampaign', StartDate = Date.parse('01.05.22'), Ordre_permanent__c = true, EndDate = Date.parse('30.05.22'), Extern_key__c = 'TestCampaign12');
        insert cmp;
 
        ApexPages.StandardController sc = new ApexPages.StandardController(cmp);
        PDFDonateursRemerciementsController controller = new PDFDonateursRemerciementsController(sc);

        Contact cnt2 = new Contact (Salutation = 'Madame', Entete_Lettre_Remerciement__c = 'Madame', FirstName = 'Catherine', LastName = 'Fouss', MailingStreet = 'Street2', MailingCity = 'Luxembourg',
        MailingCountry = 'Luxembourg', MailingPostalCode = '789654', Acknowledgement__c = 'Once per opportunity', Maternal_Language_1__c = 'français', Statut_Juridique__c='P');
        insert cnt2;
        
        CampaignMember cm2 = new CampaignMember (CampaignId = cmp.Id, ContactId = cnt2.Id);
        insert cm2;

        Opportunity oppannuel1 = new Opportunity (Name = 'oppannuel1',  StageName = 'Closed Lost', npsp__Primary_Contact__c = cnt2.Id, CampaignId = cmp.Id, Amount = 300, CloseDate = Date.parse('11.05.22'), PDF_cree__c = false);
        insert oppannuel1;
        Opportunity oppannuel2 = new Opportunity (Name = 'oppannuel2',  StageName = 'Closed Lost', npsp__Primary_Contact__c = cnt2.Id, CampaignId = cmp.Id, Amount = 700, CloseDate = Date.parse('18.05.22'), PDF_cree__c = false);
        insert oppannuel2;

        list<CampaignMember> listcm2 = new list<CampaignMember>();
        listcm2.add(cm2);

        PDFDonateursRemerciementsController.RemercimentOP OPrem = new PDFDonateursRemerciementsController.RemercimentOP(cnt2.Salutation, cnt2.Entete_Lettre_Remerciement__c, cnt2.FirstName, cnt2.LastName, oppannuel1.amount, 
        cnt2.MailingStreet, cnt2.MailingCity, cnt2.MailingCountry, cnt2.MailingPostalCode, cnt2.Maternal_Language_1__c, cmp.EndDate);
        
        list<Contact> listcontact = new list<Contact>();
        listcontact.add(cnt2);

        List<PDFDonateursRemerciementsController.RemercimentOP> listremercimentOP = new list<PDFDonateursRemerciementsController.RemercimentOP>();
        listremercimentOP.add(OPrem);
        controller.getDataOP();

    }

   
    @isTest static void testDonateursPDF(){

        Campaign cmp1 = new Campaign (Name = 'TestCampaign1', Extern_key__c = 'testcampaign1254');
        insert cmp1;
        ApexPages.StandardController std = new ApexPages.StandardController(cmp1);
        PDFDonateursRemerciementsController controller = new PDFDonateursRemerciementsController(std);
        PDFDonateursRemerciementsController.DonateursPDF(cmp1.Id);
        PDFDonateursRemerciementsController.DonateursPDF(cmp1.Id);
    }


    @isTest static void testEntreprisesPDF(){
        Campaign cmp2 = new Campaign (Name = 'TestCampaign2', Extern_key__c = 'campaign');
        insert cmp2;
        ApexPages.StandardController std = new ApexPages.StandardController(cmp2);
        PDFDonateursRemerciementsController controller = new PDFDonateursRemerciementsController(std);
        PDFDonateursRemerciementsController.EntreprisesPDF(cmp2.Id);
        PDFDonateursRemerciementsController.EntreprisesPDF(cmp2.Id);
    }

    @isTest static void testAnnuelPDF(){
        Campaign cmp3 = new Campaign (Name = 'TestCampaign3', Extern_key__c = 'campaign852');
        insert cmp3;
        ApexPages.StandardController std = new ApexPages.StandardController(cmp3);
        PDFDonateursRemerciementsController controller = new PDFDonateursRemerciementsController(std);
        PDFDonateursRemerciementsController.AnnuelPDF(cmp3.Id);
        PDFDonateursRemerciementsController.AnnuelPDF(cmp3.Id);
    }

    @isTest static void testEntAnnuelPDF(){

        Campaign cmp4 = new Campaign (Name = 'TestCampaign4', Extern_key__c = 'testcampaign1254589');
        insert cmp4;
        ApexPages.StandardController std = new ApexPages.StandardController(cmp4);
        PDFDonateursRemerciementsController controller = new PDFDonateursRemerciementsController(std);
        PDFDonateursRemerciementsController.EntAnnuelPDF(cmp4.Id);
        PDFDonateursRemerciementsController.EntAnnuelPDF(cmp4.Id);
    }

    @isTest static void testOPDonateursPDF(){

        Campaign cmp5 = new Campaign (Name = 'TestCampaign5', Extern_key__c = 'testcampaign12979498754589');
        insert cmp5;
        ApexPages.StandardController std = new ApexPages.StandardController(cmp5);
        PDFDonateursRemerciementsController controller = new PDFDonateursRemerciementsController(std);
        PDFDonateursRemerciementsController.OPDonateursPDF(cmp5.Id);
        PDFDonateursRemerciementsController.OPDonateursPDF(cmp5.Id);
    }

    @isTest static void testEntOPPDF(){

        Campaign cmp6 = new Campaign (Name = 'TestCampaign6', Extern_key__c = 'testcampaignuyhouhjui1254589');
        insert cmp6;
        ApexPages.StandardController std = new ApexPages.StandardController(cmp6);
        PDFDonateursRemerciementsController controller = new PDFDonateursRemerciementsController(std);
        PDFDonateursRemerciementsController.EntOPPDF(cmp6.Id);
        PDFDonateursRemerciementsController.EntOPPDF(cmp6.Id);
    }
}