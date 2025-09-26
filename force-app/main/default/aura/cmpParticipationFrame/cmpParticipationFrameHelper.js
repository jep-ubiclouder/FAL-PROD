({
    handleClick : function (component, event, helper) {
        let record = component.get("v.participation");
        var contact = component.get("v.contactId");
        console.log('+++ ', component.get("v.recordId"));
        console.log('+++ ', contact);
        if(!contact){
            console.log('+++ return');
            return;
        }
        var action = component.get("c.UpdateParticipation");
        action.setParams({
            EvId: record.bre__BR_Event__c,
            PartId: component.get("v.recordId"),
            ContId: contact 
        });

        action.setCallback(this, function (response) {
            var state = response.getState();
            console.log(state);
            if (state === "SUCCESS") {
                console.log('++++++');
                var appEvent = $A.get("e.c:EventForAssignToContact");
                //appEvent.setParams({"message" : "Hello"});
                console.log(appEvent);

                try {
                    appEvent.fire();
                    console.log('Fire');
                } catch (error) {
                    console.log('error', error);
                }
              //  appEvent.fire();
              //   console.log('Fire');
            } else if (state === 'ERROR') {
                let errors = response.getError(); let message = 'Unknown error'; // Default error message // Retrieve the error message sent by the server 
                if (errors && Array.isArray(errors) && errors.length > 0) {     
                    message = errors[0].message; } // Display the message 
                    console.error(message);
            }
        });
        $A.enqueueAction(action);
    }
});