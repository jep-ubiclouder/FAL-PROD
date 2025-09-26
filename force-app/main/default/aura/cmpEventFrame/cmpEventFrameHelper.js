({
    handleClick: function (component) {
        component.set("v.isdisabled",true);
        var contact = component.get("v.contactId");
        console.log('component.get("v.recordId") ', component.get("v.recordId"));
        console.log('contact', contact);
        if (!contact) {
            console.log('+++ return');
            return;
        }
        var action = component.get("c.CreateParticipation");
        action.setParams({
            EvId: component.get("v.recordId"),
            ContId: contact
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            console.log(state);
            if (state === "SUCCESS") {
                console.log('++++++');
                console.log('++++++', response.getReturnValue());
                console.log('++++++', contact);
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
            } else {
                let errors = response.getError(); let message = 'Unknown error'; // Default error message // Retrieve the error message sent by the server 
                if (errors && Array.isArray(errors) && errors.length > 0) {     
                    message = errors[0].message; } // Display the message 
                    console.error(message);
            }
        });
        $A.enqueueAction(action);
        alert($A.get("$Label.c.FAL_message_alert"));
    }
});