
if [ -r $HOME/.profile ]; then
	. $HOME/.profile
fi

PS1='\h:\W \$ '

function dirs() {
	command dirs -v $@
}

function pushd() {
	command pushd $@ >/dev/null ; dirs
}

function popd() {
	command popd $@ >/dev/null; dirs
}

function openman() {
	open x-man-page://$@
}

function calc() {
	echo "$@" | bc -lq
}
