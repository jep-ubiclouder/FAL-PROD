@isTest(seeAllData = True)
public with sharing class Ctrl_AssignEventToContact_Test {
    public static testMethod void testgetimageId() {
        String idtest = 'a0rAM000000gZNMYA2';
        Ctrl_AssignEventToContact.getimageId(idtest);
    }

    public static testMethod void testgetContactsEventsParticipe() {
        String idevent1 = 'a0r5I000000eVlwQAE';
        String idtest = '0035I00000OWnHoQAL';
        String idType = 'Séjours';
        Ctrl_AssignEventToContact.getContactsEventsParticipe(idtest, idevent1, idType);
    }

    public static testMethod void testgetContactsEventsMaybePart() {
        String idevent1 = 'a0r5I000000eVlwQAE';
        String idtest = '0035I00000OWnHoQAL';
        String idType = 'Séjours';
        Ctrl_AssignEventToContact.getContactsEventsMaybePart(idtest, idevent1, idType);
    }

    public static testMethod void testgetContactsEventsNotPart() {
        String idtest = '0035I00000OWnHoQAL';
        String TripEvZId = 'a0s5I000000IIvUQAW';
        String idType ='Séjours';
        Ctrl_AssignEventToContact.getContactsEventsNotPart(idtest, TripEvZId, idType);
    }

    public static testMethod void testCreateParticipation(){
        String idevent1 = 'a0r5I000000eVlwQAE';
        String idevent2 = 'a0r5I000000eVnhQAE';
        String idtest = '0035I00000OWnHoQAL';
        String idpart= Ctrl_AssignEventToContact.CreateParticipation(idtest, idevent1);
        Ctrl_AssignEventToContact.UpdateParticipation(idtest, idevent1, idpart);
        Ctrl_AssignEventToContact.CreateParticipation(idtest, idevent2);

    }

    public static testMethod void testeventdescr() {
        String idevent1 = 'a0r5I000000eVlwQAE';
        Ctrl_AssignEventToContact.eventdescr(idevent1);
    }
}