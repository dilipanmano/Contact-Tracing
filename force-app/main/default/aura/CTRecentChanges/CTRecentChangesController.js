({
    doInit: function (component, event, helper) {
        var tableScope = component.get("v.tableScope");
        if (tableScope === "person") {
            helper.setPersonTable(component);
        } else {
            helper.setLocationTable(component);
        }
        helper.fetchRecentChanges(component);
    }
});
