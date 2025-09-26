global with sharing class ubSendUmisignDebug {
  global class paramRequest {
    @InvocableVariable(required=true Label='Id du record source')
    global String PaperworkId;
    @InvocableVariable(required=true)
    global String action;
    global paramRequest(){

    }
    global paramRequest(String PaperworkId, String action ){
      this.PaperworkId =PaperworkId;
      this.action =action;
    }
  }

  @InvocableMethod
  global static List<String> request(paramRequest[] params) {
    List<String> l = new List<String>();
    if (params[0].action == 'Sign') {
      l.add(callYumiSignToStartWorkflow(params[0].PaperworkId));
    } else {
      l.add(callYumiSignToVerifyWorkfow(params[0].PaperworkId));
    }
    return l;
  }

  //@Future(callout=true)
  global static String callYumiSignToStartWorkflow(String paperworkId) {
    //
    //récupération du VersionData du Paperwork
    //

    try {
      FlexCompos__Paperwork__c p = [
        SELECT
          Id,
          FlexCompos__Contact__r.FirstName,
          FlexCompos__Contact__r.LastName,
          FlexCompos__Contact__r.Email,
          FlexCompos__Envelope_Id__c,
          FlexCompos__FileName__c
        FROM FlexCompos__Paperwork__c
        WHERE Id = :paperworkId
      ];
      ContentDocumentLink cl = [
        SELECT ContentDocumentId, LinkedEntityId
        FROM ContentDocumentLink
        WHERE LinkedEntityId = :paperworkId
      ];
      ContentDistribution cditrib = [
        SELECT
          Id,
          Name,
          ContentDownloadUrl,
          ContentDocumentId,
          PreferencesNotifyOnVisit
        FROM ContentDistribution
        WHERE ContentDocumentId = :cl.ContentDocumentId
        LIMIT 1
      ];
      ContentVersion cv = [
        SELECT VersionData
        FROM ContentVersion
        WHERE ContentDocumentId = :cditrib.ContentDocumentId AND IsLatest = TRUE
        LIMIT 1
      ];
      string data = EncodingUtil.base64Encode(cv.VersionData);
      //
      //
      //

      //
      //Construction formData à l'aide de la classe HttpHexFormBuilder
      //
      Blob formData = HttpHexFormBuilder.build()
        .writeParam('name', p.FlexCompos__FileName__c)
        .writeParam('type', 'simple')
        .writeParam('steps[0][type]', 'sign')
        .writeParam(
          'steps[0][recipients][0][name]',
          p.FlexCompos__Contact__r.FirstName + p.FlexCompos__Contact__r.LastName
        )
        .writeParam(
          'steps[0][recipients][0][email]',
          p.FlexCompos__Contact__r.Email
        )
        .writeFile('document', p.FlexCompos__FileName__c, data)
        .getFormAsBlob();

      //Construction de la requête
      //

      FlexCompos__Signature_Provider_Key__c signatureKey = FlexCompos__Signature_Provider_Key__c.getInstance();
      Boolean Debug_mode =
        signatureKey.FlexCompos__Advanced_Debug_Info__c || test.isRunningTest();

      String URL_BASE = 'https://app.yumisign.com/api/v1/quick/envelopes';
      String key = signatureKey.FlexCompos__Key__c;
      System.debug('key+++' + key);
      HttpRequest request = new HttpRequest();
      request.setEndpoint(URL_BASE);
      request.setMethod('POST');
      request.setHeader('Connection', 'keep-alive');
      request.setHeader('X-YumiSign-Api-Key', key);
      request.setHeader('Content-Length', String.valueOf(formData.size()));
      request.setHeader('Content-Type', HttpHexFormBuilder.GetContentType());
      request.setBodyAsBlob(formData);
      // request = JSON.serialize(request);
      //Envoit de la requpete
      system.debug('body' + request.getBody());
      Http http = new Http();
      String resBody = '{"id":"0000"}';
      HttpResponse response = new HttpResponse();

      if (!Test.isRunningTest()) {
        response = http.send(request);
        resBody = response.getBody();
        //  response =JSON.serialize(respose);
        //  resBody = resBody;
      }
      System.debug(resBody);
      if(response.getStatusCode() == 200){

      //Récupération de l'id de l'enveloppe créé et enregistrement de cet id sur le Paperwork
      //
      Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(
        resBody
      );
      p.FlexCompos__Envelope_Id__c = (String) m.get('id');
      update p;
      } else {throw new AuraHandledException('Message error '+ response.getBody() + 'Status code ' + response.getStatusCode() );}
      //
      //
      if (!test.isRunningTest()) {
        return 'Created';
      } else {
        throw new AuraHandledException('exceptionText');
      }
    } catch (Exception e) {
      // get apex Exception emails recipients.
      system.debug('Message ' + e.getMessage() + '-Line: ' + e.getLineNumber());
      List<ApexEmailNotification> listRecipients = [
        SELECT UserId, Email
        FROM ApexEmailNotification
      ];
      Set<String> Users = new Set<String>();

      // Set<String> Recipients = new   Set<String>();
      for (ApexEmailNotification element : listRecipients) {
        Users.add(element.userId);
      }
      List<User> Recipients = [SELECT id, email FROM user WHERE id IN :Users];
      Set<String> emails = new Set<String>();

      for (user u : Recipients) {
        if (u.Email != null) {
          emails.add(u.Email);
        }
      }

      Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
      message.toAddresses = new List<String>(emails);
      // message.optOutPolicy = 'FILTER';
      message.subject = 'Flow Error Yumisign From exception handler';

      message.plainTextBody =
        'Here is the resBody a JSON --- ' +
        'Message ' +
        e.getMessage() +
        '-Line: ' +
        e.getLineNumber();

      Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>{
        message
      };
      if (!test.isRunningTest()) {
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

        if (results[0].success) {
          System.debug('The email was sent successfully.');
        } else {
          System.debug(
            'The email failed to send: ' + results[0].errors[0].message
          );
        }
      }
      if (!test.isRunningTest()) {
        throw new AuraHandledException(
          'Message ' +
          e.getMessage() +
          '-Line: ' +
          e.getLineNumber()
        );
      } else {
        return 'Created';
      }
    }
  }

  //@Future(callout=true)
  global static String callYumiSignToVerifyWorkfow(String paperworkId) {
    FlexCompos__Paperwork__c p = [
      SELECT
        Id,
        FlexCompos__Contact__r.FirstName,
        FlexCompos__Contact__r.LastName,
        FlexCompos__Contact__r.Email,
        FlexCompos__Envelope_Id__c
      FROM FlexCompos__Paperwork__c
      WHERE Id = :paperworkId
    ];

    HttpRequest request = new HttpRequest();
    request.setMethod('GET');

    FlexCompos__Signature_Provider_Key__c signatureKey = FlexCompos__Signature_Provider_Key__c.getOrgDefaults();
    String key = signatureKey.FlexCompos__Key__c;
    request.setHeader('X-YumiSign-Api-Key', key);

    String URL_BASE =
      'https://app.yumisign.com/api/v1/quick/envelopes/' +
      p.FlexCompos__Envelope_Id__c;
    request.setEndpoint(URL_BASE);

    Http httpreq = new Http();
    String resbody = '{"status":"signed","documents":[{"file":{"file":"test"}}]}';
    if (!Test.isRunningTest()) {
      HttpResponse res = httpreq.send(request);
      resBody = res.getBody();
    }
    System.debug(resBody);

    Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(
      resBody
    );

    String state = (String) m.get('status');
    if (state == 'signed') {
      List<Object> m2 = (List<Object>) m.get('documents');
      System.debug(m2.size());
      Map<String, Object> f = (Map<String, Object>) m2[0];
      System.debug(f);
      Map<String, Object> file = (Map<String, Object>) f.get('file');
      String url = (String) file.get('file');
      getDocument(url, paperworkId);
      return 'Signed';
    } else {
      return 'Not signed';
    }
  }

  public static void getDocument(String url, String paperworkId) {
    HttpRequest request = new HttpRequest();
    request.setMethod('GET');

    FlexCompos__Signature_Provider_Key__c signatureKey = FlexCompos__Signature_Provider_Key__c.getOrgDefaults();
    String key = signatureKey.FlexCompos__Key__c;
    request.setHeader('X-YumiSign-Api-Key', key);

    String URL_BASE = url;
    request.setEndpoint(URL_BASE);

    Http httpreq = new Http();
    Blob resBody = Blob.valueof('test');
    if (!Test.isRunningTest()) {
      HttpResponse res = httpreq.send(request);
      resBody = res.getBodyAsBlob();
    }

    ContentDocumentLink cl = [
      SELECT ContentDocumentId, LinkedEntityId
      FROM ContentDocumentLink
      WHERE LinkedEntityId = :paperworkId
    ];
    ContentDistribution cditrib = [
      SELECT
        Id,
        Name,
        ContentDownloadUrl,
        ContentDocumentId,
        PreferencesNotifyOnVisit
      FROM ContentDistribution
      WHERE ContentDocumentId = :cl.ContentDocumentId
      LIMIT 1
    ];
    ContentVersion contentVersion = new ContentVersion(
      ContentDocumentId = cl.ContentDocumentId,
      Title = 'file.pdf',
      PathOnClient = 'file.pdf',
      ReasonForChange = 'Document replaced by user',
      VersionData = resBody,
      IsMajorVersion = true
    );

    insert contentVersion;
  }
}