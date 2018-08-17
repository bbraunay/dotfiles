" Python with pipenv support
let g:python_version = matchstr(system("python --version | cut -f2 -d' '"), '^[0-9]')
let pipenv_venv_path = system('pipenv --venv')
if shell_error == 0
  let venv_path = subtitute(pipenv_venv_path, '\n', '', '')
  if python_version =~ 3
    let g:python3_host_prog = venv_path . '/bin/python3'
  else
    let g:python_host_prog = venv_path . '/bin/python3'
  endif
else
  if python_version =~ 3
    let g:python3_host_prog = 'python3'
  else
    let g:python_host_prog = 'python'
  endif
endif
