global with sharing class BatchUpdateCampaignMembersAfterPDF implements Database.Batchable<sObject>, Database.Stateful, Database.RaisesPlatformEvents{
    global String campId { get; set; }
    global String strkey { get; set; }
    global BatchUpdateCampaignMembersAfterPDF(String campId, String strkey) {
        this.campId = campId;
        this.strkey = strkey;
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = '';
        switch on strkey {
            when 'getDataAnnuel' {
                query = 
                    'SELECT CampaignId, ContactId, contact.Acnowledgement__c, contact.Statut_Juridique__c, Date_PDF__c ' + 
                    'FROM CampaignMember ' + 
                    'WHERE CampaignId = :campId AND contact.Acnowledgement__c = \'Once a year\'  AND contact.Statut_Juridique__c = \'P\' '; 
            }
            when 'getDataAnnualEnt'{
                query = 
                    'SELECT CampaignId, ContactId, contact.Acnowledgement__c, contact.Statut_Juridique__c, Date_PDF__c ' + 
                    'FROM CampaignMember ' + 
                    'WHERE CampaignId = :campId ' +
                    'AND contact.Acnowledgement__c = \'Once a year\' '  + 
                    'AND (contact.Statut_Juridique__c = \'AP\' ' +
                    'OR contact.Statut_Juridique__c = \'S\' ' +
                    'OR contact.Statut_Juridique__c = \'ASSOC\') '; 
                    system.debug('query' + query);
            }
            when 'getDataOP'{
                query = 
                    'SELECT CampaignId, ContactId, contact.Acnowledgement__c, contact.Statut_Juridique__c, Date_PDF__c ' + 
                    'FROM CampaignMember ' + 
                    'WHERE CampaignId = :campId AND contact.Acnowledgement__c = \'Once per opportunity\'  AND contact.Statut_Juridique__c = \'P\' '; 
            }
            when 'getDataOPEnt'{
                query = 
                    'SELECT CampaignId, ContactId, contact.Acnowledgement__c, contact.Statut_Juridique__c, Date_PDF__c ' + 
                    'FROM CampaignMember ' + 
                    'WHERE CampaignId = :campId AND contact.Acnowledgement__c = \'Once per opportunity\' '  + 
                    'AND (contact.Statut_Juridique__c = \'AP\' OR contact.Statut_Juridique__c = \'S\' OR contact.Statut_Juridique__c = \'ASSOC\') '; 
            }
         }  
         return Database.getQueryLocator(query);       
    }

    global void execute(Database.BatchableContext bc, List<CampaignMember> scope) {
     
        for (CampaignMember cm : scope){
            cm.Date_PDF__c = System.today();
        }
        update scope;
           
    }

    global void finish(Database.BatchableContext bc) {
    }

}