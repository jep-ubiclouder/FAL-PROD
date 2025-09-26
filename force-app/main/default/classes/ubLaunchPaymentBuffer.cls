global without sharing class ubLaunchPaymentBuffer {

  global static void launch() {
    list<EUcom__Payment_Buffer__c> buffs = [
      SELECT
        Id,
        EUcom__Most_likely_Contact__c,
        EUcom__Person_tags__c,
        EUcom__Most_likely_Campaign__c,
        EUcom__Person_IdentityTags__c,
        EUcom__Campaign_Tags__c
      FROM EUcom__Payment_Buffer__c
      WHERE
        (EUcom__Most_likely_Contact__c = NULL
        OR EUcom__Most_likely_Campaign__c = NULL)
        AND EUcom__Person_IdentityTags__c != NULL
        AND EUcom__Campaign_Tags__c != NULL
    ];
    for (EUcom__Payment_Buffer__c pbuff : buffs) {
      pbuff.EUcom__Person_tags__c = pbuff.EUcom__Person_IdentityTags__c;
    }
    if (!test.isrunningtest()) {
      update buffs;
    }

    EUCOM.BatchPaymentAttachContacts myB = new EUCOM.BatchPaymentAttachContacts(
      false
    );
    if (!test.isrunningtest()) {
      Id myBId = Database.executeBatch(myB, 1);
    }
  }
}