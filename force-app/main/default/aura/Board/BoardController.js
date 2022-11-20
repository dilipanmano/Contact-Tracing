({
    doInit: function (component, event, helper) {
        var words = helper.getWords(5);
        var winWord = helper.getWinWord(words);
        component.set("v.words", words);
        component.set("v.winWord", winWord);
        console.log(words);
        console.log(helper.getWinWord(words));
    },

    doRender: function (component, event, helper) {
        console.log("doRender");
    }
});
