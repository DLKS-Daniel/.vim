" ------------------------------
" LSP Server Setup
" ------------------------------

" Python LSP: install via `pip install python-lsp-server`
if executable('pylsp')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

" JSON LSP: install via `npm install -g vscode-langservers-extracted`
if executable('vscode-json-languageserver')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'json-lsp',
        \ 'cmd': {server_info->['vscode-json-languageserver', '--stdio']},
        \ 'whitelist': ['json'],
        \ })
endif

" ------------------------------
" Folding via LSP
" ------------------------------
set foldmethod=expr
set foldexpr=lsp#ui#vim#folding#foldexpr()
set foldtext=lsp#ui#vim#folding#foldtext()

" ------------------------------
" LSP Key Mappings
" ------------------------------
nnoremap <silent> gd   :LspDefinition<CR>
nnoremap <silent> gD   :LspDeclaration<CR>
nnoremap <silent> gi   :LspImplementation<CR>
nnoremap <silent> gT   :LspTypeDefinition<CR>
nnoremap <silent> K    :LspHover<CR>
nnoremap <silent> <C-k> :LspSignatureHelp<CR>
nnoremap <silent> gR   :LspReferences<CR>
nnoremap <silent> grn  :LspRename<CR>
nnoremap <silent> gf   :LspDocumentFormat<CR>
nnoremap <silent> ga   :LspCodeAction<CR>

" Optional (commented out)
" nnoremap <silent> <leader>ls :LspDocumentSymbol<CR>
" nnoremap <silent> <leader>lS :LspWorkspaceSymbol<CR>
" nnoremap <silent> <leader>lr :LspRestartServer<CR>
