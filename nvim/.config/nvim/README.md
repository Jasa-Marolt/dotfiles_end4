:TSInstall cpp -> installs tresitter parser for c++

gx -> opens the link in browser, set default browser with 
        xdg-mime default firefox.desktop 'x-scheme-handler/http'
        xdg-mime default firefox.desktop 'x-scheme-handler/https'


f+[enter, backspace] -> highlighter

space+sk -> search keybinds

ysiw" adds quotes around iw
cs[} change curround
ds"iw delete surround intire work

visually select -> S -> { or " or ' or (
visually select -> S -> t -> name of htmp tag 

S -> flash to important parts of the tresitter


<leader> -> r -> refactor


# Activate the venv
source ~/.virtualenvs/neovim/bin/activate.fish
echo $VIRTUAL_ENV  # Should show: /home/thewanderer/.virtualenvs/neovim
uv pip install matplotlib numpy pandas   #these are the packages for nvim molten
deactivate


# this is the project setup
source .venv/bin/activate.fish
pip install ipykernel
python -m ipykernel install --user --name project_name


# To run .ipynb
//run this on main terminal before opening nvim
source .venv/bin/activate.fish
nvim test.ipynb
<leader>m i  or :MoltenInit python3

# Remote plugins update
like molten
run :UpdateRemotePlugins

# py to notebook
 open env with the jupytext
 jupytext --to notebook file.py
 or jupytext --to py notebook.ipynb



