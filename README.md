# vim-surround

## Usage

`<leader>[]` in Normal mode or any Visual mode calls the surround function that
request 2 characters as surrounding pair, which defaults to `()`. `[count]`
pairs are nestedly added.

When the second character is omitted, it is set to the first one.

In Normal mode, the word under the cursor is to be surrounded.
In Visual mode linewise, the surroundings are put with preceding newlines.  
