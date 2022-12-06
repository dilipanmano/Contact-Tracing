({
    doInit: function (component, event, helper) {
        var tableScope = component.get("v.tableScope");
        if (tableScope === "person") {
            helper.setPersonTable(component);
        } else {
            helper.setLocationTable(component);
        }
        helper.fetchRecentChanges(component);
    },

    handleKeyUp: function (component, event, helper) {
        console.log("asdf");
        var isEnterKey = event.keyCode === 13;
        var queryTerm = component.find("enter-search").get("v.value");
        if (isEnterKey) {
            component.set("v.isSearching", true);
            helper.search(component, queryTerm);
        }
    },

    handleRowAction: function (component, event, helper) {
        var action = event.getParam("action");
        var row = event.getParam("row");
        var scope = component.get("v.tableScope");
        switch (action.name) {
            case "view_details":
                var appEvent = scope === "person" ? $A.get("e.c:CTPersonSelectEvent") : $A.get("e.c:CTLocationSelectEvent");
                appEvent.setParams({
                    recordId: row.Id,
                    status: scope === "person" ? row.Health_Status__c : row.Status__c
                });
                appEvent.fire();
        }
    }
});
