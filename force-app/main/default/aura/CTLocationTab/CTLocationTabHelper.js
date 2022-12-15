({
    getLocationDetails: function (component) {
        var action = component.get("c.getLocationDetails");
        action.setParams({ recordId: component.get("v.recordId") });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();

                if (JSON.stringify(result) !== "{}") {
                    component.set("v.locationObj", result);
                    component.set("v.locationFound", true);
                } else {
                    this.showToast();
                }
            }
        });
        $A.enqueueAction(action);
    },

    setTable: function (component) {
        component.set("v.columns", [
            { label: "Name", fieldName: "Name", type: "text" },
            { label: "Token", fieldName: "Token", type: "text" },
            { label: "Visit date", fieldName: "visitDate", type: "date" },
            { label: "Status", fieldName: "healthStatus", type: "text" }
        ]);
    },

    showToast: function () {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: "Error!",
            message: "Could not find the record",
            type: "error"
        });
        toastEvent.fire();
    }
});
