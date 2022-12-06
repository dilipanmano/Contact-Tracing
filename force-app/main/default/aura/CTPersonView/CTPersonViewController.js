({
    handleApplicationEvent: function (component, event, helper) {
        var recordId = event.getParam("recordId");
        var status = event.getParam("status");
        component.set("v.recordId", recordId);
        component.set("v.status", status);
    },

    updateStatus: function (component) {
        var recId = component.get("v.recordId");
        var action = component.get("c.changeStatusToRed");
        action.setParams({ personId: recId });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.status", "Red");
            }
        });
        $A.enqueueAction(action);
    }
});
