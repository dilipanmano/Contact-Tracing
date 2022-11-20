({
    startGame: function (component, event, helper) {
        var gameModeComboBox = component.find("gameMode");
        var gameMode = gameModeComboBox.get("v.value");
        component.set("v.selectedMode", gameMode);
    },

    reshuffleBoard: function (component, event, helper) {
        console.log("Reshuffle Board");
    }
});
