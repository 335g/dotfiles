
let g:quickrun_config = get(g: 'quickrun_config', {})
let g:quickrun_config._ = {
    \ 'runner'                          : 'vimproc',
    \ 'runner/vimproc/updatetime'       : 60,
    \ 'outputter'                       : 'error',
    \ 'outputter/error/success'         : 'buffer',
    \ 'outputter/error/error'           : 'quickfix',
    \ 'outputter/buffer/split'          : ':botright 8sp',
    \ 'outputter/buffer/close_on_empty' : 1,
    \ }


