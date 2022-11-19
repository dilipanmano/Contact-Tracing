({
    startGame: function (component, event, helper) {
        let gameModeComboBox = component.find("gameMode");
        let gameMode = gameModeComboBox.get("v.value");
        component.set("v.selectedMode", gameMode);
    },

    reshuffleBoard: function (component, event, helper) {
        console.log("Reshuffle Board");
    }
});
