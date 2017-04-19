# vim-surround

## Usage

- `<leader>[]` : Requests 2 characters to be added as surrounding pair, which
defaults to `()`.
`[count]` pairs are nestedly added.
When the second character is omitted, it is set to the first one.
Works in Normal mode and all Visual modes.
In Visual mode linewise, the surroundings are added with newlines.  

- `<leader>d[]` : Deletes `[count]` nested surrounding pairs.
If less than `[count]` characters are present on left or right hand side,
   deletes them anyway.
Works in Normal mode and Visual mode characterwise.

In Normal mode, the surrounded object is the word under the cursor.
