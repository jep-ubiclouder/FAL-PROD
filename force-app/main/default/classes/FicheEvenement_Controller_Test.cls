@isTest(seeAllData = True)
public with sharing class FicheEvenement_Controller_Test {

    public static testMethod void TestPDFController() {
  
        FP2__Project__c Test= new FP2__Project__c (Name='Test');
        insert Test;
        FicheEvenement_Controller.ActionCreatePDF(Test.id);


}
}