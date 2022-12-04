({
    getHealthStatusCount: function (component, event, helper) {
        var scope = component.get("v.scope");
        var actionName = scope === "person" ? "c.getPersonHealthStatusCount" : "c.getLocationHealthStatusCount";
        var action = component.get(actionName);
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue());
                component.set("v.count", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
});
