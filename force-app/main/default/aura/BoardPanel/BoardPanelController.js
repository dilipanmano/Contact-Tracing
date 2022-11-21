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
        console.log("Reshuffle Board");
    }
});
