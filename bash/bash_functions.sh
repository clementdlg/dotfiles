# change terminal font
termconf="~/.config/alacritty/alacritty.toml"
if [[ -f $termconf ]]; then
	termfont() { 

		# their must be only 1 arg
		if [[ $# -ne 1 ]]; then
			echo "termfont error : Invalid number of arguments. Expected 1, got '$#'"
			return
		fi

		# the argument must be between 10 and 99
		if [[ ! "$1" =~ ^[1-9][0-9]$ ]]; then
			echo "termfont error : Invalid font size. Expected a number betwen 10 and 99, got $1"
		fi

		sed -i -E "s/size = .{2}.0/size = $1.0/" ~/.config/alacritty/alacritty.toml
	}
fi

# display number of lines of code
lines() {
	# if no arguments, exit
	if [[ -z $1 ]]; then
		echo "Error: You must pass the file extension as argument"
		echo "Example : 'lines php'"
		return
	fi

	# find all files with matching extension
	files=$(find -not -path './.git/*' -name "*.$1" 2>/dev/null)

	# if no files, exit
	if [[ -z "$files" ]]; then
		echo "0 total"
		return
	else
		wc="$(wc -l $files)"
		pretty=$(echo "$wc" | sed 's|\./||' )
		echo "$pretty" | awk '{print "\033[1;36m" $1"\033[0m", $2}'
	fi
}

#######################
###		TMUX		###
#######################

# refresh tmux topbar
if [[ -n "$TMUX" ]]; then
	cd() {
		builtin cd "$@" && tmux refresh-client -S
	}

	z=$(which zoxide)
	if [[ -n "$z" ]]; then

		z() {
			__zoxide_z "$@" && tmux refresh-client -S
		}
	fi
fi

###################
###		FZF		###
###################

which fzf &>/dev/null
if [[ $? -ne 0 ]]; then
	return
fi
# work directories
wk() {
	prefix="$HOME/Desktop/2e-annee"
	cdz "$prefix"
}

# github
gh() {
	prefix="$HOME/github"
	cdz "$prefix"
}

viz() {
	dir1="$HOME/scripts" 
	dir2="$HOME/.config"

	list=$(find "$dir1" "$dir2" -maxdepth 4 -type f -not -path '*/.git*')
	edit=$(printf "%s\n" "$list" | sed 's|/home/krem/||')
	select=$(printf "%s\n" $edit | fzf --reverse --height 40%)

	if [[ -f "$HOME/$select" ]]; then
		$EDITOR $HOME/$select
	fi
	echo $EDITOR $HOME/$select
}
cdz() {
	if [[ ! -d "$1" ]]; then
		return
	fi

	list=$(find "$1" -maxdepth 2 -type d -not -path '*/.git*')
	edit=$(printf "%s\n" "$list" | sed 's|/home/krem/||')
	select=$(printf "%s\n" "$edit" | fzf --reverse --height 40%)

	if [[ -d "$HOME/$select" ]]; then
		id=$(($RANDOM % 100))
		name=$(basename $select)
		cd "$HOME/$select"
	fi
}
# better git log
gitgraph() {
	hash=$(git log \
		--color=always \
		--reverse \
		--oneline \
		--graph \
		--all \
		--format="%C(auto)%h %C(green)%cr %C(reset)%s" \
		--reverse |\
	fzf --no-multi \
		--ansi)

	git show --color=always $(echo $hash | grep -o '[a-f0-9]\{7\}')

}
gitlog() {
	git log \
		--color=always \
		--reverse \
		--oneline \
		--format="%C(auto)%h %C(reset)%s" \
		--reverse |\
	fzf --no-multi \
		--ansi \
		--preview="git show --color=always \$(echo {} | awk '{ print \$1 }')"
}

wgz() {
    path="/etc/wireguard"
    confs=$(sudo ls "$path")
    select=$(printf "%s\n" "$confs" |\
            sed 's/.conf//' |\
            fzf --no-multi \
                --reverse \
                --height 35%)
    sudo wg-quick up $select
}
