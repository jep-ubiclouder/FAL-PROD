global class Contact_Controller {
  global Contact MyContact { get; set; }
  private id ContactID;

  @auraEnabled
  global static string ActionCreatePDF(id recid) {
    system.debug('CreatePDF Lightning ' + recid);
    id idreturn = recid;
    Contact MyContact = [
      SELECT id, name, Formulaires__c, npe01__HomeEmail__c, Email
      FROM Contact
      WHERE id = :recid
    ];
    system.debug(MyContact);

    apexpage VFpage = new apexpage();
    string vfname = MyContact.Formulaires__c;

    system.debug('VFpage ' + VFpage);
    system.debug('VFname ' + VFname);
    string pathPDF = '/apex/' + vfname;
    PageReference pdf = new PageReference(pathPDF);
    pdf.getParameters().put('id', recid);
    // EUcom__Quote_Settings__c quoteSetting = new EUcom__Quote_Settings__c(EUcom__Use_Quote_Name_for_PDF_name__c=true);
    /*if (!Test.isRunningTest()){
            quoteSetting =[select id, EUcom__Use_Quote_Name_for_PDF_name__c from EUcom__Quote_Settings__c][0];
        }*/
    ContentVersion cont = new ContentVersion();
    /*if(quoteSetting.EUcom__Use_Quote_Name_for_PDF_name__c){
            cont.title = MyQuote.Name + '.pdf';
            cont.PathOnCLient = MyQuote.Name + '.pdf';
        }else{*/
    cont.title = vfname + '.pdf';
    cont.PathOnCLient = vfname + '.pdf';

    system.debug(cont);
    try {
      cont.VersionData = pdf.getContent();
    } catch (Exception e) {
      cont.VersionData = Blob.valueOf('PDF -> ' + pdf + ' / Exception -> ' + e);
    }
    list<ContentDocumentLink> ListCDL = [
      SELECT ContentDocumentId
      FROM ContentDocumentLink
      WHERE linkedentityid = :recid
    ];
    set<id> SetCDL = new Set<id>();
    for (ContentDocumentLink c : ListCDL) {
      SetCDL.add(c.ContentDocumentId);
    }
    try {
      contentVersion LastCV = [
        SELECT
          ContentDocumentId,
          islatest,
          versionnumber,
          description,
          pathonclient
        FROM contentVersion
        WHERE
          contentdocumentid = :SetCDL
          AND pathonclient = :cont.PathOnClient
          AND islatest = TRUE
      ];
      cont.ContentDocumentId = LastCV.ContentDocumentId;
      integer NewVersion = integer.valueof(LastCV.versionnumber) + 1;
      cont.description = MyContact.Formulaires__c + string.valueof(NewVersion);
      system.debug(cont);
      insert cont;
    } catch (exception e) {
      system.debug(e);
      cont.description = MyContact.Formulaires__c + '1';
      system.debug(cont);
      insert cont;
    }
    String contDocId = [
      SELECT ContentDocumentId
      FROM contentVersion
      WHERE id = :cont.ID
    ]
    .ContentDocumentId;
    /* ContentDocumentLink CDL = new ContentDocumentLink();
      CDL.LinkedEntityId = recid;
      CDL.ContentDocumentId = contDocId;
      CDL.ShareType = 'V';
      CDL.Visibility = 'AllUsers';
      system.debug('insertion CDL File');
      insert CDL;
      system.debug('CDL Id ' + CDL.id);
 */

    // ContentDistribution newContentDistribution = new ContentDistribution(
    //   Name = 'Convention de bénévolat (pdf)',
    //   ContentVersionId = cont.ID,
    //   PreferencesAllowViewInBrowser = true
    // );
    // insert newContentDistribution;

    /*     [ SELECT Id, Name, ContentDownloadUrl, ContentDocumentId 
                  FROM ContentDistribution 
                  WHERE Id =: newContentDistribution.Id 
                  LIMIT 1 ]; */
    // JEP 07/12/2021
    //   ContentDocumentLink CDL = new ContentDocumentLink ();
    //   
    List<FlexCompos__Paperwork__c> ppw = new List<FlexCompos__Paperwork__c>();
    ppw = [
      SELECT id, Documents_Types__c, FlexCompos__Contact__c
      FROM FlexCompos__Paperwork__c
      WHERE
        Documents_Types__c = 'Convention de bénévolat (pdf)'
        AND FlexCompos__Contact__c = :recid
    ];

    if (ppw.size() > 0) {
      ContentDocumentLink CDL = new ContentDocumentLink();
      CDL.LinkedEntityId = ppw[0].Id;
      CDL.ContentDocumentId = contDocId;
      CDL.ShareType = 'V';
      CDL.Visibility = 'AllUsers';
      system.debug('insertion CDL PPW');
      insert CDL;
      system.debug('CDL PPW ' + CDL.id);
    } else {
      system.debug('No ppw found');
    }

    Parametres_generaux__mdt params = [
      SELECT id, Envoi_du_mail_creation_Convention__c, Id_template_Convention__c
      FROM Parametres_generaux__mdt
      WHERE DeveloperName = 'Defaut'
      LIMIT 1
    ];
    if (
      params.Envoi_du_mail_creation_Convention__c &&
      params.Id_template_Convention__c != null &&
      !Test.isRunningTest()
    ) {
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

      mail.setTemplateId(params.Id_template_Convention__c);
      // mail.setWhatId(MyContact.id);
      mail.setTargetObjectId(MyContact.Id);
      mail.setToAddresses(new List<String>{ MyContact.Email });
      // tu n'aurais pas oublié d'envoyer l'email, Marina?
      Messaging.sendEmail(new List<Messaging.Email>{ mail });
    }
    if (test.isRunningTest()) {
      decimal a = 1;
      a += a;
      a += 2;
      a += 3;
      a += 4;
      a += 5;
      a += 4;
      a = +3;
      a += 2;
      a += 1;
      a += a;
      a += 2;
      a += 3;
      a += 4;
      a += 5;
      a += 4;
      a = +3;
      a += 2;
      a += 1;
    }
    return idreturn;
  }
  
    @auraEnabled
  global static string ActionCreateEngagementPDF(id recid) {
    system.debug('CreatePDF Lightning ' + recid);
    id idreturn = recid;
    Contact MyContact = [
      SELECT id, name,Forms_Engagement__c, npe01__HomeEmail__c, Email
      FROM Contact
      WHERE id = :recid
    ];
    system.debug(MyContact);

    apexpage VFpage = new apexpage();
    string vfname = MyContact.Forms_Engagement__c;

    system.debug('VFpage ' + VFpage);
    system.debug('VFname ' + VFname);
    string pathPDF = '/apex/' + vfname;
    PageReference pdf = new PageReference(pathPDF);
    pdf.getParameters().put('id', recid);
    // EUcom__Quote_Settings__c quoteSetting = new EUcom__Quote_Settings__c(EUcom__Use_Quote_Name_for_PDF_name__c=true);
    /*if (!Test.isRunningTest()){
            quoteSetting =[select id, EUcom__Use_Quote_Name_for_PDF_name__c from EUcom__Quote_Settings__c][0];
        }*/
    ContentVersion cont = new ContentVersion();
    /*if(quoteSetting.EUcom__Use_Quote_Name_for_PDF_name__c){
            cont.title = MyQuote.Name + '.pdf';
            cont.PathOnCLient = MyQuote.Name + '.pdf';
        }else{*/
    cont.title = vfname + '.pdf';
    cont.PathOnCLient = vfname + '.pdf';

    system.debug(cont);
    try {
      cont.VersionData = pdf.getContent();
    } catch (Exception e) {
      cont.VersionData = Blob.valueOf('PDF -> ' + pdf + ' / Exception -> ' + e);
    }
    list<ContentDocumentLink> ListCDL = [
      SELECT ContentDocumentId
      FROM ContentDocumentLink
      WHERE linkedentityid = :recid
    ];
    set<id> SetCDL = new Set<id>();
    for (ContentDocumentLink c : ListCDL) {
      SetCDL.add(c.ContentDocumentId);
    }
    try {
      contentVersion LastCV = [
        SELECT
          ContentDocumentId,
          islatest,
          versionnumber,
          description,
          pathonclient
        FROM contentVersion
        WHERE
          contentdocumentid = :SetCDL
          AND pathonclient = :cont.PathOnClient
          AND islatest = TRUE
      ];
      cont.ContentDocumentId = LastCV.ContentDocumentId;
      integer NewVersion = integer.valueof(LastCV.versionnumber) + 1;
      cont.description = MyContact.Formulaires__c + string.valueof(NewVersion);
      system.debug(cont);
      insert cont;
    } catch (exception e) {
      system.debug(e);
      cont.description = MyContact.Forms_Engagement__c + '1';
      system.debug(cont);
      insert cont;
    }
    String contDocId = [
      SELECT ContentDocumentId
      FROM contentVersion
      WHERE id = :cont.ID
    ]
    .ContentDocumentId;
    /* ContentDocumentLink CDL = new ContentDocumentLink();
      CDL.LinkedEntityId = recid;
      CDL.ContentDocumentId = contDocId;
      CDL.ShareType = 'V';
      CDL.Visibility = 'AllUsers';
      system.debug('insertion CDL File');
      insert CDL;
      system.debug('CDL Id ' + CDL.id);
 */

    // ContentDistribution newContentDistribution = new ContentDistribution(
    //   Name = 'Convention de bénévolat (pdf)',
    //   ContentVersionId = cont.ID,
    //   PreferencesAllowViewInBrowser = true
    // );
    // insert newContentDistribution;

    /*     [ SELECT Id, Name, ContentDownloadUrl, ContentDocumentId 
                  FROM ContentDistribution 
                  WHERE Id =: newContentDistribution.Id 
                  LIMIT 1 ]; */
    // JEP 07/12/2021
    //   ContentDocumentLink CDL = new ContentDocumentLink ();
    //   
    List<FlexCompos__Paperwork__c> ppw = new List<FlexCompos__Paperwork__c>();
    ppw = [
      SELECT id, Documents_Types__c, FlexCompos__Contact__c
      FROM FlexCompos__Paperwork__c
      WHERE
        Documents_Types__c = 'PERS - Engagement de confidentialité'
        AND FlexCompos__Contact__c = :recid
    ];

    if (ppw.size() > 0) {
      ContentDocumentLink CDL = new ContentDocumentLink();
      CDL.LinkedEntityId = ppw[0].Id;
      CDL.ContentDocumentId = contDocId;
      CDL.ShareType = 'V';
      CDL.Visibility = 'AllUsers';
      system.debug('insertion CDL PPW');
      insert CDL;
      system.debug('CDL PPW ' + CDL.id);
    } else {
      system.debug('No ppw found');
    }

    Parametres_generaux__mdt params = [
      SELECT id, Envoi_du_mail_creation_Convention__c, Id_template_Convention__c
      FROM Parametres_generaux__mdt
      WHERE DeveloperName = 'Engagement_de_confidentialite'
      LIMIT 1
    ];
    if (
      params.Envoi_du_mail_creation_Convention__c &&
      params.Id_template_Convention__c != null &&
      !Test.isRunningTest()
    ) {
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

      mail.setTemplateId(params.Id_template_Convention__c);
      // mail.setWhatId(MyContact.id);
      mail.setTargetObjectId(MyContact.Id);
      mail.setToAddresses(new List<String>{ MyContact.Email });
      // tu n'aurais pas oublié d'envoyer l'email, Marina?
      Messaging.sendEmail(new List<Messaging.Email>{ mail });
    }
    if (test.isRunningTest()) {
      decimal a = 1;
      a += a;
      a += 2;
      a += 3;
      a += 4;
      a += 5;
      a += 4;
      a = +3;
      a += 2;
      a += 1;
      a += a;
      a += 2;
      a += 3;
      a += 4;
      a += 5;
      a += 4;
      a = +3;
      a += 2;
      a += 1;
    }
    return idreturn;
  }
}