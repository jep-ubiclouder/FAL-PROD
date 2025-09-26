({
    redirectToContact: function(component, event, helper) {
        var loggedInUser;
        var state;
        var navEvt;
        var loggedInUser = $A.get("$SObjectType.CurrentUser.Id");
        var ContactId = $A.get("$SObjectType.CurrentUser.Contact");
		console.log("loggedInUser "+loggedInUser);
        console.log("ContactId "+ContactId);
        navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": loggedInUser,
                    "slideDevName": "detail"
                });
        navEvt.fire();
        //var action = component.get("c.getLoggedInUser");
        /*action.setCallback(this, function(response) {
            state = response.getState();
            if (state === "SUCCESS") {
                loggedInUser = response.getReturnValue();
                navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": loggedInUser.Contact.AccountId,
                    "slideDevName": "detail"
                });
                navEvt.fire();
            }
        });
        */
        //$A.enqueueAction(action);
   } 
})