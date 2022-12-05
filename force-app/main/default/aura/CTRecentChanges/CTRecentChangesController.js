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
    }
});
