# nothing bad will happen

a fun little way to remind your loved ones to always read scripts before blindly piping them into bash.

this script is an educational tool that *appears to be* a simple malicious attack, but will not cause any actual damage.

- displays a growing list of 'deleted' files starting from the filesystem root
- claims to be running 'rm -rf /' as root (this is not the case)
- introduces random jitter to increase believability
- blocks attempts to SIGTERM and SIGINT in a fun way
