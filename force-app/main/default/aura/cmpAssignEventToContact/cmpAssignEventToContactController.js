({
    doInit: function (component, event, helper) {
        helper.updateandrefresh(component);
    },

    handleApplicationEvent: function (component, event, helper) {
        helper.updateandrefresh(component, event);
    }
})