({
    updateandrefresh: function (component) {

        let record = component.get("v.contact");
        var action = component.get("c.getContactsEventsParticipe");
        var  TripZoneDesid = component.get("v.zoneId");
        console.log('TripZoneDesid ', TripZoneDesid);
        var ProjectType = component.get("v.projectType");
        console.log('ProjectType ', ProjectType);
        var  TripZoneRecid = record.TripEventsZone__c;
        if (record.TripEventsZone__c == null) {
            alert('Completer Trip/Event Zone');
        }
        if (TripZoneDesid == null || TripZoneDesid.length == 0) {
            var ZoneId = TripZoneRecid;
        } else var ZoneId = TripZoneDesid
        console.log('ZoneId ', ZoneId);

        action.setParams({
            ContId: component.get("v.recordId"),
            TripEvZId: ZoneId,
            TypeofProject: ProjectType
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var listContactsEventsYes = response.getReturnValue();
                if (listContactsEventsYes == null) {
                    alert('Vous n"&#039"avez pas les events');
                }
                component.set("v.listeventsyes", listContactsEventsYes);
            } else if (state === 'ERROR') {
                let errors = response.getError();
                console.log('JSON ERROR', JSON.stringify(errors));
            }
        });
        $A.enqueueAction(action);

        var actionno = component.get("c.getContactsEventsNotPart");
        var  TripZoneDesid = component.get("v.zoneId");
        console.log('TripZoneDesid ', TripZoneDesid);
        var ProjectType=component.get("v.projectType");
        console.log('ProjectType ', ProjectType);
        var  TripZoneRecid = record.TripEventsZone__c;
        if (record.TripEventsZone__c == null) {
            alert('Completer Trip/Event Zone');
        }
        if (TripZoneDesid == null || TripZoneDesid.length == 0) {
            var ZoneId = TripZoneRecid;
        } else var ZoneId = TripZoneDesid
        console.log('ZoneId ', ZoneId);

        actionno.setParams({
            ContId: component.get("v.recordId"),
            TripEvZId: ZoneId,
            TypeofProject: ProjectType

        });
        actionno.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var listContactsEventsNo = response.getReturnValue();
                if (listContactsEventsNo == null) {
                    alert('Vous n"&#039"avez pas les events');
                }
                component.set("v.listeventsno", listContactsEventsNo);
            } else if (state === 'ERROR') {
                alert('ERROR OCCURED.');
            }
        });
        $A.enqueueAction(actionno);

        var actionmaybe = component.get("c.getContactsEventsMaybePart");
        var  TripZoneDesid = component.get("v.zoneId");
        console.log('TripZoneDesid ', TripZoneDesid);
        var ProjectType=component.get("v.projectType");
        console.log('ProjectType ', ProjectType);
        var  TripZoneRecid = record.TripEventsZone__c;
        if (record.TripEventsZone__c == null) {
            alert('Completer Trip/Event Zone');
        }
        if (TripZoneDesid == null || TripZoneDesid.length == 0) {
            var ZoneId = TripZoneRecid;
        } else var ZoneId = TripZoneDesid
        console.log('ZoneId ', ZoneId);

        actionmaybe.setParams({
            ContId: component.get("v.recordId"),
            TripEvZId: ZoneId,
            TypeofProject: ProjectType

        });
        actionmaybe.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var listContactsEventsMaybe = response.getReturnValue();
                if (listContactsEventsMaybe == null) {
                    alert('Vous n"&#039"avez pas les events pour la confirmaion');
                }
                component.set("v.listeventsmaybe", listContactsEventsMaybe);
            } else if (state === 'ERROR') {
                alert('ERROR OCCURED.');
            }
        });
        $A.enqueueAction(actionmaybe);

    }
})