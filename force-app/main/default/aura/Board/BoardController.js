({
    doInit: function (component, event, helper) {
        var gameMode = component.get("v.mode");
        console.log(gameMode);
        var wordsNeeded = 0;
        if (gameMode === "Hard") {
            wordsNeeded = 6;
        } else if (gameMode === "Medium") {
            wordsNeeded = 4;
        } else {
            wordsNeeded = 3;
        }
        var words = helper.getWords(wordsNeeded);
        component.set("v.words", words);
        var columnSize = 12 / wordsNeeded;
        component.set("v.blockSize", columnSize);
        var winWord = helper.getWinWord(words);
        component.set("v.winWord", winWord);
        console.log(words);
        console.log(helper.getWinWord(words));
    },

    doRender: function (component, event, helper) {
        console.log("doRender");
    }
});
