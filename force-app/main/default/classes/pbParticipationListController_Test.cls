@isTest(seeAllData = True)
public with sharing class pbParticipationListController_Test {
    public static testMethod void testthemethod() {
        List<Id> projectId = new List<Id>();
        projectId.add('a15AM0000005zijYAA');
        pbParticipationListController.method(projectId);
    }

    
    
      
    
}