({
    getUserDetails: function (component) {
        var action = component.get("c.getUserDetails");
        action.setParams({ recordId: component.get("v.recordId") });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();

                if (JSON.stringify(result) !== "{}") {
                    component.set("v.personObj", result);
                    component.set("v.userFound", true);
                } else {
                    this.showToast();
                }
            }
        });
        $A.enqueueAction(action);
    },

    setTable: function (component) {
        component.set("v.columns", [
            { label: "Id", fieldName: "Id", type: "text" },
            { label: "Token", fieldName: "token", type: "text" },
            { label: "Contact date", fieldName: "contactDate", type: "date" },
            { label: "Status", fieldName: "status", type: "text" }
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
