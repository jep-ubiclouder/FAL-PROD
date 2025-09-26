@isTest(seeAllData = True)
public with sharing class FicheInterneEvenement_Test {

    public static testMethod void TestPDFController() {
  
        FP2__Project__c Test= new FP2__Project__c (Name='Test');
        insert Test;
        FicheInterneEvenement_Controller.ActionCreatePDF(Test.id);


}
}