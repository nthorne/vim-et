vim-et
===========

A simple templating system, that uses eval in order to be able to generate
dynamic contents.


installation
------------
Preferred way of installing this plugin (as with any other script) is by 
installing it as a git submodule, and loading it with pathogen (for pathogen
installation instructions, please refer to https://github.com/tpope/vim-pathogen
or http://www.vim.org/scripts/script.php?script\_id=2332). When you have
pathogen installed, installing et is as simple as:

    git clone git://github.com/nthorne/vim-et.git bundle/et

usage
-----
    :ET <template>

Where <template> is a template file found within g:etTemplatePath(defaults to
`~/.vim/templates`). The contents of the current buffer will be replaced with
the contents of the template file, and any text in between `{{` and `}}` within
the template file will be passed to `eval()`, substituting the markers for eval's
output.

license
-------
Copyright (C) 2015 Niklas Thörne. This plugin is distributed under the
GNU General Public License version 3.
