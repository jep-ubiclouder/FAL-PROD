Global class FicheEvenement_Controller {

Global FP2__Project__c Projet {get;set;}
    Private id ProjetID;
     
    @auraEnabled
    Global static string ActionCreatePDF(id recid) {
        system.debug('CreatePDF Lightning ' + recid);
        id idreturn = recid;
        FP2__Project__c Projet = [select id, name from FP2__Project__c where id=:recid ];
        system.debug(Projet);
        
        apexpage VFpage = new apexpage();
        string vfname = 'FicheEvenement';
       
        system.debug('VFpage '+VFpage);
        system.debug('VFname '+VFname);
        string pathPDF = '/apex/'+vfname;
        PageReference pdf = new PageReference(pathPDF);
        pdf.getParameters().put('id',recid);
       
        ContentVersion cont = new ContentVersion();
      
            cont.title = vfname + '.pdf';
            cont.PathOnCLient = vfname + '.pdf';
        
        system.debug(cont);
        try {
            cont.VersionData = pdf.getContent();
        } Catch(Exception e) {
            cont.VersionData = Blob.valueOf('PDF -> '+pdf+ ' / Exception -> '+e);
        }
        list<ContentDocumentLink> ListCDL = [select ContentDocumentId from ContentDocumentLink where linkedentityid=:recid];
        set<id> SetCDL = new Set<id>();
        for (ContentDocumentLink c : ListCDL ) {
            SetCDL.add(c.ContentDocumentId);
        }
        try {
            contentVersion LastCV = [select ContentDocumentId, islatest, versionnumber, description, pathonclient from contentVersion where contentdocumentid=:SetCDL and pathonclient=:cont.PathOnClient and islatest = true];
            cont.ContentDocumentId = LastCV.ContentDocumentId ;
            integer NewVersion = integer.valueof(LastCV.versionnumber)+1;
            cont.description = 'FicheEvenement'+Projet+'-'+string.valueof(NewVersion);
            system.debug(cont);
            insert cont;
        } catch (exception e) {
            system.debug(e);
            cont.description = 'FicheEvenement'+Projet+'-'+'1';
            system.debug(cont);
            insert cont;
            String contDocId = [select ContentDocumentId from contentVersion where id=:cont.ID ].ContentDocumentId;
            ContentDocumentLink CDL = new ContentDocumentLink ();
            CDL.LinkedEntityId = recid;
            CDL.ContentDocumentId = contDocId;
            CDL.ShareType ='I';
            CDL.Visibility = 'AllUsers';
            insert CDL;
        }
        return idreturn;
    }
}