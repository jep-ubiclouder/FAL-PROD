global with sharing  class Ctrl_PDF_facture {
    global string                         recId        {get;set;}
    global ApexPages.StandardController   MyController  {get;set;}
    global list <ContractLineInfo>       listfacture  {get;set;}
    global InvoiceInfo facture {get;set;}

    public Ctrl_PDF_facture(ApexPages.StandardController stdController) {
        MyController = stdController;
        recId = stdController.getid(); 
        //getData();
    }

    global class InvoiceInfo{
        global string Salutation {get;set;}
        global string FirstName  {get;set;}
        global string LastName{get;set;}
        global string MailingStreet {get;set;}
        global string MailingCity {get;set;}
        global string MailingCountry {get;set;}
        global string MailingCode {get;set;}
        global date invoiceDate {get;set;}
        global string invoicenumber {get;set;}
        global string ChildFirstName  {get;set;}
        global string ChildLastName{get;set;}
        global decimal AmountTotal {get;set;}
        global string CodeProjet {get;set;}
        global string CodeService {get;set;}
        global string CodeSejour {get;set;}

        public InvoiceInfo (string salut, string FirstN, string LastN, string MailingStr,
        string MailingCity, string MailingCountry, string MailingCode, date invoiceDate, string invoicenumber,
        string chfname, string chlname, decimal AmountTotal, String CodeProjet, string CodeService, string CodeSejour){
            this.Salutation = salut;
            this.FirstName = FirstN;
            this.LastName = LastN;
            this.MailingStreet = MailingStr;
            this.MailingCity = MailingCity;
            this.MailingCountry = MailingCountry;
            this.MailingCode = MailingCode;
            this.invoiceDate = invoiceDate; //date creation
            this.invoicenumber = invoicenumber; //Name invoice
            this.ChildFirstName = chfname;
            this.ChildLastName = chlname;
            this.AmountTotal = AmountTotal;
            this.CodeProjet = Codeprojet;
            this.CodeService = CodeService;
            this.CodeSejour = CodeSejour;
            
        }
    }
    global class ContractLineInfo {
        global string refer {get;set;}
        global string designation {get; set;}
        global string Description  {get;set;}
        global datetime SDate {get;set;}
        global datetime EDate {get;set;}
        global decimal Amount {get;set;}
        


        public ContractLineInfo (string refer, string designation, string descr, datetime SDate, datetime EDate, decimal Amount){
            this.refer = refer;
            this.designation = designation;
            this.Description = descr;
            this.SDate = SDate;
            this.EDate = EDate;
            this.Amount = Amount;
        }
    }

    public void getData() {

        EUcom__Invoice__c inv = [SELECT Id, EUcom__Contract__c, Name, EUcom__Total_incl_VAT__c, Code_Projet__c, Code_Service__c, Code_Sejour__c
                                 FROM EUcom__Invoice__c 
                                 WHERE Id=:recId];

        EUcom__Contract__c contrat = [SELECT Id, EUcom__Contact__r.salutation, EUcom__Contact__r.FirstName, EUcom__Contact__r.LastName,
                                                   EUcom__Contact__r.MailingStreet, EUcom__Contact__r.MailingCity, EUcom__Contact__r.MailingCountry,
                                                   EUcom__Contact__r.MailingPostalCode, AC_Participation__r.bre__Contact__r.FirstName, 
                                                   AC_Participation__r.bre__Contact__r.LastName, AC_Participation__r.bre__BR_Event__r.Start_Date__c,
                                                   AC_Participation__r.bre__BR_Event__r.End_Date__c, EUcom__Account__c, 
                                                   AC_Participation__r.bre__BR_Event__r.TripEventProject__r.Article_reference__c,
                                                   AC_Participation__r.bre__BR_Event__r.TripEventProject__r.Article_designation__c
                                            FROM EUcom__Contract__c
                                            WHERE Id =: inv.EUcom__Contract__c
                                            LIMIT 1];

        List <EUcom__Contract_Line__c> contlines = [SELECT Id, EUcom__Contract__c, EUcom__Plug_Field_Rich_Text__c, EUcom__UnitPrice__c 
                                                   FROM EUcom__Contract_Line__c 
                                                   WHERE EUcom__Contract__c =: contrat.Id];

        InvoiceInfo facture = new InvoiceInfo(contrat.EUcom__Contact__r.salutation, 
                                    contrat.EUcom__Contact__r.FirstName, 
                                    contrat.EUcom__Contact__r.LastName, 
                                    contrat.EUcom__Contact__r.MailingStreet,
                                    contrat.EUcom__Contact__r.MailingCity,
                                    contrat.EUcom__Contact__r.MailingCountry,
                                    contrat.EUcom__Contact__r.MailingPostalCode,
                                    System.today(),
                                    inv.Name,
                                    contrat.AC_Participation__r.bre__Contact__r.FirstName,
                                    contrat.AC_Participation__r.bre__Contact__r.LastName,
                                    inv.EUcom__Total_incl_VAT__c,
                                    inv.Code_Projet__c,
                                    inv.Code_Service__c,
                                    inv.Code_Sejour__c); 
                                                   
                                                  
        this.facture = facture;
        list <ContractLineInfo> listfacturedraft= new list <ContractLineInfo>();
        for(EUcom__Contract_Line__c contractLine:contlines){
            ContractLineInfo infoline = new ContractLineInfo(
                                    contrat.AC_Participation__r.bre__BR_Event__r.TripEventProject__r.Article_reference__c,
                                    contrat.AC_Participation__r.bre__BR_Event__r.TripEventProject__r.Article_designation__c,
                                    contractLine.EUcom__Plug_Field_Rich_Text__c,
                                    contrat.AC_Participation__r.bre__BR_Event__r.Start_Date__c,
                                    contrat.AC_Participation__r.bre__BR_Event__r.End_Date__c,
                                    contractLine.EUcom__UnitPrice__c);
            listfacturedraft.add(infoline);
        }
        this.listfacture = listfacturedraft;
    }
}