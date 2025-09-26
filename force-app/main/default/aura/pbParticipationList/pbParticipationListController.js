({
    doInit : function(component, event, helper) {
    
 		var projectId = component.get("v.recordId");
        var action = component.get("c.method");

        action.setParams({
            projectIds: projectId
          });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS")
            {
     var response = response.getReturnValue();
          
     	component.set("v.participantList", response.participantList); 
    	component.set("v.personnelList", response.personnelList); 
        component.set("v.volunteerList", response.volunteerList); 
        component.set("v.projectRecord", response.projectRecord)
      
            }
            else if(state === "INCOMPLETE")
            {
            
            }
            else if(state === "ERROR")
            {
             var error = response.getError();
             if(error)
             {
                 console.log("error"+errors);
             }
            }
        });
          $A.enqueueAction(action);


                
        
 },

    // Function used to create a new Participant
    newParticipant: function(component, event, helper) {
        // Global event force:createRecord is used
        var createParticipant = $A.get("e.force:createRecord");
        // Parameters like apiName and defaultValues are set
        createParticipant.setParams({
            "entityApiName": "bre__BR_Participation__c",
            "defaultFieldValues": {
                "ProjetParticipants__c": component.get("v.recordId"),
                "Trip_Event_Project__c": component.get("v.recordId"),
                "bre__BR_Event__c": component.get("v.projectRecord.ParticipantsEvent__c")
            }
        });
        // Event fired and new contact dialog open
        createParticipant.fire();
    },
    
    // Function used to create a new Personnel
    newPersonnel: function(component, event, helper) {
        // Global event force:createRecord is used
        var createPersonnel = $A.get("e.force:createRecord");
        // Parameters like apiName and defaultValues are set
        createPersonnel.setParams({
            "entityApiName": "bre__BR_Participation__c",
            "defaultFieldValues": {
                "ProjetCaregivers__c": component.get("v.recordId"),
                "Trip_Event_Project__c": component.get("v.recordId"),
                "bre__BR_Event__c": component.get("v.projectRecord.CaregiversEvent__c")
            }
        });
        // Event fired and new contact dialog open
        createPersonnel.fire();
    },
    
    // Function used to create a new Volunteer
    newVolunteer: function(component, event, helper) {
        // Global event force:createRecord is used
        var createVolunteer = $A.get("e.force:createRecord");
        // Parameters like apiName and defaultValues are set
        createVolunteer.setParams({
            "entityApiName": "bre__BR_Participation__c",
            "defaultFieldValues": {
                "ProjetVolonteers__c": component.get("v.recordId"),
                "Trip_Event_Project__c": component.get("v.recordId"),
                "bre__BR_Event__c": component.get("v.projectRecord.VolonteersEvent__c")
            }
        });
        // Event fired and new contact dialog open
        createVolunteer.fire();
    },

     
    handleOpenModal: function(component, event, helper) {
        var participationId = event.getSource().get("v.value");
        component.set("v.participationId",participationId);
        component.set("v.isModalOpen", true);
 },
        

     
    closeModel: function(component, event, helper) {
            component.set("v.isModalOpen", false);
           
        
    },

    handleSuccess : function(component, event, helper) {
        component.set("v.isModalOpen", false);
        var action = component.get("c.doInit");
        $A.enqueueAction(action);
    }
        
    
    
    
 
    
    
})