public with sharing class ctrlAttestation {
    public List<bre__BR_Participation__c> participants {get;set;}

     public ctrlAttestation(ApexPages.StandardController controller){
            Id myParticipationId = controller.getid();
            bre__BR_Participation__c currentParticipationCaregiver = [ select id,name,ProjetCaregivers__c from bre__BR_Participation__c where id =: myParticipationId  ][0];
            FP2__Project__c tripProject = [select id, name from FP2__Project__c where id=: currentParticipationCaregiver.ProjetCaregivers__c][0];
            this.participants = [ select id, name,bre__Contact__r.FirstName,bre__Contact__r.lastName from bre__BR_Participation__c where ProjetParticipants__c =: tripProject.Id ];
     } 
}