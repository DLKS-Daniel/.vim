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
