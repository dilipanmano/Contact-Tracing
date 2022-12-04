({
    createRecord: function (component, event, helper) {
        var currentScope = component.get("v.scope");
        if (currentScope === "person") {
            var currentObject = "Person__c";
        } else if (currentScope === "location") {
            var currentObject = "Location__c";
        }
        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            entityApiName: currentObject
        });
        createRecordEvent.fire();
    }
});
