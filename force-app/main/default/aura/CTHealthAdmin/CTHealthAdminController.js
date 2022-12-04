({
    tabsSelected: function (component, event, helper) {
        var tabSelected = event.getParam("id");
        if (tabSelected === "person") {
            component.set("v.view", "Person View");
        } else {
            component.set("v.view", "Location View");
        }
        component.set("v.scope", tabSelected);
        var childComponent = component.find("header-component");
        childComponent.childGetHealthStatus();
    }
});
