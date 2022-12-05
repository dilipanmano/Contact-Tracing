({
    fetchRecentChanges: function (component) {
        var scope = component.get("v.tableScope");
        var action =
            scope === "person" ? component.get("c.getRecentPersonHealthChanges") : component.get("c.getRecentLocationHealthChanges");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue());
                component.set("v.data", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    setPersonTable: function (component) {
        component.set("v.columns", [
            { label: "Name", fieldName: "Name", type: "text" },
            { label: "Health Status", fieldName: "Health_Status__c", type: "text" },
            { label: "Phone", fieldName: "Mobile__c", type: "date" },
            { label: "Token", fieldName: "Token__c", type: "text" },
            { label: "Status Update Date", fieldName: "Status_Update_Date__c", type: "Date" }
        ]);
    },

    setLocationTable: function (component) {
        component.set("v.columns", [
            { label: "Name", fieldName: "Name", type: "text" },
            { label: "Health Status", fieldName: "Status__c", type: "text" },
            { label: "Pincode", fieldName: "Pincode__c", type: "date" },
            { label: "Address", fieldName: "Address__c", type: "text" },
            { label: "Red Score", fieldName: "Red_Score__c", type: "Number" },
            { label: "Status Update Date", fieldName: "Status_Update_Date__c", type: "Date" }
        ]);
    },

    search: function (component, queryTerm) {
        var scope = component.get("v.tableScope");
        var action = scope === "person" ? component.get("c.searchPeople") : component.get("c.searchLocation");
        action.setParams({ searchTerm: queryTerm });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var data = response.getReturnValue();
                console.log("data " + data);
                if (data && data.length > 0) {
                    component.set("v.data", response.getReturnValue());
                }
            }
        });
        $A.enqueueAction(action);
        component.set("v.isSearching", false);
    }
});
