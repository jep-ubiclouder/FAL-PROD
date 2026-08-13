public class ubRefreshDownloadURLs implements Database.Batchable < sObject > ,
Database.Stateful,
Database.RaisesPlatformEvents {
  public ubRefreshDownloadURLs() {

}
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator([select id, FlexCompos__Download_URL__c FROM FlexCompos__Paperwork__c
    where  FlexCompos__Download_URL__c!=null  limit 10]);
    // This query retrieves all FlexCompos paperwork records that are available for download
    // and do not have a download URL starting with 'https://flexcompos'.
  }

  public void execute(Database.BatchableContext bc, List < FlexCompos__Paperwork__c > scope) {
    List < FlexCompos__Paperwork__c > paperworkToUpdate = new List < FlexCompos__Paperwork__c > ();

    for (FlexCompos__Paperwork__c paperwork: scope) {
      if (paperwork.FlexCompos__Download_URL__c !=null &&   !paperwork.FlexCompos__Download_URL__c.startsWith('https://fal.my.salesforce.com')) {
        // Retrieve the ContentDocumentLink records associated with the FlexCompos paperwork
        // to ensure that the download URL is set correctly.
        List < ContentDocumentLink > contentLinks = [SELECT ContentDocumentId, LinkedEntityId
        FROM ContentDocumentLink
        WHERE LinkedEntityId = :paperwork.Id];
        if(contentLinks.isEmpty()) {
          System.debug('No ContentDocumentLink found for paperwork ID: ' + paperwork.Id);
          continue; // Skip to the next paperwork if no content link is found
        }
        List < ContentDistribution > contentVersionMap = [
        SELECT ContentDocumentId, ContentDownloadUrl
        FROM ContentDistribution
        WHERE ContentDocumentId = :contentLinks[0].ContentDocumentId];
        if (contentVersionMap.isEmpty()) {
          System.debug('No ContentDistribution found for ContentDocumentId: ' + contentLinks[0].ContentDocumentId);
          continue; // Skip to the next paperwork if no content distribution is found
        }
        // Check if the ContentDocumentLink exists for the FlexCompos paperwork
        paperwork.FlexCompos__Download_URL__c = contentVersionMap[0].ContentDownloadUrl;
        paperworkToUpdate.add(paperwork);
      }
    }

    if (!paperworkToUpdate.isEmpty()) {
      try {
        // Update the FlexCompos paperwork records with the new download URLs
        update paperworkToUpdate;
      } catch(DmlException e) {
        System.debug('Error updating FlexCompos paperwork: ' + e.getMessage());
      }
    }
  }
  public void finish(Database.BatchableContext bc) {
    // This method is intentionally left empty.
    // The actual logic for finalizing the batch will be implemented in the future. 
  }
}