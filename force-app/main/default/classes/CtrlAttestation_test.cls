@isTest(seeAllData=true)
public with sharing class CtrlAttestation_test {
  public static testMethod void TestPDFController() {
    test.startTest();
    // String myId = 'a0t5I000002KZQ3QAO';
    // PageReference pageRef = Page.Attestation_Caregiver;
    // pageref.getParameters().put('id', myId);
    // test.setCurrentPageReference(pageRef);
    // bre__BR_Participation__c rec = [select id from bre__BR_Participation__c where id=:myid LIMIT 1];
    // ApexPages.StandardController stdCtrlMap = new ApexPages.StandardController(
    //  rec
    // );
    // ctrlAttestation testCtrl = new ctrlAttestation(stdCtrlMap);

    string  myId = 'a155I000000fi5mQAA';
   PageReference pageRef = Page.Fiche_Interne_Evenement;  // force-app\main\default\pages\Fiche_Interne_Evenement.page
    pageref.getParameters().put('id', myId);
    test.setCurrentPageReference(pageRef);
    FP2__Project__c recProj = [select id from FP2__Project__c where id=:myid];
    ApexPages.StandardController  stdCtrlMap1= new ApexPages.StandardController(
     recProj
    );
     ctrlFichEvenementInterne testCtrl2 = new ctrlFichEvenementInterne(stdCtrlMap1);
  }
}