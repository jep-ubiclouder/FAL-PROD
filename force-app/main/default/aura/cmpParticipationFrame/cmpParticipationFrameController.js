({
    doInit: function (component, event, helper) {
		let record = component.get("v.participation");
        var action = component.get("c.getimageId");
		console.log('record ', record);
		console.log('record.Id ', record.Id);
		console.log('record.bre__BR_Event__c ', record.bre__BR_Event__c);
        action.setParams({
			PartId: component.get("v.recordId"),
            EvId: record.bre__BR_Event__c
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var resultat = response.getReturnValue();
                component.set("v.image", resultat[1]);
            }
            else if (state === 'ERROR') {
                let errors = response.getError(); let message = 'Unknown error'; // Default error message // Retrieve the error message sent by the server 
                if (errors && Array.isArray(errors) && errors.length > 0) {     
                    message = errors[0].message; } // Display the message 
                    console.error(message);
            }
        });
        $A.enqueueAction(action);
    },
    onClick: function (component, event, helper) {
        helper.handleClick(component);
    }
})