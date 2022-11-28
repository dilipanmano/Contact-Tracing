({
    startGame: function (component, event, helper) {
        var gameModeComboBox = component.find("gameMode");
        var gameMode = gameModeComboBox.get("v.value");
        var selectedMode = component.get("v.selectedMode");
        component.set("v.selectedMode", gameMode);
        if (selectedMode) {
            var childComponent = component.find("boardComp");
            childComponent.startGame();
        }
    },

    reshuffleBoard: function (component, event, helper) {
        var childComponent = component.find("boardComp");
        childComponent.reshuffle();
        component.set("v.disableReshuffle", true);
    },

    resultHandler: function (component, event, helper) {
        console.log("hasdhfhasfd");
        var result = event.getParam("result");
        if (result === "win") {
            component.set("v.disableReshuffle", true);
        } else {
            component.set("v.disableReshuffle", false);
        }
    }
});
