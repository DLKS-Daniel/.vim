if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('vscode-json-languageserver')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'json-lsp',
        \ 'cmd': {server_info->['vscode-json-languageserver', '--stdio']},
        \ 'whitelist': ['json'],
        \ })
endif

set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()


" Go to definition
nnoremap <silent> gd :LspDefinition<CR>

" Go to declaration
nnoremap <silent> gD :LspDeclaration<CR>

" Go to implementation
nnoremap <silent> gi :LspImplementation<CR>

" Go to type definition
nnoremap <silent> gT :LspTypeDefinition<CR>

" Show hover documentation
nnoremap <silent> K :LspHover<CR>

" Show signature help (if available)
nnoremap <silent> <C-k> :LspSignatureHelp<CR>

" List references
nnoremap <silent> gR :LspReferences<CR>

" Rename symbol
nnoremap <silent> grn :LspRename<CR>

" Format buffer
nnoremap <silent> gf :LspDocumentFormat<CR>

" Show diagnostics in a quickfix list
nnoremap <silent> <leader>q :LspDiagnostics<CR>

" Go to next diagnostic
nnoremap <silent> [d :LspPreviousDiagnostic<CR>

" Go to previous diagnostic
nnoremap <silent> ]d :LspNextDiagnostic<CR>

" Show code actions
nnoremap <silent> ga :LspCodeAction<CR>

" Show document symbols
nnoremap <silent> <leader>ls :LspDocumentSymbol<CR>

" Show workspace symbols
nnoremap <silent> <leader>lS :LspWorkspaceSymbol<CR>

" Restart LSP server
nnoremap <silent> <leader>lr :LspRestartServer<CR>
