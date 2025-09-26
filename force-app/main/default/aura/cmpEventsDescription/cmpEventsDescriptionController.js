({
    doInit: function (component, event, helper) {
        let record = component.get("v.evenement");
        console.log('record ', record);
        var action = component.get("c.getimageId");
        var actionevdesc = component.get("c.eventdescr");
        action.setParams({
            EvId: component.get("v.recordId")
        });
        actionevdesc.setParams({
            EvId: component.get("v.recordId")
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var resultat = response.getReturnValue();
                component.set("v.image", resultat[1]);
                component.set("v.langue", resultat[0]);
                component.set("v.photo", resultat[2]);
                if(resultat[0]=='fr'){component.set("v.displayfr", true);}
                if(resultat[0]=='en_US'){component.set("v.displayen", true);}
                if(resultat[0]=='de'){component.set("v.displayde", true);}
            } else if (state === 'ERROR') {
                errorMsg = response.getError()[0];
                alert(errorMsg);
            }
        });
        $A.enqueueAction(action);

        actionevdesc.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var resultat = response.getReturnValue();
                component.set("v.evenement", resultat[0]);
            } else if (state === 'ERROR') {
                let errors = response.getError(); let message = 'Unknown error'; // Default error message // Retrieve the error message sent by the server 
                if (errors && Array.isArray(errors) && errors.length > 0) {     
                    message = errors[0].message; } // Display the message 
                    console.error(message);
            }
        });
        $A.enqueueAction(actionevdesc);
    }
})