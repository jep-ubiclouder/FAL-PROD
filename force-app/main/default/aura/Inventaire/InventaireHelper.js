({
    saveDataTable: function (component, event, helper) {
        var editedRecords = component.find("PackagesDataTable").get("v.draftValues");
        console.log('helper 4', editedRecords);
        var Records = component.find("PackagesDataTable").get("v.data");
        console.log('helper 6');
        //console.log("Draft values"+ JSON.stringify(editedRecords))
        //console.log("Data values"+ JSON.stringify(Records))
        console.log(JSON.stringify(editedRecords));
        var totalRecordEdited = editedRecords.length;
        console.log('helper 10');
        var action = component.get("c.updatePackages");
        console.log('helper 12');
        action.setParams({
            'editedPackageList': JSON.stringify(editedRecords)
        });
        console.log('helper 16');
        action.setCallback(this, function (response) {
            var state = response.getState();
            console.log('helper 19 callback', state);
            if (state === "SUCCESS") {
                //if update is successful
                // if (response.getReturnValue() === true) {
                helper.showToast({
                    "title": "Record Update",
                    "type": "success",
                    "message": totalRecordEdited + " Packages Records Updated"
                });
                helper.reloadDataTable();
            } else { //if update got failed
                console.log('helper 30 error', state);
                let errors = response.getError();
                console.log('helper 30 error', errors);
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log('Error message: ' + errors[0] + message);
                    }
                } else {
                    console.log('Unknown error');
                }
                helper.showToast({
                    "title": "Error!!",
                    "type": "error",
                    "message": "Error in update"
                });

            }
        });
        console.log('helper 37 appel apex');
        $A.enqueueAction(action);
    },
    reloadDataTable: function () {
        var refreshEvent = $A.get("e.force:refreshView");
        if (refreshEvent) {
            refreshEvent.fire();
        }
    },
    showToast: function (params) {
        var toastEvent = $A.get("e.force:showToast");
        if (toastEvent) {
            toastEvent.setParams(params);
            toastEvent.fire();
        } else {
            alert(params.message);
        }
    },

})