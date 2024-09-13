" Signify.
" Disable VCS systems I don't use.
let g:signify_skip = {
      \  'vcs': {
      \    'allow': [
      \      'git',
      \      'hg',
      \      'perforce',
      \    ],
      \  }
      \}
