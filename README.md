# vim-surround

## Usage

- `<leader>[]` : Requests 2 characters to be added as surrounding pair, which
defaults to `()`.
`[count]` pairs are nestedly added.
When the second character is omitted, it is set to the first one.
Works in Normal mode and all Visual modes.
In Visual mode linewise, the surroundings are added with newlines.  

- `<leader>d[]` : In Normal mode or Visual mode characterwise, deletes `[count]` surrounding characters on each side.
If less than `[count]` characters are present on left or right hand side,
   deletes them anyway.
In Visual mode linewise, deletes `[count]` lines above and below the selected
area.

In Normal mode, the surrounded object is the word under the cursor.
