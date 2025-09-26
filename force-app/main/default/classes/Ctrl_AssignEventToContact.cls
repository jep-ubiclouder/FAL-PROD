public without sharing class Ctrl_AssignEventToContact {
  @AuraEnabled
  public static list <string> getimageId(string EvId){
      list<string> resultat = new list<string>();
      String userLanguage = UserInfo.getLanguage();
      system.debug(userLanguage);
      resultat.add(userLanguage);

      string imageId='';
      list<ContentDocumentLink> files =  [SELECT ContentDocument.LatestPublishedVersion.Title, ContentDocument.LatestPublishedVersionId, LinkedEntityId
      FROM ContentDocumentLink
      WHERE LinkedEntityId = :EvId
      ORDER BY ContentDocument.createdDate DESC limit 1];
  
      if(files.size()>0)
      {
          imageId=files[0].ContentDocument.LatestPublishedVersionId;
      }
      resultat.add(imageId);
      
      bre__BR_Event__c trevent = [SELECT Id, TripEventProject__r.Location__c FROM bre__BR_Event__c WHERE Id=:EvId];
      if(trevent.TripEventProject__r.Location__c!=null){
      Location_Master__c lodging = [SELECT Id, Image_name__c FROM Location_Master__c WHERE Id=: trevent.TripEventProject__r.Location__c];
      string photoId=lodging.Image_name__c;
        /*  list<ContentDocumentLink> photos =   [SELECT Id, ContentDocument.Title, ContentDocumentId, LinkedEntityId, ContentDocument.LatestPublishedVersionId
      FROM ContentDocumentLink
      WHERE LinkedEntityId = :lodging.Id AND ContentDocument.Title =:lodging.Image_name__c];
  
      if(photos.size()>0)
      {
        photoId=photos[0].ContentDocument.LatestPublishedVersionId;
      } */
      resultat.add(photoId);
    }
      return resultat;
          
  } 
  
    @AuraEnabled
    public static list<bre__BR_Participation__c> getContactsEventsParticipe(string ContId, string TripEvZId, string TypeofProject) {
         try {
        date todaysDate = date.today(); 
        if (!test.isRunningTest()) {
          User currUser = [
            SELECT id, FlexCompos__contact_de_travail__c
            FROM user
            WHERE id = :UserInfo.getUserId()
          ][0];
            
          currUser.FlexCompos__contact_de_travail__c = ContId;
  
          update currUser;
        }
        List<bre__BR_Participation__c> listContactsEventsYes = [
          SELECT
            bre__BR_Event__c,
            bre__Contact__c,
            bre__BR_Event__r.Name,
            bre__BR_Event__r.Event_Name__c,
            bre__BR_Event__r.Start_Date__c,
            bre__BR_Event__r.HIDDEN_Participant_Category__c,
            Name,
            bre__BR_Event__r.bre__BR_Events_Zone__c,
            bre__BR_Event__r.HIDDEN_EventType_General__c
          FROM bre__BR_Participation__c
          WHERE
            bre__Contact__c = :ContId
            AND bre__Participate__c = 'Yes'
            AND bre__BR_Event__r.HIDDEN_EventType_General__c = :TypeofProject
            AND bre__BR_Event__r.bre__BR_Events_Zone__c = :TripEvZId
          ORDER BY bre__BR_Event__r.Start_Date__c DESC
        ];
  
        return listContactsEventsYes;
             } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    }
  
    @AuraEnabled
    public static list<bre__BR_Participation__c> getContactsEventsMaybePart(
      string ContId,
      string TripEvZId,
      string TypeofProject
    ) {
      date todaysDate = date.today();
      List<bre__BR_Participation__c> listContactsEventsMaybe = [
        SELECT
          bre__BR_Event__c,
          bre__Contact__c,
          bre__BR_Event__r.Name,
          bre__BR_Event__r.Event_Name__c,
          bre__BR_Event__r.Start_Date__c,
          bre__BR_Event__r.HIDDEN_Participant_Category__c,
          Name,
          bre__BR_Event__r.bre__BR_Events_Zone__c,
          bre__BR_Event__r.HIDDEN_EventType_General__c
        FROM bre__BR_Participation__c
        WHERE
          bre__Contact__c = :ContId
          AND bre__Participate__c = 'Maybe'
          AND bre__BR_Event__r.Start_Date__c > :todaysDate
          AND bre__BR_Event__r.bre__BR_Events_Zone__c = :TripEvZId
          AND bre__BR_Event__r.HIDDEN_EventType_General__c = :TypeofProject
        ORDER BY bre__BR_Event__r.Start_Date__c ASC
      ];
  
      return listContactsEventsMaybe;
    }
  
    @AuraEnabled
    public static list<bre__BR_Event__c> getContactsEventsNotPart(
      string ContId,
      string TripEvZId,
      string TypeofProject
    ) {
      date todaysDate = date.today();
      List<bre__BR_Participation__c> tripparticipelistno = [
        SELECT bre__BR_Event__c, bre__Contact__c,bre__BR_Event__r.HIDDEN_EventType_General__c,bre__BR_Event__r.HIDDEN_Participant_Category__c
        FROM bre__BR_Participation__c
        WHERE
          bre__Contact__c = :ContId
          AND bre__BR_Event__r.HIDDEN_EventType_General__c =:TypeofProject
          AND (bre__Participate__c = 'Yes'
          OR bre__Participate__c = 'Maybe')
      ];
      set<id> tripeventId = new Set<id>();
  
      for (bre__BR_Participation__c TripEv : tripparticipelistno) {
        tripeventId.add(TripEv.bre__BR_Event__c);
      }
  
      List<bre__BR_Event__c> listContactsEventsNo = [
        SELECT Id, Name, Event_Name__c, bre__BR_Events_Zone__c,Start_Date__c,HIDDEN_EventType_General__c,HIDDEN_Participant_Category__c
        FROM bre__BR_Event__c
        WHERE
          bre__BR_Events_Zone__c = :TripEvZId
          AND Start_Date__c > :todaysDate
          AND HIDDEN_EventType_General__c= :TypeofProject
          AND   bre__Draft__c = false
          AND Id NOT IN :tripeventId
        ORDER BY Start_Date__c ASC
      ];
      return listContactsEventsNo;
    }
  
    @AuraEnabled
    public static string CreateParticipation(string ContId, string EvId) {
      List<bre__BR_Participation__c> tripparticipe = new List<bre__BR_Participation__c>();
      tripparticipe = [
        SELECT Id, bre__BR_Event__c, bre__Contact__c, bre__Participate__c
        FROM bre__BR_Participation__c
        WHERE
          bre__Contact__c = :ContId
          AND bre__BR_Event__c = :EvId
          AND bre__Participate__c = 'No'
      ];
  
      if (tripparticipe.size() == 0) {
        bre__BR_Participation__c np = new bre__BR_Participation__c();
        np.bre__BR_Event__c = EvId;
        np.bre__Contact__c = ContId;
        np.bre__Participate__c = 'Maybe';
        insert np;
        return np.id;
      } else {
        tripparticipe[0].bre__Participate__c = 'Maybe';
        update tripparticipe[0];
        return tripparticipe[0].Id;
      }
    }
  
    @AuraEnabled
    public static string UpdateParticipation(
      string ContId,
      string EvId,
      string PartId
    ) {
      List<bre__BR_Participation__c> tripparticipe = new List<bre__BR_Participation__c>();
      tripparticipe = [
        SELECT Id, bre__BR_Event__c, bre__Contact__c, bre__Participate__c
        FROM bre__BR_Participation__c
        WHERE bre__Contact__c = :ContId AND Id = :PartId
      ];
      tripparticipe[0].bre__Participate__c = 'No';
      update tripparticipe[0];
      return tripparticipe[0].Id;
    }

    @AuraEnabled
    public static list<bre__BR_Event__c> eventdescr (string EvId){
      List<bre__BR_Event__c> listeventdescr = [
        SELECT Id, Name, Event_Name__c,Start_Date__c, End_Date__c, Start_Time__c, End_Time__c,
        bre__Venue_Address__c, TripEventProject__r.Educateur1__r.FirstName,TripEventProject__r.Educateur1__r.LastName,TripEventProject__r.Educateur2__r.LastName, TripEventProject__r.Educateur2__r.FirstName, TripEventProject__r.Mobile_phones_Loisirs__c,
        Place_of_the_Event__c, TripEventProject__r.Location__r.Zip_Code__c, TripEventProject__r.Location__r.City__c, TripEventProject__r.Location__r.Country__c, TripEventProject__r.Location__r.Street__c, 
        TripEventProject__r.Location__r.Website_URL__c,TripEventProject__r.Location__r.LocationName__c,
        TripEventProject__r.Description_in_luxembourgish__c, TripEventProject__r.Description_in_french__c, TripEventProject__r.Description_in_english__c, TripEventProject__r.Description_in_german__c,
        TripEventProject__r.Deroulement_in_luxemburgish__c, TripEventProject__r.Deroulement_in_french__c, TripEventProject__r.Deroulement_in_english__c, TripEventProject__r.Deroulement_in_german__c,
        Meeting_volunteers_place__r.Street__c, Meeting_volunteers_place__r.Zip_Code__c, Meeting_volunteers_place__r.City__c, Meeting_volunteers_place__r.Country__c,
        Meeting_volunteers_place__r.LocationName__c, TripEventProject__r.End_Date__c,TripEventProject__r.Start_date__c, Event_start_place__r.Name,
        Event_start_place__r.Street__c, Event_start_place__r.Zip_Code__c, Event_start_place__r.City__c, Event_start_place__r.Country__c, TripEventProject__r.GPS__c,
        TripEventProject__r.Laptop__c, TripEventProject__r.Debit_cards__c, TripEventProject__r.Debit_card_Co_leader__c, TripEventProject__r.FP2__Budget__c, TripEventProject__r.Minibus__c,
        Event_start_place__r.LocationName__c,  TripEventProject__r.Budget_per_card__c, Financial_info_for_participants_FR__c, 
        Financial_info_for_participants_EN__c, Financial_info_for_participants_DE__c, Financial_info_for_participants_LU__c, Role_of_volunteers_FR__c,Role_of_volunteers_DE__c,
        Role_of_volunteers_EN__c, Role_of_volunteers_LU__c, TripEventProject__r.Project_Type__c,Additional_cost_Event__c,HIDDEN_EventType_General__c,Price__c,
        TripEventProject__r.Provider__r.Name,TripEventProject__r.Formateur_1__r.Full_Name__c,TripEventProject__r.Formateur_2__r.Full_Name__c,HIDDEN_Participant_Category__c,Meeting_volunteers_Date__c
        FROM bre__BR_Event__c
        WHERE Id =: EvId];
      return listeventdescr;
    }
  }