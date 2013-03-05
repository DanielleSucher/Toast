Toast isn't very playable as a game, but I had to implement it before I could figure that out. Oh well! Game design is harder than programming.

Toast is inspired by the game French Toast, the game where one person thinks of an object and the other players take turns asking "Is it more like X or more like Y?" (where French toast is always the initial reference object, and the latest guess is always compared to the previous best guess).

Your phone is thinking of a word, and you're trying to guess what it is. The only feedback you get is whether the word is more like your latest guess, or more like the previous best guess.

How much one word is like another is based on [Levenshtein distance](https://en.wikipedia.org/wiki/Levenshtein_distance), which counts the number of edits (i.e. addition, deletion, substitution) needed to transform one word into another.


