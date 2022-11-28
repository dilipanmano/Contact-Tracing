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
        helper.resetBoard(component);
    },

    doRender: function (component, event, helper) {
        console.log("doRender");
    },

    blockClickHandler: function (component, event, helper) {
        var label = event.getParam("value");
        var count = component.get("v.count") + 1;
        component.set("v.count", count);
        var winWord = component.get("v.winWord");
        if (winWord === label) {
            component.set("v.result", "You Win");
            console.log("You win");
            helper.disableBoard(component);
            helper.fireResultEvent("win");
        } else if (count === 3) {
            component.set("v.result", "You Lose");
            console.log("You lose");
            helper.disableBoard(component);
            helper.fireResultEvent("lose");
        }
    },

    reshuffleBoard: function (component, event, helper) {
        //Method defination goes here
        var words = component.get("v.words");
        words = helper.randomize(words);
        component.set("v.words", words);
        helper.resetBoard();
    }
});
