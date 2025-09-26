global with sharing class PDFDonateursRemerciementsController {
  global string recId { get; set; }
  global ApexPages.StandardController MyController { get; set; }
  global list<Remerciment> listremerciments { get; set; }
  global list<RemercimentEntr> RemercimentEntrs { get; set; }
  global list<RemercimentAnnuel> listremercimentannuel { get; set; }
  global list<RemercimentAnnualEntr> listremercimentAnnualEnt { get; set; }
  global list<RemercimentOPEnt> listremercimentOPEnt{ get; set; }
  global list<RemercimentOP> listremercimentOP{ get; set; }

  public PDFDonateursRemerciementsController(
    ApexPages.StandardController stdController
  ) {
    MyController = stdController;
    recId = stdController.getid();
    //getData();
    //getDataAnnuel();
    //getDataEnt2();
  }

  /******************************************** Constructor for companys dons ********************************************/
  global class RemercimentEntr {
    global string EnteteL { get; set; }
    global string name { get; set; }
    global decimal Amount { get; set; }
    global string BillingStreet { get; set; }
    global string BillingCity { get; set; }
    global string BillingCountry { get; set; }
    global string BillingPostalCode { get; set; }
    global date donDate { get; set; }
    global string language { get; set; }
    global string campname { get; set; }

    public RemercimentEntr(
      string Entete,
      string nom,
      decimal Amount,
      string BillingStr,
      string BillingCity,
      string BillingCountry,
      string BillingCode,
      date donDate,
      string language,
      string campname
    ) {
      this.EnteteL = Entete;
      this.name = nom;
      this.Amount = Amount;
      this.BillingStreet = BillingStr;
      this.BillingCity = BillingCity;
      this.BillingCountry = BillingCountry;
      this.BillingPostalCode = BillingCode;
      this.donDate = donDate;
      this.language = language;
      this.campname = campname;
    }
  }

  /******************************************** Constructor for dons normale ********************************************/
  global class Remerciment {
    global string EnteteL { get; set; }
    global string Salutation { get; set; }
    global string FirstName { get; set; }
    global string LastName { get; set; }
    global decimal Amount { get; set; }
    global string MailingStreet { get; set; }
    global string MailingCity { get; set; }
    global string MailingCountry { get; set; }
    global string MailingCode { get; set; }
    global date donDate { get; set; }
    global string language { get; set; }
    global string campname { get; set; }

    public Remerciment(
      string Entete,
      string salut,
      string FirstN,
      string LastN,
      decimal Amount,
      string MailingStr,
      string MailingCity,
      string MailingCountry,
      string MailingCode,
      date donDate,
      string language,
      string campname
    ) {
      this.EnteteL = Entete;
      this.Salutation = salut;
      this.FirstName = FirstN;
      this.LastName = LastN;
      this.Amount = Amount;
      this.MailingStreet = MailingStr;
      this.MailingCity = MailingCity;
      this.MailingCountry = MailingCountry;
      this.MailingCode = MailingCode;
      this.donDate = donDate;
      this.language = language;
      this.campname = campname;
    }
  }

  /******************************************** Constructor Annual ********************************************/
  global class RemercimentAnnuel {
    global string EnteteL { get; set; }
    global string Salutation { get; set; }
    global string FirstName { get; set; }
    global string LastName { get; set; }
    global decimal Amount { get; set; }
    global string MailingStreet { get; set; }
    global string MailingCity { get; set; }
    global string MailingCountry { get; set; }
    global string MailingCode { get; set; }
    global string language { get; set; }
    global date donDate { get; set; }

    public RemercimentAnnuel(
      string Entete,
      string salut,
      string FirstN,
      string LastN,
      decimal Amount,
      string MailingStr,
      string MailingCity,
      string MailingCountry,
      string MailingCode,
      string language,
      date donDate
    ) {
      this.EnteteL = Entete;
      this.Salutation = salut;
      this.FirstName = FirstN;
      this.LastName = LastN;
      this.Amount = Amount;
      this.MailingStreet = MailingStr;
      this.MailingCity = MailingCity;
      this.MailingCountry = MailingCountry;
      this.MailingCode = MailingCode;
      this.language = language;
      this.donDate = donDate;
    }
  }

  /******************************************** Constructor Annual for company ********************************************/
  global class RemercimentAnnualEntr {
    global string EnteteL { get; set; }
    global string name { get; set; }
    global decimal Amount { get; set; }
    global string BillingStreet { get; set; }
    global string BillingCity { get; set; }
    global string BillingCountry { get; set; }
    global string BillingPostalCode { get; set; }
    global date donDate { get; set; }
    global string language { get; set; }

    public RemercimentAnnualEntr(
      string Entete,
      string nom,
      decimal Amount,
      string BillingStr,
      string BillingCity,
      string BillingCountry,
      string BillingCode,
      date donDate,
      string language
    ) {
      this.EnteteL = Entete;
      this.name = nom;
      this.Amount = Amount;
      this.BillingStreet = BillingStr;
      this.BillingCity = BillingCity;
      this.BillingCountry = BillingCountry;
      this.BillingPostalCode = BillingCode;
      this.donDate = donDate;
      this.language = language;
    }
  }

  /******************************************** Constructor OP for company ********************************************/
  global class RemercimentOPEnt {
    global string EnteteL { get; set; }
    global string name { get; set; }
    global decimal Amount { get; set; }
    global string BillingStreet { get; set; }
    global string BillingCity { get; set; }
    global string BillingCountry { get; set; }
    global string BillingPostalCode { get; set; }
    global date donDate { get; set; }
    global string language { get; set; }

    public RemercimentOPEnt(
      string Entete,
      string nom,
      decimal Amount,
      string BillingStr,
      string BillingCity,
      string BillingCountry,
      string BillingCode,
      date donDate,
      string language
    ) {
      this.EnteteL = Entete;
      this.name = nom;
      this.Amount = Amount;
      this.BillingStreet = BillingStr;
      this.BillingCity = BillingCity;
      this.BillingCountry = BillingCountry;
      this.BillingPostalCode = BillingCode;
      this.donDate = donDate;
      this.language = language;
    }
  }

  /******************************************** Constructor OP ********************************************/
  global class RemercimentOP {
    global string EnteteL { get; set; }
    global string Salutation { get; set; }
    global string FirstName { get; set; }
    global string LastName { get; set; }
    global decimal Amount { get; set; }
    global string MailingStreet { get; set; }
    global string MailingCity { get; set; }
    global string MailingCountry { get; set; }
    global string MailingCode { get; set; }
    global string language { get; set; }
    global date donDate { get; set; }

    public RemercimentOP(
      string Entete,
      string salut,
      string FirstN,
      string LastN,
      decimal Amount,
      string MailingStr,
      string MailingCity,
      string MailingCountry,
      string MailingCode,
      string language,
      date donDate
    ) {
      this.EnteteL = Entete;
      this.Salutation = salut;
      this.FirstName = FirstN;
      this.LastName = LastN;
      this.Amount = Amount;
      this.MailingStreet = MailingStr;
      this.MailingCity = MailingCity;
      this.MailingCountry = MailingCountry;
      this.MailingCode = MailingCode;
      this.language = language;
      this.donDate = donDate;
    }
  }

   /******************************************** Periodic acknowledgement ********************************************/
  public void getData() {
    Campaign campaignPer = [
      SELECT Id, Ordre_permanent__c, name
      FROM Campaign
      WHERE Id = :recId
    ];
    if (campaignPer.Ordre_permanent__c == true) {
      System.debug('Ordre permanent');
    } else {
      list<CampaignMember> cm = [
        SELECT
          CampaignId,
          ContactId,
          contact.Maternal_Language_1__c,
          contact.salutation,
          contact.firstname,
          contact.lastname,
          contact.MailingStreet,
          contact.MailingCity,
          contact.MailingCountry,
          contact.MailingPostalCode,
          contact.Acknowledgement__c,
          contact.Statut_Juridique__c,
          contact.Entete_Lettre_Remerciement__c
        FROM CampaignMember
        WHERE
          CampaignId = :recId
          AND contact.Acknowledgement__c = 'Once per opportunity'
          AND contact.Statut_Juridique__c = 'P'
      ];

      listremerciments = new List<Remerciment>();
      Map<Id, CampaignMember> mapcm = new Map<Id, CampaignMember>();
      set<id> contid = new Set<id>();
      for (CampaignMember campmember : cm) {
        //system.debug(campmember.contact.Acknowledgement__c);
        contid.add(campmember.ContactId);
        mapcm.put(campmember.ContactId, campmember);
      }

      list<Opportunity> opps = [
        SELECT
          Amount,
          CloseDate,
          npsp__Primary_Contact__c,
          CampaignId,
          Campaign.name
        FROM Opportunity
        WHERE
          npsp__Primary_Contact__c IN :contid
          AND CampaignId = :recId
          AND PDF_cree__c = FALSE
        LIMIT 50
      ];
      list <campaignmember> cmupd = new list<campaignmember>();
      //system.debug(opps.size());
      for (Opportunity o : opps) {
        listremerciments.add(
          new Remerciment(
            mapcm.get(o.npsp__Primary_Contact__c).contact.Entete_Lettre_Remerciement__c,
            mapcm.get(o.npsp__Primary_Contact__c).contact.Salutation,
            mapcm.get(o.npsp__Primary_Contact__c).contact.FirstName,
            mapcm.get(o.npsp__Primary_Contact__c).contact.LastName,
            o.Amount,
            mapcm.get(o.npsp__Primary_Contact__c).contact.MailingStreet,
            mapcm.get(o.npsp__Primary_Contact__c).contact.MailingCity,
            mapcm.get(o.npsp__Primary_Contact__c).contact.MailingCountry,
            mapcm.get(o.npsp__Primary_Contact__c).contact.MailingPostalCode,
            o.CloseDate,
            mapcm.get(o.npsp__Primary_Contact__c)
              .contact.Maternal_Language_1__c,
            o.Campaign.name
          )
        );
        o.PDF_cree__c = true;
        cmupd.add(mapcm.get(o.npsp__Primary_Contact__c));
        
      }
      update opps;
      set<CampaignMember> setcmupd = new set<CampaignMember>(cmupd);
      for (CampaignMember cmpdf : setcmupd) {
        cmpdf.Date_PDF__c = System.today();
      }
      list<CampaignMember> listcmupd = new list<CampaignMember>(setcmupd);
      update listcmupd;
    }
  }

  /******************************************** Periodic acknowledgement for company ********************************************/
  public void getDataEnt2() {
    Campaign campaignEnt = [
      SELECT Id, Ordre_permanent__c
      FROM Campaign
      WHERE Id = :recId
    ];
    if (campaignEnt.Ordre_permanent__c == true) {
      System.debug('Ordre permanent');
    } else {
      list<CampaignMember> cm2 = [
        SELECT
          CampaignId,
          ContactId,
          contact.Maternal_Language_1__c,
          contact.salutation,
          contact.Entete_Lettre_Remerciement__c,
          contact.firstname,
          contact.lastname,
          contact.MailingStreet,
          contact.MailingCity,
          contact.MailingCountry,
          contact.MailingPostalCode,
          contact.Acknowledgement__c,
          contact.Statut_Juridique__c,
          contact.Account.name,
          contact.account.billingstreet,
          contact.account.billingcity,
          contact.account.billingcountry,
          contact.account.billingpostalcode
        
        FROM CampaignMember
        WHERE CampaignId = :recId AND (contact.Statut_Juridique__c = 'AP' OR contact.Statut_Juridique__c = 'S' OR contact.Statut_Juridique__c = 'ASSOC')
      ];

      RemercimentEntrs = new List<RemercimentEntr>();
      Map<Id, CampaignMember> mapcm2 = new Map<Id, CampaignMember>();
      set<id> contid2 = new Set<id>();
      for (CampaignMember campmember2 : cm2) {
        //system.debug(campmember.contact.Acknowledgement__c);
        contid2.add(campmember2.ContactId);
        mapcm2.put(campmember2.ContactId, campmember2);
      }

      list<Opportunity> opps2 = [
        SELECT
          Amount,
          CloseDate,
          npsp__Primary_Contact__c,
          CampaignId,
          Campaign.Name
        FROM Opportunity
        WHERE
          npsp__Primary_Contact__c IN :contid2
          AND CampaignId = :recId
          AND PDF_cree__c = FALSE
        LIMIT 50
      ];
      list <campaignmember> cmupd2 = new list<campaignmember>();
      for (Opportunity o2 : opps2) {
        RemercimentEntrs.add(
          new RemercimentEntr(
            mapcm2.get(o2.npsp__Primary_Contact__c).contact.Entete_Lettre_Remerciement__c,
            mapcm2.get(o2.npsp__Primary_Contact__c).contact.Account.name,
            o2.Amount,
            mapcm2.get(o2.npsp__Primary_Contact__c)
              .contact.account.billingstreet,
            mapcm2.get(o2.npsp__Primary_Contact__c).contact.account.billingcity,
            mapcm2.get(o2.npsp__Primary_Contact__c)
              .contact.account.billingcountry,
            mapcm2.get(o2.npsp__Primary_Contact__c)
              .contact.account.billingpostalcode,
            o2.CloseDate,
            mapcm2.get(o2.npsp__Primary_Contact__c)
              .contact.Maternal_Language_1__c,
            o2.Campaign.Name
          )
        );
        cmupd2.add(mapcm2.get(o2.npsp__Primary_Contact__c));
        o2.PDF_cree__c = true;
      }
      update opps2;
      set<CampaignMember> setcmupd2 = new set<CampaignMember>(cmupd2);
      for (CampaignMember cmpdfent : setcmupd2) {
        cmpdfent.Date_PDF__c = System.today();
      }
      list<CampaignMember> listcmupd2 = new list<CampaignMember>(setcmupd2);
      update listcmupd2;
    }
  }

   /******************************************** Anuual acknowledgement ********************************************/
  public void getDataAnnuel() {
    list<CampaignMember> cmem = [
      SELECT
        CampaignId,
        ContactId,
        contact.Maternal_Language_1__c,
        contact.Acknowledgement__c,
        contact.salutation,
        contact.firstname,
        contact.lastname,
        contact.MailingStreet,
        contact.MailingCity,
        contact.Entete_Lettre_Remerciement__c,
        contact.MailingCountry,
        contact.MailingPostalCode,
        contact.Statut_Juridique__c
      FROM CampaignMember
      WHERE
        CampaignId = :recId
        AND contact.Acknowledgement__c = 'Once a year'
        AND contact.Statut_Juridique__c = 'P'
    ];
    System.debug('Campaign Members   ' + cmem.size());
    listremercimentannuel = new List<RemercimentAnnuel>();
    set<id> contid = new Set<id>();
    for (CampaignMember campaignpmember : cmem) {
      System.debug(campaignpmember.contact.Acknowledgement__c);
      contid.add(campaignpmember.ContactId);
      campaignpmember.Date_PDF__c = System.today();
    }
    update cmem;
    Campaign campaignannuel = [
      SELECT Id, StartDate, EndDate
      FROM Campaign
      WHERE Id = :recId
    ];
    Date startD;
    Date endD;
    startD = campaignannuel.StartDate;
    endD = campaignannuel.EndDate;
    AggregateResult[] oppsannuel = [
      SELECT SUM(Amount) total, npsp__Primary_Contact__c
      FROM Opportunity
      WHERE
        npsp__Primary_Contact__c IN :contid
        AND CloseDate >= :startD
        AND CloseDate <= :endD
        AND PDF_cree__c = FALSE
      GROUP BY npsp__Primary_Contact__c
    ];
    system.debug('oppsannuel   ' + oppsannuel.size());
    list<String> contactids = new List<string>();
    MAP<Id, Decimal> mapaggreg = new Map<Id, Decimal>();
    for (AggregateResult ag : oppsannuel) {
      contactids.add((String) ag.get('npsp__Primary_Contact__c'));
      system.debug('total   ' + (Decimal) ag.get('total'));
    }
    list<Contact> listcontact = [
      SELECT
        Id,
        salutation,
        FirstName,
        LastName,
        MailingStreet,
        MailingCity,
        MailingCountry,
        MailingPostalCode,
        Maternal_Language_1__c,
        Entete_Lettre_Remerciement__c
       
      FROM Contact
      WHERE Id IN :contactids
    ];
    for (Contact lcontact : listcontact) {
      for (AggregateResult ag : oppsannuel) {
        if (lcontact.Id == ag.get('npsp__Primary_Contact__c')) {
          listremercimentannuel.add(
            new RemercimentAnnuel(
              lcontact.Entete_Lettre_Remerciement__c,
              lcontact.Salutation,
              lcontact.FirstName,
              lcontact.LastName,
              (Decimal) ag.get('total'),
              lcontact.MailingStreet,
              lcontact.MailingCity,
              lcontact.MailingCountry,
              lcontact.MailingPostalCode,
              lcontact.Maternal_Language_1__c,
              endD
            )
          );
        }
        System.debug((Decimal) ag.get('total'));
      }
      
    }
    string str = 'getDataAnnuel';
    BatchUpdateCampaignMembersAfterPDF  batch = new BatchUpdateCampaignMembersAfterPDF(recId,str);
    Id myBId = Database.executeBatch(batch);

    BatchUpdateOpportunitiesAfterPDFCreate  batch2 = new BatchUpdateOpportunitiesAfterPDFCreate(recId,str);
    Id myBId2 = Database.executeBatch(batch2);
    
  }
  

  /******************************************** Anuual acknowledgement for company ********************************************/
  public void getDataAnnualEnt() {
    list<CampaignMember> cmem = [
      SELECT
        CampaignId,
        ContactId,
        contact.Maternal_Language_1__c,
        contact.salutation,
        contact.Entete_Lettre_Remerciement__c,
        contact.firstname,
        contact.lastname,
        contact.MailingStreet,
        contact.MailingCity,
        contact.MailingCountry,
        contact.MailingPostalCode,
        contact.Acknowledgement__c,
        contact.Statut_Juridique__c,
        contact.Account.name,
        contact.account.billingstreet,
        contact.account.billingcity,
        contact.account.billingcountry,
        contact.account.billingpostalcode
      FROM CampaignMember
      WHERE
        CampaignId = :recId
        AND contact.Acknowledgement__c = 'Once a year'
        AND (contact.Statut_Juridique__c = 'AP' OR contact.Statut_Juridique__c = 'S' OR contact.Statut_Juridique__c = 'ASSOC')
      ];

      listremercimentAnnualEnt = new List<RemercimentAnnualEntr>();
      set<id> contid = new Set<id>();
      for (CampaignMember campaignpmember : cmem){
        System.debug(campaignpmember.contact.Acknowledgement__c);
        contid.add(campaignpmember.ContactId);
      }
      Campaign campaignannuel = [
      SELECT Id, StartDate, EndDate
      FROM Campaign
      WHERE Id = :recId
      ];
      Date startD;
      Date endD;
      startD = campaignannuel.StartDate;
      endD = campaignannuel.EndDate;

      AggregateResult[] oppsannuel = [
      SELECT SUM(Amount) total, npsp__Primary_Contact__c
      FROM Opportunity
      WHERE
        npsp__Primary_Contact__c IN :contid
        AND CloseDate >= :startD
        AND CloseDate <= :endD
        AND PDF_cree__c = FALSE
      GROUP BY npsp__Primary_Contact__c
    ];
    system.debug('oppsannuel   ' + oppsannuel.size());
    list<String> contactids = new List<string>();
    for (AggregateResult ag : oppsannuel) {
      contactids.add((String) ag.get('npsp__Primary_Contact__c'));
      system.debug('total   ' + (Decimal) ag.get('total'));
    }
    list<Contact> listcontact = [
      SELECT
        Id,
        Entete_Lettre_Remerciement__c,
        account.name,
        account.billingstreet,
        account.billingcity,
        account.billingcountry,
        account.billingpostalcode,
        Maternal_Language_1__c
      FROM Contact
      WHERE Id IN :contactids
    ];
    
    for (Contact lcontact : listcontact) {
      for (AggregateResult ag : oppsannuel) {
        if (lcontact.Id == ag.get('npsp__Primary_Contact__c')) {
          listremercimentAnnualEnt.add(
            new RemercimentAnnualEntr(
              lcontact.Entete_Lettre_Remerciement__c,
              lcontact.account.name,
              (Decimal) ag.get('total'),
              lcontact.account.billingstreet,
              lcontact.account.billingcity,
              lcontact.account.billingcountry,
              lcontact.account.billingpostalcode,
              endD,
              lcontact.Maternal_Language_1__c
            )
          );
        }
        System.debug((Decimal) ag.get('total'));
      }
    }
    string str = 'getDataAnnualEnt';
    BatchUpdateCampaignMembersAfterPDF  batch = new BatchUpdateCampaignMembersAfterPDF(recId,str);
    Id myBId = Database.executeBatch(batch);

    BatchUpdateOpportunitiesAfterPDFCreate  batch2 = new BatchUpdateOpportunitiesAfterPDFCreate(recId,str);
    Id myBId2 = Database.executeBatch(batch2);
  } 


  /******************************************** OP acknowledgement ********************************************/
  public void getDataOP() {
    Campaign campaignOP = [
      SELECT Id, Ordre_permanent__c, name, StartDate, EndDate
      FROM Campaign
      WHERE Id = :recId
    ];
    if (campaignOP.Ordre_permanent__c == true) {
      Date endD;
      endD = campaignOP.EndDate;
      list<CampaignMember> cmOP = [
        SELECT
          CampaignId,
          ContactId,
          contact.Maternal_Language_1__c,
          contact.salutation,
          contact.firstname,
          contact.lastname,
          contact.MailingStreet,
          contact.MailingCity,
          contact.MailingCountry,
          contact.MailingPostalCode,
          contact.Acknowledgement__c,
          contact.Statut_Juridique__c,
          contact.Entete_Lettre_Remerciement__c
        FROM CampaignMember
        WHERE
          CampaignId = :recId
          AND contact.Acknowledgement__c = 'Once per opportunity'
          AND contact.Statut_Juridique__c = 'P'
      ];
      System.debug('Campaign Members   ' + cmOP.size());
      listremercimentOP = new List<RemercimentOP>();
      set<id> contid = new Set<id>();
      for (CampaignMember campaignpmember : cmOP) {
        System.debug(campaignpmember.contact.Acknowledgement__c);
        contid.add(campaignpmember.ContactId);
      }      
      AggregateResult[] oppsOP = [
      SELECT SUM(Amount) total, npsp__Primary_Contact__c
      FROM Opportunity
      WHERE
        npsp__Primary_Contact__c IN :contid
        AND CampaignId = :recId
        AND PDF_cree__c = FALSE
      GROUP BY npsp__Primary_Contact__c
      ];
      system.debug('oppsOP   ' + oppsOP.size());
      list<String> contactids = new List<string>();
      MAP<Id, Decimal> mapaggreg = new Map<Id, Decimal>();
      for (AggregateResult ag : oppsOP) {
        contactids.add((String) ag.get('npsp__Primary_Contact__c'));
        system.debug('total   ' + (Decimal) ag.get('total'));
      }
      list<Contact> listcontact = [
        SELECT
          Id,
          salutation,
          FirstName,
          LastName,
          MailingStreet,
          MailingCity,
          MailingCountry,
          MailingPostalCode,
          Maternal_Language_1__c,
          Entete_Lettre_Remerciement__c
        FROM Contact
        WHERE Id IN :contactids
      ];
      for (Contact lcontact : listcontact) {
        for (AggregateResult ag : oppsOP) {
          if (lcontact.Id == ag.get('npsp__Primary_Contact__c')) {
            listremercimentOP.add(
              new RemercimentOP(
                lcontact.Entete_Lettre_Remerciement__c,
                lcontact.Salutation,
                lcontact.FirstName,
                lcontact.LastName,
                (Decimal) ag.get('total'),
                lcontact.MailingStreet,
                lcontact.MailingCity,
                lcontact.MailingCountry,
                lcontact.MailingPostalCode,
                lcontact.Maternal_Language_1__c,
                endD
              )
            );
          }
          System.debug((Decimal) ag.get('total'));
        }
      }
    } else {
      System.debug('Button for ordres permanents');
    }
    string str = 'getDataOP';
    BatchUpdateCampaignMembersAfterPDF  batch = new BatchUpdateCampaignMembersAfterPDF(recId, str);
    Id myBId = Database.executeBatch(batch);

    BatchUpdateOpportunitiesAfterPDFCreate  batch2 = new BatchUpdateOpportunitiesAfterPDFCreate(recId, str);
    Id myBId2 = Database.executeBatch(batch2);
  }

  /******************************************** OP acknowledgement for company********************************************/
  public void getDataOPEnt() {
    Campaign campaignOP = [
      SELECT Id, Ordre_permanent__c, name
      FROM Campaign
      WHERE Id = :recId
    ];
    if (campaignOP.Ordre_permanent__c == true) {
      list<CampaignMember> cmOPEnt = [
        SELECT
          CampaignId,
          ContactId,
          contact.Maternal_Language_1__c,
          contact.salutation,
          contact.Acknowledgement__c,
          contact.Statut_Juridique__c,
          contact.Entete_Lettre_Remerciement__c
        FROM CampaignMember
        WHERE
          CampaignId = :recId
          AND contact.Acknowledgement__c = 'Once per opportunity'
          AND (contact.Statut_Juridique__c = 'AP' OR contact.Statut_Juridique__c = 'S' OR contact.Statut_Juridique__c = 'ASSOC')
      ];
      listremercimentOPEnt = new List<RemercimentOPEnt>();
      set<id> contid = new Set<id>();
      for (CampaignMember campaignpmember : cmOPEnt){
        System.debug(campaignpmember.contact.Acknowledgement__c);
        contid.add(campaignpmember.ContactId);
      }
      Campaign campaignannuel = [
      SELECT Id, StartDate, EndDate
      FROM Campaign
      WHERE Id = :recId
      ];
      Date endD;
      endD = campaignannuel.EndDate;
      AggregateResult[] oppsOPEnt = [
      SELECT SUM(Amount) total, npsp__Primary_Contact__c
      FROM Opportunity
      WHERE
        npsp__Primary_Contact__c IN :contid
        AND CampaignId = :recId
        AND PDF_cree__c = FALSE
      GROUP BY npsp__Primary_Contact__c
      ];
      system.debug('oppsOPEnt   ' + oppsOPEnt.size());
      list<String> contactids = new List<string>();
      for (AggregateResult ag : oppsOPEnt) {
        contactids.add((String) ag.get('npsp__Primary_Contact__c'));
        system.debug('total   ' + (Decimal) ag.get('total'));
      }
      list<Contact> listcontact = [
        SELECT
          Id,
          Entete_Lettre_Remerciement__c,
          account.name,
          account.billingstreet,
          account.billingcity,
          account.billingcountry,
          account.billingpostalcode,
          Maternal_Language_1__c
        FROM Contact
        WHERE Id IN :contactids
      ];
      for (Contact lcontact : listcontact) {
        for (AggregateResult ag : oppsOPEnt) {
          if (lcontact.Id == ag.get('npsp__Primary_Contact__c')) {
            listremercimentOPEnt.add(
              new RemercimentOPEnt(
                lcontact.Entete_Lettre_Remerciement__c,
                lcontact.account.name,
                (Decimal) ag.get('total'),
                lcontact.account.billingstreet,
                lcontact.account.billingcity,
                lcontact.account.billingcountry,
                lcontact.account.billingpostalcode,
                endD,
                lcontact.Maternal_Language_1__c
              )
            );
          }
          System.debug((Decimal) ag.get('total'));
        }
      }
    } else {
      System.debug('Button for ordres permanents');
    }
    string str = 'getDataOPEnt';
    BatchUpdateCampaignMembersAfterPDF  batch = new BatchUpdateCampaignMembersAfterPDF(recId, str);
    Id myBId = Database.executeBatch(batch);

    BatchUpdateOpportunitiesAfterPDFCreate  batch2 = new BatchUpdateOpportunitiesAfterPDFCreate(recId, str);
    Id myBId2 = Database.executeBatch(batch2);
  }

   /********************************************************-----PDF-----******************************************************/

  @AuraEnabled
  global static string DonateursPDF(string recId) {
    System.debug('CampaignId ' + recId);
    string Idreturn = recId;
    Campaign myCampaign = [SELECT Id, Name FROM Campaign WHERE Id = :recId];

    System.debug('myCampaign' + myCampaign);
    Organization org = [SELECT NamespacePrefix FROM Organization LIMIT 1];
    String vfname;
    apexpage VFpage = new apexpage();
    try {
      VFpage = [
        SELECT id, name
        FROM apexpage
        WHERE name = 'PDFDonateursRemerciements__c'
      ];
      if (org.NamespacePrefix == null) {
        vfname = 'c__' + VFpage.name;
      } else {
        vfname = VFpage.name;
      }
    } catch (Exception e) {
      vfname = 'PDFDonateursRemerciements';
    }
    String pathPDF = '/apex/' + vfname;
    PageReference pdf = new PageReference(pathPDF);
    pdf.getParameters().put('id', recId);

    Datetime x = Datetime.now();
    ContentVersion cont = new ContentVersion();
    cont.title =
      'DonateursRemerciements_' +
      '(' +
      myCampaign.Name +
      ')' +
      '-' +
      'Week' +
      '_' +
      x.format('w') +
      '.pdf';
    cont.PathOnCLient = 'DonateursRemerciements_' + myCampaign.Name;

    try {
      cont.VersionData = pdf.getContent();
    } catch (Exception e) {
      cont.VersionData = Blob.valueOf('PDF -> ' + pdf + ' / Exception -> ' + e);
    }

    list<ContentDocumentLink> ListCDL = [
      SELECT ContentDocumentId
      FROM ContentDocumentLink
      WHERE linkedentityid = :recId AND ContentDocument.title = :cont.title
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
      cont.description =
        'Campaign_' +
        myCampaign.Name +
        '-' +
        string.valueof(NewVersion);
      system.debug(cont);
      insert cont;
    } catch (exception e) {
      system.debug(e);
      cont.description = 'Campaign_' + myCampaign.Name + '-' + '1';
      system.debug(cont);
      insert cont;
      String contDocId = [
        SELECT ContentDocumentId
        FROM contentVersion
        WHERE id = :cont.ID
      ]
      .ContentDocumentId;
      ContentDocumentLink CDL = new ContentDocumentLink();
      CDL.LinkedEntityId = recId;
      CDL.ContentDocumentId = contDocId;
      idreturn = cont.ContentDocumentId;
      CDL.ShareType = 'I';
      CDL.Visibility = 'AllUsers';
      insert CDL;
    }
    return idreturn;
  }

  @AuraEnabled
  public static string EntreprisesPDF(string recId) {
    system.debug('CreatePDF ' + recId);
    string idreturn;
    Campaign myCampaign = [SELECT Id, Name FROM Campaign WHERE Id = :recId];
    Organization org = [SELECT NamespacePrefix FROM Organization LIMIT 1];
    String vfname;
    apexpage VFpage = new apexpage();
    try {
      VFpage = [
        SELECT id, name
        FROM apexpage
        WHERE name = 'PDFEntreprisesDonateursRemerciments__c'
      ];
      if (org.NamespacePrefix == null) {
        vfname = 'c__' + VFpage.name;
      } else {
        vfname = VFpage.name;
      }
    } catch (Exception e) {
      vfname = 'PDFEntreprisesDonateursRemerciments';
    }
    String pathPDF = '/apex/' + vfname;
    PageReference pdf = new PageReference(pathPDF);
    pdf.getParameters().put('id', recId);

    Datetime x = Datetime.now();
    ContentVersion cont = new ContentVersion();
    cont.title =
      'EntreprisesDonateursRemerciments_' +
      '(' +
      myCampaign.Name +
      ')' +
      '-' +
      'Week' +
      '_' +
      x.format('w') +
      '.pdf';
    cont.PathOnCLient = 'EntreprisesDonateursRemerciments_' + myCampaign.Name;

    try {
      cont.VersionData = pdf.getContent();
    } catch (Exception e) {
      cont.VersionData = Blob.valueOf('PDF -> ' + pdf + ' / Exception -> ' + e);
    }

    list<ContentDocumentLink> ListCDL = [
      SELECT ContentDocumentId
      FROM ContentDocumentLink
      WHERE linkedentityid = :recId AND ContentDocument.title = :cont.title
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
      cont.description =
        'Campaign_' +
        myCampaign.Name +
        '-' +
        string.valueof(NewVersion);
      system.debug(cont);
      insert cont;
    } catch (exception e) {
      system.debug(e);
      cont.description = 'Campaign_' + myCampaign.Name + '-' + '1';
      system.debug(cont);
      insert cont;
      String contDocId = [
        SELECT ContentDocumentId
        FROM contentVersion
        WHERE id = :cont.ID
      ]
      .ContentDocumentId;
      ContentDocumentLink CDL = new ContentDocumentLink();
      CDL.LinkedEntityId = recId;
      CDL.ContentDocumentId = contDocId;
      idreturn = cont.ContentDocumentId;
      CDL.ShareType = 'I';
      CDL.Visibility = 'AllUsers';
      insert CDL;
    }
    return idreturn;
  }

  @AuraEnabled
  public static string AnnuelPDF(string recId) {
    system.debug('CreatePDF ' + recId);
    string idreturn;
    Campaign myCampaign = [SELECT Id, Name FROM Campaign WHERE Id = :recId];
    Organization org = [SELECT NamespacePrefix FROM Organization LIMIT 1];
    String vfname;
    apexpage VFpage = new apexpage();
    try {
      VFpage = [
        SELECT id, name
        FROM apexpage
        WHERE name = 'PDFDonateurRemerciementsAnnuel__c'
      ];
      if (org.NamespacePrefix == null) {
        vfname = 'c__' + VFpage.name;
      } else {
        vfname = VFpage.name;
      }
    } catch (Exception e) {
      vfname = 'PDFDonateurRemerciementsAnnuel';
    }
    String pathPDF = '/apex/' + vfname;
    PageReference pdf = new PageReference(pathPDF);
    pdf.getParameters().put('id', recId);

    Datetime x = Datetime.now();
    ContentVersion cont = new ContentVersion();
    cont.title =
      'PDFDonateurRemerciementsAnnuel_' +
      '(' +
      myCampaign.Name +
      ')' +
      '-' +
      'Week' +
      '_' +
      x.format('w') +
      '.pdf';
    cont.PathOnCLient = 'PDFDonateurRemerciementsAnnuel_' + myCampaign.Name;

    try {
      cont.VersionData = pdf.getContent();
    } catch (Exception e) {
      cont.VersionData = Blob.valueOf('PDF -> ' + pdf + ' / Exception -> ' + e);
    }

    list<ContentDocumentLink> ListCDL = [
      SELECT ContentDocumentId
      FROM ContentDocumentLink
      WHERE linkedentityid = :recId AND ContentDocument.title = :cont.title
    ];
    //AND ContentDocument.title =: cont.title
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
      cont.description =
        'Campaign_' +
        myCampaign.Name +
        '-' +
        string.valueof(NewVersion);
      system.debug(cont);
      insert cont;
    } catch (exception e) {
      system.debug(e);
      cont.description = 'Campaign_' + myCampaign.Name + '-' + '1';
      system.debug(cont);
      insert cont;
      String contDocId = [
        SELECT ContentDocumentId
        FROM contentVersion
        WHERE id = :cont.ID
      ]
      .ContentDocumentId;
      ContentDocumentLink CDL = new ContentDocumentLink();
      CDL.LinkedEntityId = recId;
      CDL.ContentDocumentId = contDocId;
      idreturn = cont.ContentDocumentId;
      CDL.ShareType = 'I';
      CDL.Visibility = 'AllUsers';
      insert CDL;
    }
    return idreturn;
  }

  @AuraEnabled
  public static string EntAnnuelPDF(string recId) {
    system.debug('CreatePDF ' + recId);
    string idreturn;
    Campaign myCampaign = [SELECT Id, Name FROM Campaign WHERE Id = :recId];
    Organization org = [SELECT NamespacePrefix FROM Organization LIMIT 1];
    String vfname;
    apexpage VFpage = new apexpage();
    try {
      VFpage = [
        SELECT id, name
        FROM apexpage
        WHERE name = 'PDFEntreprisesRemerciementsAnnuel__c'
      ];
      if (org.NamespacePrefix == null) {
        vfname = 'c__' + VFpage.name;
      } else {
        vfname = VFpage.name;
      }
    } catch (Exception e) {
      vfname = 'PDFEntreprisesRemerciementsAnnuel';
    }
    String pathPDF = '/apex/' + vfname;
    PageReference pdf = new PageReference(pathPDF);
    pdf.getParameters().put('id', recId);

    Datetime x = Datetime.now();
    ContentVersion cont = new ContentVersion();
    cont.title =
      'PDFEntreprisesRemerciementsAnnuel_' +
      '(' +
      myCampaign.Name +
      ')' +
      '-' +
      'Week' +
      '_' +
      x.format('w') +
      '.pdf';
    cont.PathOnCLient = 'PDFEntreprisesRemerciementsAnnuel_' + myCampaign.Name;

    try {
      cont.VersionData = pdf.getContent();
    } catch (Exception e) {
      cont.VersionData = Blob.valueOf('PDF -> ' + pdf + ' / Exception -> ' + e);
    }

    list<ContentDocumentLink> ListCDL = [
      SELECT ContentDocumentId
      FROM ContentDocumentLink
      WHERE linkedentityid = :recId AND ContentDocument.title = :cont.title
    ];
    //AND ContentDocument.title =: cont.title
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
      cont.description =
        'Campaign_' +
        myCampaign.Name +
        '-' +
        string.valueof(NewVersion);
      system.debug(cont);
      insert cont;
    } catch (exception e) {
      system.debug(e);
      cont.description = 'Campaign_' + myCampaign.Name + '-' + '1';
      system.debug(cont);
      insert cont;
      String contDocId = [
        SELECT ContentDocumentId
        FROM contentVersion
        WHERE id = :cont.ID
      ]
      .ContentDocumentId;
      ContentDocumentLink CDL = new ContentDocumentLink();
      CDL.LinkedEntityId = recId;
      CDL.ContentDocumentId = contDocId;
      idreturn = cont.ContentDocumentId;
      CDL.ShareType = 'I';
      CDL.Visibility = 'AllUsers';
      insert CDL;
    }
    return idreturn;
  }

  @AuraEnabled
  public static string OPDonateursPDF(string recId) {
    system.debug('CreatePDF ' + recId);
    string idreturn;
    Campaign myCampaign = [SELECT Id, Name FROM Campaign WHERE Id = :recId];
    Organization org = [SELECT NamespacePrefix FROM Organization LIMIT 1];
    String vfname;
    apexpage VFpage = new apexpage();
    try {
      VFpage = [
        SELECT id, name
        FROM apexpage
        WHERE name = 'PDFDonateurRemerciementsOP__c'
      ];
      if (org.NamespacePrefix == null) {
        vfname = 'c__' + VFpage.name;
      } else {
        vfname = VFpage.name;
      }
    } catch (Exception e) {
      vfname = 'PDFDonateurRemerciementsOP';
    }
    String pathPDF = '/apex/' + vfname;
    PageReference pdf = new PageReference(pathPDF);
    pdf.getParameters().put('id', recId);

    Datetime x = Datetime.now();
    ContentVersion cont = new ContentVersion();
    cont.title =
      'PDFDonateurRemerciementsOP_' +
      '(' +
      myCampaign.Name +
      ')' +
      '-' +
      'Week' +
      '_' +
      x.format('w') +
      '.pdf';
    cont.PathOnCLient = 'PDFDonateurRemerciementsOP_' + myCampaign.Name;

    try {
      cont.VersionData = pdf.getContent();
    } catch (Exception e) {
      cont.VersionData = Blob.valueOf('PDF -> ' + pdf + ' / Exception -> ' + e);
    }

    list<ContentDocumentLink> ListCDL = [
      SELECT ContentDocumentId
      FROM ContentDocumentLink
      WHERE linkedentityid = :recId AND ContentDocument.title = :cont.title
    ];
    //AND ContentDocument.title =: cont.title
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
      cont.description =
        'Campaign_' +
        myCampaign.Name +
        '-' +
        string.valueof(NewVersion);
      system.debug(cont);
      insert cont;
    } catch (exception e) {
      system.debug(e);
      cont.description = 'Campaign_' + myCampaign.Name + '-' + '1';
      system.debug(cont);
      insert cont;
      String contDocId = [
        SELECT ContentDocumentId
        FROM contentVersion
        WHERE id = :cont.ID
      ]
      .ContentDocumentId;
      ContentDocumentLink CDL = new ContentDocumentLink();
      CDL.LinkedEntityId = recId;
      CDL.ContentDocumentId = contDocId;
      idreturn = cont.ContentDocumentId;
      CDL.ShareType = 'I';
      CDL.Visibility = 'AllUsers';
      insert CDL;
    }
    return idreturn;
  }

  @AuraEnabled
  public static string EntOPPDF(string recId) {
    system.debug('CreatePDF ' + recId);
    string idreturn;
    Campaign myCampaign = [SELECT Id, Name FROM Campaign WHERE Id = :recId];
    Organization org = [SELECT NamespacePrefix FROM Organization LIMIT 1];
    String vfname;
    apexpage VFpage = new apexpage();
    try {
      VFpage = [
        SELECT id, name
        FROM apexpage
        WHERE name = 'PDFEntreprisesRemerciementsOP__c'
      ];
      if (org.NamespacePrefix == null) {
        vfname = 'c__' + VFpage.name;
      } else {
        vfname = VFpage.name;
      }
    } catch (Exception e) {
      vfname = 'PDFEntreprisesRemerciementsOP';
    }
    String pathPDF = '/apex/' + vfname;
    PageReference pdf = new PageReference(pathPDF);
    pdf.getParameters().put('id', recId);

    Datetime x = Datetime.now();
    ContentVersion cont = new ContentVersion();
    cont.title =
      'PDFEntreprisesRemerciementsOP_' +
      '(' +
      myCampaign.Name +
      ')' +
      '-' +
      'Week' +
      '_' +
      x.format('w') +
      '.pdf';
    cont.PathOnCLient = 'PDFEntreprisesRemerciementsOP_' + myCampaign.Name;

    try {
      cont.VersionData = pdf.getContent();
    } catch (Exception e) {
      cont.VersionData = Blob.valueOf('PDF -> ' + pdf + ' / Exception -> ' + e);
    }

    list<ContentDocumentLink> ListCDL = [
      SELECT ContentDocumentId
      FROM ContentDocumentLink
      WHERE linkedentityid = :recId AND ContentDocument.title = :cont.title
    ];
    //AND ContentDocument.title =: cont.title
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
      cont.description =
        'Campaign_' +
        myCampaign.Name +
        '-' +
        string.valueof(NewVersion);
      system.debug(cont);
      insert cont;
    } catch (exception e) {
      system.debug(e);
      cont.description = 'Campaign_' + myCampaign.Name + '-' + '1';
      system.debug(cont);
      insert cont;
      String contDocId = [
        SELECT ContentDocumentId
        FROM contentVersion
        WHERE id = :cont.ID
      ]
      .ContentDocumentId;
      ContentDocumentLink CDL = new ContentDocumentLink();
      CDL.LinkedEntityId = recId;
      CDL.ContentDocumentId = contDocId;
      idreturn = cont.ContentDocumentId;
      CDL.ShareType = 'I';
      CDL.Visibility = 'AllUsers';
      insert CDL;
    }
    return idreturn;
  }


}