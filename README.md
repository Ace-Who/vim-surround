# vim-surround

## Usage

- `<leader>[]` - in Normal mode or any Visual mode calls the surround function
that request 2 characters as surrounding pair, which defaults to `()`. `[count]`
pairs are nestedly added.
When the second character is omitted, it is set to the first one.
In Visual mode linewise, the surroundings are added with newlines.  

- `<leader>d[]` - deletes `[count]` nested surrounding pairs.
If less than `[count]` characters are present on left or right hand side,
   deletes them anyway.
Only works in Normal mode and Visual mode characterwise.

In Normal mode, the surrounded object is the word under the cursor.

Handles multibyte characters properly.
