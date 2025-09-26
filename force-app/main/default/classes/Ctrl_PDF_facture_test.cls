@isTest
private class Ctrl_PDF_facture_test {
    @isTest static void testgetData(){
    
        Contact cnt1 = new Contact (Salutation = 'Madame', FirstName = 'Marina', LastName = 'Tutaeva', MailingStreet = 'Street1', MailingCity = 'Arlon',
        MailingCountry = 'Belgique', MailingPostalCode = '12365', Acknowledgement__c = 'Once per opportunity', Maternal_Language_1__c = 'français');
        insert cnt1;

        Account acc = new Account (Name = 'Acme', billingstreet = 'billingstreet', billingcity = 'billingcity', billingcountry = 'billingcountry', billingpostalcode = '78965', npe01__One2OneContact__c = cnt1.Id, RecordTypeId='0125I000000jpZYQAY');
        insert acc;
        
        Account acc2 = new Account (Name = 'Team', Abbreviation__c='TEA',billingstreet = 'billingstreet', billingcity = 'billingcity', billingcountry = 'billingcountry', billingpostalcode = '78965', npe01__One2OneContact__c = cnt1.Id, RecordTypeId='012AM0000004L1iYAE');
        insert acc2;

        bre__BR_Events_Zone__c pzone = new bre__BR_Events_Zone__c (Name = 'Foyer1', Category_of_Event__c = 'Séjours',Abbreviation__c='F01');
        insert pzone;

        bre__BR_Events_Zone__c czone = new bre__BR_Events_Zone__c (Name = 'Caregiver', Category_of_Event__c = 'Séjours',Abbreviation__c='F02');
        insert czone;
        
        Location_Master__c local = new Location_Master__c( LocationName__c = 'AC Restaurant & Hotel Arlon***', Name = 'Arlon');
        insert local;

        FP2__Project__c proj = new FP2__Project__c (Name = 'Project',Project_Name__c = 'Event', Event__c = True, Project_Category__c='Leisure Event',Project_Type__c='SEJ', FAL_Team__c=acc2.Id,Location__c = local.Id, Start_Date__c = Date.newInstance(2024, 5, 11),
        End_Date__c = Date.newInstance(2022, 12, 31), Article_reference__c = 'COL1', Article_designation__c = 'Participation Séjour Loisirs',  Domain__c = 'ADM', Subdomain__c = 'ASD' );
        insert proj;

        bre__BR_Event__c event = new bre__BR_Event__c (Name = 'Event1', TripEventProject__c = proj.Id,
        Eventtype__c = 'Participants',bre__BR_Events_Zone__c=pzone.Id);
        insert event;

        bre__BR_Participation__c particip = new bre__BR_Participation__c (bre__Contact__c = cnt1.Id, bre__BR_Event__c = event.Id);
        insert particip;

        Product2 prod = new Product2(Name = 'Participation', IsActive = true);
        insert prod;

        EUcom__Country__c country = new EUcom__Country__c(Name = 'Luxembourg', EUcom__Code__c = 'LU', EUcom__Area__c = 'Other');
        insert country;
        
        EUcom__Contract__c contrat = new EUcom__Contract__c ( EUcom__Contact__c = cnt1.Id, AC_Participation__c = particip.Id, EUcom__Actual_Index__c = 100, EUcom__Billing_Account__c = acc.Id,
                                                              EUcom__Billing_Start_Date__c = Date.newInstance(2022, 5, 11), EUcom__Billing_method__c = 'Created date',
                                                              EUcom__Business_Type__c = 'Services', EUcom__Company_Name__c = 'FAL', EUcom__Company__c = 'FAL',
                                                              EUcom__Contract_End_Date__c = Date.newInstance(2022, 12, 31),
                                                              EUcom__Contract_PDF__c = 'Contract_PDF', EUcom__Contract_Start_Date__c = Date.newInstance(2022, 5, 11),
                                                              EUcom__Contract_Type__c = 'Standard', EUcom__Customer_VAT__c = '90 No VAT',
                                                              EUcom__Delivered__c = true, EUcom__Last_invoice_date__c = Date.newInstance(2022, 5, 11),
                                                              EUcom__Next_Bill_Cycle__c = '202211', EUcom__Next_date_of_invoice__c = Date.newInstance(2022, 5, 11),
                                                              EUcom__Price_index__c = 100, EUcom__Status_for_invoicing__c = 'To invoice', 
                                                              EUcom__VAT_Country__c = country.Id, EUcom__VAT_Rate__c = 0, EUcom__Account__c = acc.Id
                                                              );
        insert contrat;
       
        EUcom__Contract_Line__c cline = new EUcom__Contract_Line__c(EUcom__Contract__c = contrat.Id, EUcom__Costs__c = 0,
                                                                    EUcom__Delivered__c = true, EUcom__Plug_Field_Rich_Text__c = 'Participation loisirs',
                                                                    EUcom__End_Date__c = Date.newInstance(2022, 12, 31), EUcom__ListPrice__c = 450,
                                                                    EUcom__Product__c = prod.Id, EUcom__Quantity__c = 1, EUcom__Quantity_delivered__c = 1,
                                                                    EUcom__Quantity_invoiced__c = 1, EUcom__Start_Date__c = Date.newInstance(2022, 5, 11), 
                                                                    EUcom__UnitPrice__c = 450);
        insert cline;

        EUcom__Invoice__c inv = new EUcom__Invoice__c(Name = 'Invoice', EUcom__Contract__c = contrat.Id, EUcom__Account__c = acc2.Id,RecordTypeId='0127T000000CgMLQA0');
        insert inv;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(inv);
        Ctrl_PDF_facture myController = new Ctrl_PDF_facture(sc);
            
        Ctrl_PDF_facture.InvoiceInfo facture = new Ctrl_PDF_facture.InvoiceInfo(cnt1.Salutation, cnt1.FirstName, cnt1.LastName, cnt1.MailingStreet, 
                                                                            cnt1.MailingCity, cnt1.MailingCountry, cnt1.MailingPostalCode, 
                                                                            Date.newInstance(2022, 11, 28), inv.Name, cnt1.FirstName, cnt1.LastName,
                                                                            inv.EUcom__Total_incl_VAT__c, proj.Code_Projet__c, '1121 HEB MUN - ASP', proj.Code_Sejour__c);    
             
        Ctrl_PDF_facture.ContractLineInfo facture2 = new Ctrl_PDF_facture.ContractLineInfo(proj.Article_reference__c, proj.Article_designation__c, cline.EUcom__Plug_Field_Rich_Text__c, cline.EUcom__Start_Date__c, cline.EUcom__End_Date__c,
                                                                            inv.EUcom__Total_incl_VAT__c);   

                                                    
        Test.startTest();
        myController.getData();
        Test.stopTest();                                                     
    }
}