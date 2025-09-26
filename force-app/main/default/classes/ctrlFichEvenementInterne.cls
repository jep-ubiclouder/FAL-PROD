public with sharing class ctrlFichEvenementInterne {
  public List<bre__BR_Participation__c> Participants { get; set; }
  public List<bre__BR_Participation__c> Volontaires { get; set; }
  public List<bre__BR_Participation__c> Educateurs { get; set; }
  public ctrlFichEvenementInterne(ApexPages.StandardController controller) {
    Id myParticipationId = controller.getid();
    this.Participants = new List<bre__BR_Participation__c>();
    this.Volontaires = new List<bre__BR_Participation__c>();
    this.Educateurs = new List<bre__BR_Participation__c>();

    this.Participants = [
      SELECT
        id,
        name,
        bre__Contact__r.FirstName,
        bre__Contact__r.lastName,
        bre__Contact__r.Name,
        bre__User__c,
        Room__c,
        bre__Participate__c
      FROM bre__BR_Participation__c
      WHERE ProjetParticipants__c = :myParticipationId
    ];
    this.Volontaires = [
      SELECT
        id,
        name,
        bre__Contact__r.FirstName,
        bre__Contact__r.lastName,
        bre__Contact__r.Name,
        bre__User__c,
        Room__c,
        bre__Participate__c
      FROM bre__BR_Participation__c
      WHERE ProjetVolonteers__c = :myParticipationId
    ];

    this.Educateurs = [
      SELECT
        id,
        name,
        bre__Contact__r.FirstName,
        bre__Contact__r.lastName,
        bre__Contact__r.Name,
        bre__User__c,
        Room__c,
        bre__Participate__c
      FROM bre__BR_Participation__c
      WHERE ProjetCaregivers__c = :myParticipationId
    ];
  }
}