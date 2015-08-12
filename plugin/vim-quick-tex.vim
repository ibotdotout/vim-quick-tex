" pdflatex function
" au BufWritePost *.tex silent call RunPdfLaTex()
nnoremap <leader>ll :call RunPdfLaTex()<CR>
nnoremap <leader>lp :call CompilePdfLaTex()<CR>
nnoremap <leader>l; :call RunPdfLaTexBibTex()<CR>
nnoremap <leader>lo :call OpenPdfLaTex()<CR>
nnoremap <leader>lk :call OpenPdfLaTexLog()<CR>

function OpenPdfLaTexLog()
    silent execute "rightbelow split %:p:r.log"
    redraw!
endfunction

function OpenPdfLaTex()
    silent execute "silent !open %:p:r.pdf  &"
    redraw!
endfunction

function CompilePdfLaTex()
    let latex = system("pdflatex ".expand("%"))
    if v:shell_error
      echom "pdflatex compile failed"
    else
      echom "pdflatex compiled"
    endif
endfunction

function CompileBibTex()
    let latex = system("bibtex ".expand("%:r"))
    if v:shell_error
      echom "bibtex compile failed"
    else
      echom "bibtex compiled"
    endif
endfunction

function RunPdfLaTex()
    call CompilePdfLaTex() "pdf
    if !v:shell_error
      call OpenPdfLaTex() "open
    endif
endfunction

function RunPdfLaTexBibTex()
  call CompilePdfLaTex() "pdf
  if !v:shell_error
    call CompileBibTex() "bib
    if !v:shell_error
      call CompilePdfLaTex() "pdf
      if !v:shell_error
        call CompilePdfLaTex() "pdf
        if !v:shell_error
          call OpenPdfLaTex() "open
        endif
      endif
    endif
  endif
endfunction
