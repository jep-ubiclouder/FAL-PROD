@isTest(seeAllData=true)
public with sharing class ctrlInventory_test {
  public static testMethod void TestPDFController() {
    test.startTest();

    EUcom__Storage_Location__c location = new EUcom__Storage_Location__c ();
    insert location;
    EUcom__Inventory__c inv = new EUcom__Inventory__c(EUcom__Storage_Location__c=location.id);
    insert inv ;
   ctrlInventory.getInventoryLines(location.id);
   string pesudoJSON =   '[{"EUcom__Quantity__c":"12","Id":"a1v5t000000944mAAA"},{"EUcom__Quantity__c":"23","Id":"a1v5t00000097sPAAQ"}]';

ctrlInventory.updatePackages(pesudoJSON);
  }
}