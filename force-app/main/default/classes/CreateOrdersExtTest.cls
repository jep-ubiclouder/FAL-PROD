@isTest
public class CreateOrdersExtTest {

    @isTest
    static void PricebookTest() {
        Account account = new Account();
        account.Name = 'Test Account';
        insert account;
        Pricebook2 pricebook = new Pricebook2();
        pricebook.Name = 'Test';
        pricebook.IsActive = true;
        insert pricebook;
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(account);
        CreateOrdersExt extController = new CreateOrdersExt(stdController);
        system.assert(extController.PricebookEntries != null);
        List<SelectOption> options = extController.getPricebookOptions();
        system.assert(options != null); 
        system.assertEquals(1, options.size());
        SelectOption option = options[0];
        system.assertEquals(pricebook.Name, option.getLabel());
        system.assertEquals(pricebook.Id, option.getValue());
    }
}