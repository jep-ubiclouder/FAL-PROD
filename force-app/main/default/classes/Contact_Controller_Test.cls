@isTest(seeAllData = True)
public with sharing class Contact_Controller_Test {

    public static testMethod void TestPDFController() {
  
        Contact Test= new Contact (LastName='Test', Maternal_Language_1__c='Français');
        insert Test;
     
      /*  PageReference pageRef = Page.QuoteC2i;
        // get quote to test id from Custom setting
       // Quote_Params__c params =  [ select Test_Quote_Id__c from Quote_Params__c][0];
        //Sets.setCurrentPage(pageRef)
      //  String QuoteId = params.Test_Quote_Id__c;
        pageRef.getParameters().put('id',QuoteId);
        Quote QuoteToTest =  [select id from Quote where id=:QuoteId];
        test.setCurrentPageReference(pageRef);
        ApexPages.StandardController stdCtrlMap = new ApexPages.StandardController(QuoteToTest);
        Ctrl_BMCQuote res =  new Ctrl_BMCQuote(stdCtrlMap);
       List<String> testString =   Ctrl_BMCQuote.buildInclusionHSFromText('abacdefg');*/
        Contact_Controller.ActionCreatePDF(Test.id);
        Contact_Controller.ActionCreateEngagementPDF(Test.id);
     
    }   
}