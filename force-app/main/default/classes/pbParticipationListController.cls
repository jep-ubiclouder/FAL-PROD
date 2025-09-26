public class pbParticipationListController {
    @AuraEnabled 
    public List<Id> projectIds {get;set;}
    @AuraEnabled
    public List<Id> participationIds {get;set;}
    @AuraEnabled
    public static wrapper method(List<Id> projectIds){
   //get records from database and store in list Step 2
       List<bre__BR_Participation__c>getParticipants = [SELECT Id, Name,
        OrderingNumber__c, Visibility_Check__c,Age__c,bre__Contact__c,bre__Contact__r.Name,bre__Participate__c,
        Registered_status__c,Reason_for_cancellation_confirmation__c,Create_contract__c,CreatedDate,ApprovedDate__c,
        ProjetParticipants__c,Training_completed__c FROM bre__BR_Participation__c WHERE ProjetParticipants__c in :projectIds ORDER BY OrderingNumber__c ASC,CreatedDate ASC,Registered_status__c ASC];
        List<bre__BR_Participation__c> getPersonnel = [SELECT Id, Name,OrderingNumber__c,Visibility_Check__c,Age__c,bre__Contact__c,bre__Contact__r.Name,bre__Participate__c,
        Registered_status__c,Reason_for_cancellation_confirmation__c,CreatedDate,ApprovedDate__c,ProjetCaregivers__c, Training_completed__c FROM bre__BR_Participation__c 
        WHERE ProjetCaregivers__c in :projectIds ORDER BY OrderingNumber__c ASC,CreatedDate ASC,Registered_status__c ASC];
        List<bre__BR_Participation__c> getVolunteers = [SELECT Id, Name,OrderingNumber__c,Visibility_Check__c,Age__c,bre__Contact__c,bre__Contact__r.Name,bre__Participate__c,
         Registered_status__c,Reason_for_cancellation_confirmation__c,CreatedDate,ApprovedDate__c,ProjetVolonteers__c,Training_completed__c FROM bre__BR_Participation__c WHERE ProjetVolonteers__c in :projectIds ORDER BY OrderingNumber__c ASC,CreatedDate ASC,Registered_status__c ASC];
        List<FP2__Project__c> getProject = [SELECT Id,Name,FP2__ProgressBar__c,ParticipantsEvent__c,CaregiversEvent__c,VolonteersEvent__c,ParticipantsInscriptions__c,CaregiversInscriptions__c,VolonteersInscriptions__c,ParticipantsLight__c,Project_Category__c,HIDDEN_Audience_Participants__c,HIDDEN_Audience_Staff__c,HIDDEN_Audience_Volunteers__c,StaffLight__c,Volunteers_Light__c,Total_Light__c
        FROM FP2__Project__c WHERE Id in :projectIds LIMIT 1];
      
        
      //Create wrapper class instance and add list as a input              parameters  Step 3
        wrapper wrp = new wrapper();
        wrp.participantList = new List<bre__BR_Participation__c>(getParticipants);
        wrp.personnelList = new List<bre__BR_Participation__c>(getPersonnel);
        wrp.volunteerList = new List<bre__BR_Participation__c>(getVolunteers);
        wrp.projectRecord = getProject[0];
        return wrp;
    }
//Wrapper Class Step 1
    public class wrapper{
        @AuraEnabled public List<bre__BR_Participation__c> participantList;
        @AuraEnabled public List<bre__BR_Participation__c> personnelList;
        @AuraEnabled public List<bre__BR_Participation__c> volunteerList;
        @AuraEnabled public FP2__Project__c projectRecord {get;set;}
    }
    
    
    

      

    }