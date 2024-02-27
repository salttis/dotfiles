echo_colored() { echo -e "${2}$1\033[0m"; }
echo_info()    { echo_colored "==> $1" "\033[1;36m"; }
echo_warn()    { echo_colored "==> $1" "\033[1;33m"; }
fail()         { echo_colored "$1" "\033[1;31m"; exit 1; }