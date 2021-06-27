# Vim commentary tutorial

Comment and uncomment files quickly and easily in Vim. This works for all file types and is very useful for wrap comment in XML file. See [Git repo](https://github.com/tpope/vim-commentary)

## Installation

```bash
# type these in the command line
mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start
git clone https://tpope.io/vim/commentary.git
vim -u NONE -c "helptags commentary/doc" -c q
```

## Customization

- set comment string. 

```bash
# identify filetype
vi example.xml
# within vim, type the following to determine current file type
:set filetype?
# to see all available filetypes
:setfiletype (with a *space* afterwards, then press `Ctrl+d`) 
# within vim, type the following to determine current commentstring
:set commentstring?
# set commentstring for given filetype
:set commentstring=<!--%s-->

# alternatively add the following to ~/.vimrc. 
autocmd FileType xml,html setlocal commentstring=<!--%s--> # here %s is the content wrapped by comment strings
autocmd FileType sh,python,text setlocal commentstring=#%s
```

- map keys

```bash
# add following in ~/.vimrc
noremap <leader>/ :Commentary<cr>
```

Here `<leader>` is mapped to back slash `\` by default. You can set to other key using `:let mapleader = ","` for example. 

## Comment and Uncomment

- With mapped keys. It depends how the hotkey is set up. For example,

```bash
# add following in ~/.vimrc
noremap <leader>/ :Commentary<cr>
# to comment and uncomment
\/
```

- Without mapped keys

  - Native

    ```bash
    # to comment and uncomment
    :Commentary
	  # comment a range of lines
	  :10,20Commentary
	  ```
	  
	- *vim-commentary* specifics
	
	  ```bash
	  # comment out a line
	  gcc 
	  # comment out a paragraph
	  gcap 
	  # comment out a tag
	  gcat 
	  # comment on a visual selection
	  gc
	  # to uncomment. This also works for all adjacent lines
	  gcgc
	  ```
	
	  