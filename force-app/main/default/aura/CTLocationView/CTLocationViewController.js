({
    handleApplicationEvent: function (component, event, helper) {
        var recordId = event.getParam("recordId");
        var status = event.getParam("status");
        component.set("v.recordId", recordId);
        component.set("v.status", status);
    }
});
