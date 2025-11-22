#! /bin/bash

# ...and that's why you always read scripts before piping them to bash

# by izosozi
# https://github.com/izosozi/nothingbadwillhappen

DELAY_MS=100;
DAMPENER=20;
TARGET_DIR=/;

setup_test () {

	TEST_DIR="$HOME/nothingbadwillhappen"

	if [ ! -d $TEST_DIR ]
	then
		mkdir $TEST_DIR;
	fi

	touch $TEST_DIR/file1;
	touch $TEST_DIR/file2;

	TARGET_DIR=$TEST_DIR
}


print_loop () {

count=0
tput smcup
tput clear
tput civis

while IFS= read -r -d '' file; do
	t=$(shuf -i 0-$DELAY_MS -n1)
	u=$(shuf -i 1-$DAMPENER -n1)
	sleep $(echo "scale=2;($t/1000)/$u" | bc)

	count=$((count + 1))

	tput cup $(($(tput lines) - 2)) 0
	tput el
	printf "Deleted $file"

	tput cup $(($(tput lines) - 1)) 0
	tput el
	tput cup $(tput lines) 0
	tput smso
	printf "\nRunning 'rm -rf $TARGET_DIR' as root --- $count files deleted"
	tput rmso
done < <(find "$TARGET_DIR" -mindepth 4 -print0 2>/dev/null)

# handle_exit_debug
	handle_exit
}

handle_exit_debug () {
	tput rmcup
	tput cnorm
	exit 0
}

quits=0

handle_exit () {
	quits=$((quits + 1))
	tput setab $((quits % 7))
}

stty -echo
trap 'handle_exit' SIGINT
trap 'handle_exit' TERM

# setup_test
print_loop

