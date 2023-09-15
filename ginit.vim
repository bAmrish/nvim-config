if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont! {Fira Code}:h{16}
endif
:set guifont=Fira\ Code:h16


" Apparently this only works on Macwim. `D` identifes the 'Command' key
" vim.keymap.set('', '<D-s>', '<cmd>write<cr>', {desc= '[s]ave file.'})

noremap <D-s> :wa<CR> \| :echom 'Saved All'<CR>
