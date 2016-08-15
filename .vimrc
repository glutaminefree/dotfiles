source ~/.vimrc-neobundle
source ~/.vimrc-tabline

" My conf {
    " emmet {
        let g:user_emmet_leader_key='<C-E>'
    " }
    " delimMate {
        let delimitMate_expand_cr = 1
    " }
    " NeoSnippet {
        let g:neosnippet#snippets_directory='~/.vim/snippets'
        let g:neosnippet#disable_runtime_snippets = {'_':1,}
    " }
    " NerdTree {
        let NERDTreeShowHidden = 1
        "autocmd vimenter * NERDTree
    " }
    " MatchTagAlways {
        let g:mta_filetypes = {'html':1,'php':1,'xhtml':1,'xml':1,}
    " }
    " Airline {
        let g:airline_extensions = ['branch']
        let g:airline_powerline_fonts = 1
    " }
    " PDV {
        let g:pdv_template_dir = '/home/glutaminefree/.vim/bundle/pdv/templates'
    " }
    " TagList {
        let Tlist_Auto_Highlight_Tag      = 0
        let Tlist_Close_On_Select         = 1
        let Tlist_Use_Right_Window        = 1
        let Tlist_GainFocus_On_ToggleOpen = 1
        let Tlist_Exit_OnlyWindow         = 1
        "let Tlist_File_Fold_Auto_Close    = 1
        let Tlist_Show_One_File           = 1
    " }

    " Colorsheme {
        syntax enable
        colorscheme solarized
        let g:solarized_termcolors=256
        set background=light
        "syntax enable
        "colorscheme monokai
    " }

    " Aliases {
        cmap w!! w !sudo tee % >/dev/null
    " }

    " Other settings {
        set guioptions+=c
        set guioptions-=T
        set guioptions-=m
        set guioptions-=r
        set guioptions-=b
        set guioptions-=R
        set guioptions-=L
        set guioptions-=e
        set guioptions-=F
        set guifont=Monofur\ for\ Powerline\ 12

        set number " Show line numbers
        set nowrap " Disable text wrap
        set showtabline=2
        set autochdir
        set encoding=utf-8
        set fileencodings=utf-8,cp1251,koi8-r,cp866
        set termencoding=utf-8
        set ignorecase " Ignore case when searching
        set smartcase " Ignore prev options if search for different case symbols
        set backupdir=/home/glutaminefree/.vim/tmp,/tmp
        set directory=/home/glutaminefree/.vim/tmp,/tmp
        set omnifunc=syntaxcomplete#Complete " Omni completion
        set completeopt-=preview " No preview on omni completion
        set laststatus=2 " Always show statusbar
        set noshowmode

        set expandtab
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        set smarttab
        set smartindent
        set autoindent

        " Code folding {
        set foldmethod=indent
        set foldnestmax=10
        set nofoldenable
        set foldlevel=1
        " }

        " Save/Restore buffers {
        au BufWinLeave *.* silent mkview " Save buffer view on buffer close
        au BufWinEnter *.* silent loadview " Restore buffer view on buffer opening
        " }

        " Netrw {
        let g:netrw_liststyle=3
        " }
    " }

    " Shortcuts {
        nnoremap <Leader>y "+y
        vnoremap <Leader>y "+y
        nnoremap <Leader>p "+p

        nnoremap <Leader>h :set ft=html<CR>
        nnoremap <Leader>p :set ft=php<CR>

        inoremap <C-j> <Esc>
        vnoremap <C-j> <Esc>
        nnoremap <C-j> <Esc>

        inoremap <C-p> <C-r>"

        vnoremap <C-E> nooperator

        nnoremap <F1> :TlistToggle<CR>
        inoremap <F1> <Esc>
        vnoremap <F1> <Esc>

        nnoremap  <F2> :NERDTreeTabsToggle<CR>
        nnoremap  <F3> :let @+ = expand("%:p")<CR> " Copy filename to clipboard
        set pastetoggle=<F4>
        nnoremap  <F5> :call pdv#DocumentCurrentLine()<CR>
        vnoremap  <F6> :Tabularize /=><CR>
        nnoremap  <F7> /\s\+$<CR> " Highlight trailing spaces
        nnoremap  <F8> :!php -l %<CR>
        nnoremap  <F9> :!php %<CR>
        nnoremap <F10> :%!python -m json.tool<CR>

        imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    " }
" }
