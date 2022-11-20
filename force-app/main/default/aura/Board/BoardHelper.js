({
    getWords: function (count) {
        if (count > 100) return;
        var words = [
            "married",
            "enthusiastic",
            "real",
            "oatmeal",
            "hose",
            "act",
            "amount",
            "contain",
            "pine",
            "symptomatic",
            "exist",
            "punch",
            "harass",
            "learn",
            "ruthless",
            "queen",
            "drag",
            "nod",
            "sneaky",
            "irate",
            "brawny",
            "care",
            "night",
            "fancy",
            "grade",
            "tail",
            "hurried",
            "laborer",
            "one",
            "houses",
            "peel",
            "fumbling",
            "book",
            "frail",
            "frightened",
            "receipt",
            "alleged",
            "voice",
            "loose",
            "hard-to-find",
            "blush",
            "unit",
            "ablaze",
            "songs",
            "puny",
            "sticks",
            "rustic",
            "invent",
            "well-groomed",
            "uncovered",
            "tender",
            "bury",
            "geese",
            "writer",
            "cart",
            "credit",
            "window",
            "harsh",
            "plantation",
            "peaceful",
            "rush",
            "bath",
            "snails",
            "adaptable",
            "wistful",
            "supply",
            "cattle",
            "grandiose",
            "fang",
            "save",
            "brake",
            "discreet",
            "pointless",
            "chalk",
            "baseball",
            "flame",
            "impartial",
            "doll",
            "infamous",
            "dream",
            "cure",
            "overt",
            "handsome",
            "hilarious",
            "strengthen",
            "bite",
            "design",
            "crowded",
            "school",
            "high-pitched",
            "rightful",
            "old-fashioned",
            "better",
            "follow",
            "push",
            "cheese",
            "seed",
            "word",
            "addicted",
            "spotted"
        ];

        words = this.randomize(words);
        return words.slice(0, count * count);
    },
    randomize: function (array) {
        var currentIndex = array.length,
            randomIndex;

        // While there remain elements to shuffle.
        while (currentIndex != 0) {
            // Pick a remaining element.
            randomIndex = Math.floor(Math.random() * currentIndex);
            currentIndex--;

            // And swap it with the current element.
            [array[currentIndex], array[randomIndex]] = [array[randomIndex], array[currentIndex]];
        }

        return array;
    },

    getWinWord: function (arr) {
        var randomIndex = Math.floor(Math.random() * arr.length);
        return arr[randomIndex];
    }
});
