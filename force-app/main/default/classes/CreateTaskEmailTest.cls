@isTest(SeeAllData=true)
public class CreateTaskEmailTest {

    static testMethod void TestinBoundEmail(){
       // create a new email and envelope object
       Messaging.InboundEmail email = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
       
     // setup the data for the email
      email.subject = 'Create Contact';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'email body\n2225256325\nTitle';
     
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('{\"Salutation\": \"Monsieur\",\"FirstName\": \"Pascal\",\"LastName\": \"Wangen\",\"Birth_Date__c\": \"1985-02-02\",\"Street\": \"Om Knupp 3\",\"PostalCode\": \"9991\",\"City\": \"Weiswampach\",\"Country\": \"Luxembourg\",\"MobilePhone\": \"123456\",\"Phone\": \"\",\"OfficePhone__c\": \"\",\"Email\": \"p.wangen@mum.lu\",\"email_2__c\": \"p.wangen@mum.lu\",\"FB_username__c\": \"\",\"Twitter_Username__c\": \"\",\"Instagram_Username__c\": \"\",\"Langue_Maternelle_1__c\": \"Luxembourgeois\",\"Langue_Maternelle_2__c\": \"Français\",\"Autres_Langues__c\": \"Luxembourgeois;Français;Anglais;Arabe\",\"Situation_Prof__c\": \"Avec un emploi\",\"Wish_Site__c\": \"Capellen;Rambrouch\",\"Avail_Monday_Morning__c\": true,\"Avail_Monday_AfterNoon__c\": false,\"Avail_Monday_Evening__c\": false,\"Avail_Tuesday_Morning__c\": false,\"Avail_Tuesday_AfterNoon__c\": true,\"Avail_Tuesday_Evening__c\": false,\"Avail_Wensday_Morning__c\": false,\"Avail_Wensday_AfterNoon__c\": true,\"Avail_Wensday_Evening__c\": false,\"Avail_Thursday_Morning__c\": true,\"Avail_Thursday_AfterNoon__c\": false,\"Avail_Thursday_Evening__c\": false,\"Avail_Friday_Morning__c\": false,\"Avail_Friday_AfterNoon__c\": false,\"Avail_Friday_Evening__c\": false,\"Avail_Saturday_Morning__c\": false,\"Avail_Saturday_Evening__c\": false,\"Avail_Saturday_AfterNoon__c\": false,\"Avail_Sunday_Morning__c\": false,\"Avail_Sunday_AfterNoon__c\": false,\"Avail_Sunday_Evening__c\": false,\"Wish_Help__c\": \"Aide administrative\"}');
      attachment.fileName ='Lead.json';
      attachment.mimeTypeSubType = 'json/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
          
  
          Test.startTest();
     // call the email service class and test it with the data in the testMethod
      CreateTaskEmail  testInbound=new CreateTaskEmail ();
      testInbound.handleInboundEmail(email, env);
        Test.stopTest();
      
}
}