# KREM's dotfiles
## Vim automated setup
- This configuration is :
    - without external plugins
    - without external dependencies
    - only 200 lignes of simple code
- This allow to setup a minimal yet powerful environement for project wide editing and navigation
- You are provided with 2 automated methods to have Vim setup for you

### 1- Total independance
- This setup only creates a .vimrc and you are good to go
```
wget -O ~/.vimrc https://raw.githubusercontent.com/0xKrem/dotfiles/master/vimrc_merged
```

### 2- Independance + Bonus
- This setup create a `.vim/`, come with an external theme and an 'undo.d' directory to enable the support of persistant undo
```
wget -q -O- https://raw.githubusercontent.com/0xKrem/scripts/master/vim_install.sh | sudo bash
```

