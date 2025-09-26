global class BatchUpdateOpportunitiesAfterPDFCreate implements Database.Batchable<sObject>, Database.Stateful, Database.RaisesPlatformEvents{
    global String campId { get; set; }
    global String strkey { get; set; }
    global BatchUpdateOpportunitiesAfterPDFCreate(String campId, String strkey) {
      this.campId = campId;
      this.strkey = strkey;
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
      String query = '';
      set<id> contid = new Set<id>();
        switch on strkey {
            when 'getDataAnnuel' {
              list<CampaignMember> cmem = [SELECT
                                            CampaignId,
                                            ContactId,
                                            contact.Acknowledgement__c,
                                            contact.Statut_Juridique__c
                                          FROM CampaignMember
                                          WHERE
                                            CampaignId = :campId
                                          AND contact.Acknowledgement__c = 'Once a year'
                                          AND contact.Statut_Juridique__c = 'P'
                ];
              for (CampaignMember campaignpmember : cmem) {
                System.debug(campaignpmember.contact.Acknowledgement__c);
                contid.add(campaignpmember.ContactId);
              }
              Campaign campaignannuel = [
                SELECT Id, StartDate, EndDate
                FROM Campaign
                WHERE Id = :campId
              ];
              Date startD;
              Date endD;
              startD = campaignannuel.StartDate;
              endD = campaignannuel.EndDate;
              query = ' SELECT npsp__Primary_Contact__c, PDF_cree__c' + 
                    ' FROM Opportunity' + 
                    ' WHERE npsp__Primary_Contact__c IN :contid AND CloseDate >= :startD AND CloseDate <= :endD AND PDF_cree__c = FALSE'; 
                    system.debug('query' + query);
            }
            when 'getDataAnnualEnt'{
              list<CampaignMember> cmem = [SELECT CampaignId, ContactId, contact.Acknowledgement__c, contact.Statut_Juridique__c
                                          FROM CampaignMember
                                          WHERE CampaignId = :campId
                                          AND contact.Acknowledgement__c = 'Once a year'
                                          AND (contact.Statut_Juridique__c = 'AP' OR contact.Statut_Juridique__c = 'S' OR contact.Statut_Juridique__c = 'ASSOC')
              ];
              for (CampaignMember campaignpmember : cmem) {
                System.debug(campaignpmember.contact.Acknowledgement__c);
                contid.add(campaignpmember.ContactId);
              }
              Campaign campaignannuel = [
                SELECT Id, StartDate, EndDate
                FROM Campaign
                WHERE Id = :campId
              ];
              Date startD;
              Date endD;
              startD = campaignannuel.StartDate;
              endD = campaignannuel.EndDate;
                query = 
                    ' SELECT npsp__Primary_Contact__c, PDF_cree__c' + 
                    ' FROM Opportunity' + 
                    ' WHERE npsp__Primary_Contact__c IN :contid' +
                    ' AND CloseDate >= :startD AND CloseDate <= :endD AND PDF_cree__c = FALSE'; 
                system.debug('query' + query);
            }
            when 'getDataOP'{
              list<CampaignMember> cmem = [SELECT CampaignId, ContactId, contact.Acknowledgement__c, contact.Statut_Juridique__c
                                          FROM CampaignMember
                                          WHERE CampaignId = :campId
                                          AND contact.Acknowledgement__c = 'Once per opportunity'
                                          AND contact.Statut_Juridique__c = 'P'
              ];
              
              for (CampaignMember cmmb : cmem) {
              contid.add(cmmb.ContactId);
              }
              list <opportunity> opps = [SELECT npsp__Primary_Contact__c, PDF_cree__c, CampaignId
              FROM Opportunity
              WHERE npsp__Primary_Contact__c IN :contid AND CampaignId = :campId];
              System.debug('opps' + opps.size());
                query = 
                    ' SELECT npsp__Primary_Contact__c, PDF_cree__c, CampaignId' + 
                    ' FROM Opportunity' + 
                    ' WHERE npsp__Primary_Contact__c IN :contid AND CampaignId = :campId'; 
                system.debug('query' + query);
            }

            when 'getDataOPEnt'{
              list<CampaignMember> cmem = [SELECT CampaignId, ContactId, contact.Acknowledgement__c, contact.Statut_Juridique__c
                                          FROM CampaignMember
                                          WHERE CampaignId = :campId
                                          AND contact.Acknowledgement__c = 'Once per opportunity'
                                          AND (contact.Statut_Juridique__c = 'AP' OR contact.Statut_Juridique__c = 'S' OR contact.Statut_Juridique__c = 'ASSOC')
              ];
              for (CampaignMember campaignmem : cmem) {
              contid.add(campaignmem.ContactId);
              }
                query = 
                    ' SELECT npsp__Primary_Contact__c, PDF_cree__c, CampaignId' + 
                    ' FROM Opportunity' + 
                    ' WHERE npsp__Primary_Contact__c IN :contid AND CampaignId = :campId'; 
                system.debug('query' + query);
            }
         }  
         return Database.getQueryLocator(query);       
          
    }

    global void execute(Database.BatchableContext bc, List<Opportunity> scope) {

        List<npsp__Trigger_Handler__c> npsptriggers = [SELECT npsp__Object__c, npsp__Active__c FROM npsp__Trigger_Handler__c WHERE npsp__Object__c = 'Opportunity'];
        for (npsp__Trigger_Handler__c npsptrigger : npsptriggers){
          npsptrigger.npsp__Active__c = false;
        }
        update npsptriggers;
      
        for (Opportunity opp : scope){
          opp.PDF_cree__c = true;
        }
        update scope;
      
        for (npsp__Trigger_Handler__c npsptrigger : npsptriggers){
          npsptrigger.npsp__Active__c = true;
        }
          update npsptriggers;         
    }

    global void finish(Database.BatchableContext bc) {
    }

}