set ru
set number
syntax enable
set mouse=a
set tabstop=2
set shiftwidth=2
set fileformat=unix
set nobackup
set nowritebackup
set noswapfile
set history=100
set noruler
set hlsearch
set incsearch
set ignorecase smartcase
set hidden
set nowrap
set backspace=indent,eol,start
set fillchars=stl:-     " fill active window's statusline with -
set fillchars+=stlnc:-  " also fill inactive windows
set fillchars+=vert:• " add a bar for vertical splits
set fillchars+=fold:-
set listchars=tab:▹\ ,trail:•,nbsp:⚋,extends:»,precedes:«
set list
set expandtab
set tabstop=2
set shiftwidth=2
set encoding=utf-8 nobomb
set autoread
set clipboard=unnamed
set splitbelow
set splitright
set wildmenu
set signcolumn=yes
set scrolloff=5
set sidescrolloff=7
set sidescroll=1
set showmatch
set showmode
set laststatus=2
set wildchar=<TAB>
set wildmode=list:longest
set wildignore+=*.DS_STORE,*.db
set diffopt=filler
set diffopt+=iwhite
set noerrorbells
set novisualbell
set nostartofline
set autoindent smartindent
set copyindent
set smarttab
set textwidth=120
set pastetoggle=<leader>p
set relativenumber
set numberwidth=5
set shortmess+=c
set cmdheight=2

let mapleader=','
nmap <leader>z :u<CR>
nmap <leader>Q :qa!<CR>
nmap <leader>q :bw<CR>

call plug#begin()
Plug 'morhetz/gruvbox' "https://github.com/morhetz/gruvbox
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'sk1418/QFGrep'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-dispatch'
Plug 'janko-m/vim-test'
Plug 'janko/vim-test'
Plug 'mhinz/vim-grepper'
Plug 'ericpruitt/tmux.vim'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
Plug 'dense-analysis/ale'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-cucumber'
Plug 'majutsushi/tagbar'
Plug 'pangloss/vim-javascript'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'ap/vim-css-color'
Plug 'kchmck/vim-coffee-script'
Plug 'tbastos/vim-lua'
Plug 'mattn/emmet-vim'
Plug 'slim-template/vim-slim'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
call plug#end()

nnoremap <leader>/ :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

lua << EOF
require'lspconfig'.solargraph.setup{}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "solargraph" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
}
end
EOF

lua << EOF
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = false;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

set termguicolors
set background=dark
colorscheme gruvbox

" WINDOWS NAVIGATION {{{
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-j> <C-w>j
" }}}

" ELITE MODE {{{
let g:elite_mode = 1
function! EliteKey()
  nnoremap <Up> :resize -2<CR>
  nnoremap <Down> :resize +2<CR>
  nnoremap <Left> :vertical resize +3<CR>
  nnoremap <Right> :vertical resize -3<CR>
endfunction

if get(g:, 'elite_mode')
  :call EliteKey()
endif
" }}}

" FORMATING {{{
map <F7> <Esc>mzgg=G`z
nnoremap ,, <ESC>:noh<CR>
" }}}

" ALE {{{
let g:ale_linters_ignore = {
\ 'ruby': ['brakeman', 'cspell', 'debride', 'rails_best_practices', 'reek', 'rubocop', 'ruby', 'solargraph', 'sorbet', 'standardrb'],
\ }

let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'javascript': ['eslint'],
\ 'javascriptreact': ['eslint'],
\ 'ruby': ['rubocop'],
\ 'css': ['prettier'],
\ 'scss': ['prettier'],
\}
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⭕'
let g:ale_fix_on_save = 1
hi ALEWarningSign ctermfg=blue
hi ALEErrorSign ctermfg=red
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)

" FZF {{{
  nnoremap <C-p> :<C-u>Files<CR>
  nnoremap <C-f> :<C-u>Rg<CR>
  nnoremap ,e :<C-u>RG<CR>
  nnoremap ,a :<C-u>:Buffers<CR>
" }}}
nmap <silent> ]W <Plug>(ale_last)

" MAPPING {{{
map <Leader>o <C-w>s
map <Leader>e <C-w>v
cmap w!! %!sudo tee > /dev/null %
nnoremap ,q :bdelete<CR>
nnoremap ,w :update<CR>
nnoremap ,l :g/describe\\|scenario\\|context\\|it\ \"/#<CR>
nnoremap <F12> :TagbarToggle<CR>
" }}}

" GIT {{{
map <F9> <Esc>:Gblame<CR>
" }}}

" VIM-TEST {{{
let test#strategy = "dispatch"
let test#ruby#use_spring_binstub=1
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-l> :TestLast<CR>
"}}}

" NERDTREE {{{
let NERDRemoveExtraSpace=1
let NERDSpaceDelims=1
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer=1
let g:NERDTreeNodeDelimiter = "\u00a0"
let NERDTreeIgnore = ['\~$', 'tmp[[dir]]', 'node_modules[[dir]]', 'tags[[file]]', '.DS_STORE[[dir]]', 'BGAppTest[[dir]]', 'codesign[[dir]]', 'jenkins-build[[dir]]', 'nexus-links[[dir]]', 'tools[[dir]]', '.git[[dir]]']
nnoremap ,m :NERDTreeFind<CR>
nnoremap ,n :NERDTreeToggle<CR>

augroup nerdtreedisablecursorline
  autocmd!
  autocmd FileType nerdtree setlocal nocursorline
augroup end
"}}}

" VIM-GREPPER {{{
let g:grepper = {}
let g:grepper.tools = ['rg']
let g:grepper.stop = 20000

nnoremap <C-g> :Grepper -cword -noprompt<CR>
nnoremap ,f :Grepper -tool rg -grepprg rg --column --line-number -H --vimgrep<CR>
