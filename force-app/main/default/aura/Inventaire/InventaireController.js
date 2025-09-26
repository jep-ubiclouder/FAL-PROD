({
    doInit: function (cmp, event, helper) {
        //class="slds-max-medium-table_stacked"
        let dataTableColumns = [
            {
                label: "Product Name",
                fieldName: "EUcom__Product_Name__c",
                cellAttributes: {
                    class: "slds-col  slds-p-left_medium"
                }
            },
            //  id, EUcom__Product_Name__c, Seuil_Minimum__c
            // {
            //     label: 'Unités',
            //     fieldName: "Family",
            //     cellAttributes: {
            //         alignment: "center",
            //         class: "slds-col  slds-p-left_medium"
            //     }
            // },
            {
                label: 'Merchant',
                fieldName: "Fournisseur__c",
                cellAttributes: {
                    alignment: "center",
                    class: "slds-col  slds-p-left_medium"
                }
            },
            {
                label: 'Min. Stock',
                fieldName: "Seuil_Minimum__c",
                cellAttributes: {
                    alignment: "center",
                    class: "slds-col  slds-p-left_medium"
                }
            },
            {
                label: 'Quantity',
                fieldName: "EUcom__Quantity__c",
                editable: true,
                type: 'number',
                cellAttributes: {
                    alignment: "right",
                    class: "slds-col  slds-p-left_medium"
                }
            }
        ];
        cmp.set('v.dataTableColumns', dataTableColumns);

        // données
        let action = cmp.get('c.getInventoryLines');
        action.setParams({
            recId: cmp.get('v.recordId')
        });
        action.setCallback(this, function (resp) {
            console.log(JSON.stringify(resp));
            let state = resp.getState();
            if (state == 'SUCCESS') {
                let resul = JSON.parse(resp.getReturnValue());
                console.log('Return Value comme texte', resp.getReturnValue());
                console.log('Return Value', resul);
                cmp.set('v.mydata', resul);
            } else {
                let errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log('Error message: ' + errors[0] + message);
                    }
                } else {
                    console.log('Unknown error');
                }
            }
        });
        $A.enqueueAction(action);
    },
    onSave: function (component, event, helper) {
        helper.saveDataTable(component, event, helper);
    },
    handleRowAction: function (cmp, event, helper) {
        console.log('Hello there');
    }
})