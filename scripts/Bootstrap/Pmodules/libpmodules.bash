#!/bin/bash

log() {
        local -ri fd=$1
        local -r fmt="$2\n"
        shift 2
        printf -- "$fmt" "$@" >> /dev/fd/$fd
}

info() {
        log 2 "$1\n" "${@:2}"
}

error() {
        log 2 "$1\n" "${@:2}"
}

debug() {
        [[ ${PSI_DEBUG} ]] || return 0
        log 2 "$@"
}

die() {
        local -ri ec=$1
        shift
        local cout
        if (( ec == 0)); then
                cout='1'
        else
                cout='2'
        fi
        if [[ -n $@ ]]; then
                local -r fmt=$1
                shift
                log $cout "$fmt" "$@"
        fi
        exit $ec
}

#
# get answer to yes/no question
#
# $1: prompt
#
get_YN_answer() {
	local -r prompt="$1"
	local ans
	read -p "${prompt}" ans
	case ${ans} in
		y|Y )
			return 0;;
		* )
			return 1;;
	esac
}

get_options() {
	"${bindir}/getopt" "$@"
}

check_pmodules_env_vars() {
	[[ -n "${PSI_PREFIX}" ]] &&
	    [[ -n "${PSI_CONFIG_DIR}" ]] &&
	    [[ -n "${PSI_MODULES_ROOT}" ]] &&
	    [[ -n "${PSI_TEMPLATES_DIR}" ]] &&
	    [[ -n "${PMODULES_HOME}" ]] &&
	    [[ -n "${PMODULES_VERSION}" ]] || die 1 "
Error: the module environment you are going to use as source has not been
initialized properly!"
}

check_pmodules_directories() {
	local -r src_prefix="$1"
	[[ -d "${src_prefix}" ]] &&
	    [[ -d "${src_prefix}/${PSI_CONFIG_DIR}" ]] &&
	    [[ -d "${src_prefix}/${PSI_MODULES_ROOT}" ]] &&
	    [[ -d "${src_prefix}/${PSI_TEMPLATES_DIR}" ]] &&
	    [[ -d "${src_prefix}/Tools/Pmodules/${PMODULES_VERSION}" ]] || die 1 "
Error: the module environment '${src_prefix}' has not been initialized properly!"
}

check_pmodules_env() {
	check_pmodules_env_vars
	check_pmodules_directories "${PSI_PREFIX}"
}


# Local Variables:
# mode: sh
# sh-basic-offset: 8
# tab-width: 8
# End:
