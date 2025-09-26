public with sharing class CreateOrdersExt {

    private final Account acct;
    public string selectedPricebook {get;set;}
    public List<PricebookEntry> pricebookEntries {get; private set;}
    
    public CreateOrdersExt(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
        List<Pricebook2> pricebooks = [SELECT Id, Name from Pricebook2 where IsActive = true];
        if (pricebooks.size() > 0) {
            selectedPricebook = pricebooks[0].Id;
        }
        loadPricebookEntries();
    }
    
    public List<SelectOption> getPricebookOptions() {
        List<SelectOption> options = new List<SelectOption>();
        List<Pricebook2> pricebooks = [SELECT Id, Name from Pricebook2 where IsActive = true];
        for(Pricebook2 pricebook : pricebooks) {
          options.add(new SelectOption(pricebook.Id,pricebook.Name));
        }
        return options;
    }
    
    public void loadPricebookEntries() {
        pricebookEntries = [SELECT Id, Name, Product2.Name, Product2.ProductCode,
                            UnitPrice  
                           FROM PricebookEntry
                           WHERE Pricebook2Id =: selectedPricebook and IsActive = true];
    }
}