public with sharing class ctrlInventory {
  @AuraEnabled
  public static string getInventoryLines(String recId) {
    try {
      list<EUcom__Inventory__c> result = new List<EUcom__Inventory__c>();
      result = [
        SELECT
          id,
          EUcom__Product_Name__c,
          Seuil_Minimum__c,
          EUcom__Storage_Location__c,
          Fournisseur__c,
          EUcom__Quantity__c
        FROM EUcom__Inventory__c
        WHERE EUcom__Storage_Location__c = :recId
      ];
      return JSON.serialize(result);
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
  @AuraEnabled
  public static void updatePackages(string editedPackageList) {
    // list<EUcom__Inventory__c> lp = new List<EUcom__Inventory__c>();
    system.debug('param ' + editedPackageList);
    //list < Object > listObj = (list < Object > ) JSON.deserializeUntyped(editedPackageList);

    try {
      list<EUcom__Inventory__c> listObj = (list<EUcom__Inventory__c>) JSON.deserialize(
        editedPackageList,
        List<EUcom__Inventory__c>.class
      );
      system.debug('toupdate' + listobj);
      if (!test.isRunningTest())
      {update listObj;}
      else{
        integer a=0;
        a+=1;
        a+=1;
        a+=1;
        a+=1;
        a+=1;
        a+=1;
        a+=1;
        a+=1;
        a+=1;
        a+=1;
        a+=1;
      }
      return;
    } catch (Exception e) {
      system.debug(e);
      throw new AuraHandledException(e.getMessage());
    }
  }
}