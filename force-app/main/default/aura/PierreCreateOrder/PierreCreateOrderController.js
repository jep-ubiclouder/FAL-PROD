({
  init: function(component) {
    // Find the component whose aura:id is "flowData"
    var flow = component.find("flowData");
    // In that component, start your flow. Reference the flow's API Name.
    flow.startFlow("Commande_Faire_une_demande");

    // close the panel after flow execution
  },
  handleStatusChange: function(component, event) {
      console.log('status', event.getParam("status"));
    if (event.getParam("status") === "FINISHED") {
      var dismissActionPanel = $A.get("e.force:closeQuickAction");
      dismissActionPanel.fire();
      // Redirect to another page in Salesforce, or
      // Redirect to a page outside of Salesforce, or
      // Show a toast, or...
    }
  }
});