({
    blockClickHandler: function (component, event, helper) {
        var blockOpen = component.get("v.open");
        if (!blockOpen) {
            component.set("v.open", true);
            var label = component.get("v.label");
            var blockEvent = component.getEvent("blockClick");
            blockEvent.setParams({ value: label });
            blockEvent.fire();
        }
    },

    scriptsLoaded: function (component, event, helper) {
        const divElement = component.getElement(".blockProps");
        fitText(divElement);
    }
});
