#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)
# version: 0.5.0-alpha
array_find__0_v0() {
    local array=("${!1}")
    local value=$2
    index_10=0;
    for element_9 in "${array[@]}"; do
        if [ "$([ "_${value}" != "_${element_9}" ]; echo $?)" != 0 ]; then
            ret_array_find0_v0="${index_10}"
            return 0
        fi
        (( index_10++ )) || true
    done
    ret_array_find0_v0=-1
    return 0
}

array_contains__2_v0() {
    local array=("${!1}")
    local value=$2
    array_find__0_v0 array[@] "${value}"
    result_11="${ret_array_find0_v0}"
    ret_array_contains2_v0="$(( ${result_11} >= 0 ))"
    return 0
}

# We cannot import `bash_version` from `env.ab` because it imports `text.ab` making a circular dependency.
# This is a workaround to avoid that issue and the import system should be improved in the future.
bash_version__11_v0() {
    major_18="$(echo "${BASH_VERSINFO[0]}")"
    minor_19="$(echo "${BASH_VERSINFO[1]}")"
    patch_20="$(echo "${BASH_VERSINFO[2]}")"
    ret_bash_version11_v0=("${major_18}" "${minor_19}" "${patch_20}")
    return 0
}

replace__12_v0() {
    local source=$1
    local search=$2
    local replace=$3
    # Here we use a command to avoid #646
    result_17=""
    bash_version__11_v0 
    left_comp=("${ret_bash_version11_v0[@]}")
    right_comp=(4 3)
    comp="$(
        # Compare if left array >= right array
        len_comp="$( (( "${#left_comp[@]}" < "${#right_comp[@]}" )) && echo "${#left_comp[@]}"|| echo "${#right_comp[@]}")"
        for (( i=0; i<len_comp; i++ )); do
            left="${left_comp[i]:-0}"
            right="${right_comp[i]:-0}"
            if (( "${left}" > "${right}" )); then
                echo 1
                exit
            elif (( "${left}" < "${right}" )); then
                echo 0
                exit
            fi
        done
        (( "${#left_comp[@]}" == "${#right_comp[@]}" || "${#left_comp[@]}" > "${#right_comp[@]}" )) && echo 1 || echo 0
)"
    if [ "${comp}" != 0 ]; then
        result_17="${source//"${search}"/"${replace}"}"
    else
        result_17="${source//"${search}"/${replace}}"
    fi
    ret_replace12_v0="${result_17}"
    return 0
}

__SED_VERSION_UNKNOWN_0=0
__SED_VERSION_GNU_1=1
__SED_VERSION_BUSYBOX_2=2
sed_version__14_v0() {
    # We can't match against a word "GNU" because
    # alpine's busybox sed returns "This is not GNU sed version"
    re='\bCopyright\b.+\bFree Software Foundation\b'; [[ $(sed --version 2>/dev/null) =~ $re ]]
    __status=$?
    if [ "$(( ${__status} == 0 ))" != 0 ]; then
        ret_sed_version14_v0="${__SED_VERSION_GNU_1}"
        return 0
    fi
    # On BSD single `sed` waits for stdin. We must use `sed --help` to avoid this.
    re='\bBusyBox\b'; [[ $(sed --help 2>&1) =~ $re ]]
    __status=$?
    if [ "$(( ${__status} == 0 ))" != 0 ]; then
        ret_sed_version14_v0="${__SED_VERSION_BUSYBOX_2}"
        return 0
    fi
    ret_sed_version14_v0="${__SED_VERSION_UNKNOWN_0}"
    return 0
}

match_regex__31_v0() {
    local source=$1
    local search=$2
    local extended=$3
    sed_version__14_v0 
    sed_version_21="${ret_sed_version14_v0}"
    replace__12_v0 "${search}" "/" "\\/"
    search="${ret_replace12_v0}"
    output_22=""
    if [ "$(( $(( ${sed_version_21} == ${__SED_VERSION_GNU_1} )) || $(( ${sed_version_21} == ${__SED_VERSION_BUSYBOX_2} )) ))" != 0 ]; then
        # '\b' is supported but not in POSIX standards. Disable it
        replace__12_v0 "${search}" "\\b" "\\\\b"
        search="${ret_replace12_v0}"
    fi
    if [ "${extended}" != 0 ]; then
        # GNU sed versions 4.0 through 4.2 support extended regex syntax,
        # but only via the "-r" option
        if [ "$(( ${sed_version_21} == ${__SED_VERSION_GNU_1} ))" != 0 ]; then
            # '\b' is not in POSIX standards. Disable it
            replace__12_v0 "${search}" "\\b" "\\b"
            search="${ret_replace12_v0}"
            command_5="$(echo "${source}" | sed -r -ne "/${search}/p")"
            __status=$?
            output_22="${command_5}"
        else
            command_6="$(echo "${source}" | sed -E -ne "/${search}/p")"
            __status=$?
            output_22="${command_6}"
        fi
    else
        if [ "$(( $(( ${sed_version_21} == ${__SED_VERSION_GNU_1} )) || $(( ${sed_version_21} == ${__SED_VERSION_BUSYBOX_2} )) ))" != 0 ]; then
            # GNU Sed BRE handle \| as a metacharacter, but it is not POSIX standands. Disable it
            replace__12_v0 "${search}" "\\|" "|"
            search="${ret_replace12_v0}"
        fi
        command_7="$(echo "${source}" | sed -ne "/${search}/p")"
        __status=$?
        output_22="${command_7}"
    fi
    if [ "$([ "_${output_22}" == "_" ]; echo $?)" != 0 ]; then
        ret_match_regex31_v0=1
        return 0
    fi
    ret_match_regex31_v0=0
    return 0
}

dir_exists__47_v0() {
    local path=$1
    [ -d "${path}" ]
    __status=$?
    ret_dir_exists47_v0="$(( ${__status} == 0 ))"
    return 0
}

file_exists__48_v0() {
    local path=$1
    [ -f "${path}" ]
    __status=$?
    ret_file_exists48_v0="$(( ${__status} == 0 ))"
    return 0
}

dir_create__53_v0() {
    local path=$1
    dir_exists__47_v0 "${path}"
    ret_dir_exists47_v0__87_12="${ret_dir_exists47_v0}"
    if [ "$(( ! ${ret_dir_exists47_v0__87_12} ))" != 0 ]; then
        mkdir -p "${path}"
        __status=$?
        if [ "${__status}" != 0 ]; then
            ret_dir_create53_v0=''
            return "${__status}"
        fi
    fi
}

file_chmod__56_v0() {
    local path=$1
    local mode=$2
    file_exists__48_v0 "${path}"
    ret_file_exists48_v0__153_8="${ret_file_exists48_v0}"
    if [ "${ret_file_exists48_v0__153_8}" != 0 ]; then
        chmod "${mode}" "${path}"
        __status=$?
        if [ "${__status}" != 0 ]; then
            ret_file_chmod56_v0=''
            return "${__status}"
        fi
        ret_file_chmod56_v0=''
        return 0
    fi
    echo "The file ${path} doesn't exist"'!'""
    ret_file_chmod56_v0=''
    return 1
}

file_extract__61_v0() {
    local path=$1
    local target=$2
    file_exists__48_v0 "${path}"
    ret_file_exists48_v0__229_8="${ret_file_exists48_v0}"
    if [ "${ret_file_exists48_v0__229_8}" != 0 ]; then
        match_regex__31_v0 "${path}" "\\.(tar\\.bz2|tbz|tbz2)\$" 1
        ret_match_regex31_v0__231_13="${ret_match_regex31_v0}"
        match_regex__31_v0 "${path}" "\\.(tar\\.gz|tgz)\$" 1
        ret_match_regex31_v0__232_13="${ret_match_regex31_v0}"
        match_regex__31_v0 "${path}" "\\.(tar\\.xz|txz)\$" 1
        ret_match_regex31_v0__233_13="${ret_match_regex31_v0}"
        match_regex__31_v0 "${path}" "\\.bz2\$" 0
        ret_match_regex31_v0__234_13="${ret_match_regex31_v0}"
        match_regex__31_v0 "${path}" "\\.deb\$" 0
        ret_match_regex31_v0__235_13="${ret_match_regex31_v0}"
        match_regex__31_v0 "${path}" "\\.gz\$" 0
        ret_match_regex31_v0__236_13="${ret_match_regex31_v0}"
        match_regex__31_v0 "${path}" "\\.rar\$" 0
        ret_match_regex31_v0__237_13="${ret_match_regex31_v0}"
        match_regex__31_v0 "${path}" "\\.rpm\$" 0
        ret_match_regex31_v0__238_13="${ret_match_regex31_v0}"
        match_regex__31_v0 "${path}" "\\.tar\$" 0
        ret_match_regex31_v0__239_13="${ret_match_regex31_v0}"
        match_regex__31_v0 "${path}" "\\.xz\$" 0
        ret_match_regex31_v0__240_13="${ret_match_regex31_v0}"
        match_regex__31_v0 "${path}" "\\.7z\$" 0
        ret_match_regex31_v0__241_13="${ret_match_regex31_v0}"
        match_regex__31_v0 "${path}" "\\.\\(zip\\|war\\|jar\\)\$" 0
        ret_match_regex31_v0__242_13="${ret_match_regex31_v0}"
        if [ "${ret_match_regex31_v0__231_13}" != 0 ]; then
            tar xvjf "${path}" -C "${target}"
            __status=$?
            if [ "${__status}" != 0 ]; then
                ret_file_extract61_v0=''
                return "${__status}"
            fi
        elif [ "${ret_match_regex31_v0__232_13}" != 0 ]; then
            tar xzf "${path}" -C "${target}"
            __status=$?
            if [ "${__status}" != 0 ]; then
                ret_file_extract61_v0=''
                return "${__status}"
            fi
        elif [ "${ret_match_regex31_v0__233_13}" != 0 ]; then
            tar xJf "${path}" -C "${target}"
            __status=$?
            if [ "${__status}" != 0 ]; then
                ret_file_extract61_v0=''
                return "${__status}"
            fi
        elif [ "${ret_match_regex31_v0__234_13}" != 0 ]; then
            bunzip2 "${path}"
            __status=$?
            if [ "${__status}" != 0 ]; then
                ret_file_extract61_v0=''
                return "${__status}"
            fi
        elif [ "${ret_match_regex31_v0__235_13}" != 0 ]; then
            dpkg-deb -xv "${path}" "${target}"
            __status=$?
            if [ "${__status}" != 0 ]; then
                ret_file_extract61_v0=''
                return "${__status}"
            fi
        elif [ "${ret_match_regex31_v0__236_13}" != 0 ]; then
            gunzip "${path}"
            __status=$?
            if [ "${__status}" != 0 ]; then
                ret_file_extract61_v0=''
                return "${__status}"
            fi
        elif [ "${ret_match_regex31_v0__237_13}" != 0 ]; then
            unrar x "${path}" "${target}"
            __status=$?
            if [ "${__status}" != 0 ]; then
                ret_file_extract61_v0=''
                return "${__status}"
            fi
        elif [ "${ret_match_regex31_v0__238_13}" != 0 ]; then
            rpm2cpio "${path}" | cpio -idm
            __status=$?
            if [ "${__status}" != 0 ]; then
                ret_file_extract61_v0=''
                return "${__status}"
            fi
        elif [ "${ret_match_regex31_v0__239_13}" != 0 ]; then
            tar xf "${path}" -C "${target}"
            __status=$?
            if [ "${__status}" != 0 ]; then
                ret_file_extract61_v0=''
                return "${__status}"
            fi
        elif [ "${ret_match_regex31_v0__240_13}" != 0 ]; then
            xz --decompress "${path}"
            __status=$?
            if [ "${__status}" != 0 ]; then
                ret_file_extract61_v0=''
                return "${__status}"
            fi
        elif [ "${ret_match_regex31_v0__241_13}" != 0 ]; then
            7z -y "${path}" -o "${target}"
            __status=$?
            if [ "${__status}" != 0 ]; then
                ret_file_extract61_v0=''
                return "${__status}"
            fi
        elif [ "${ret_match_regex31_v0__242_13}" != 0 ]; then
            unzip "${path}" -d "${target}"
            __status=$?
            if [ "${__status}" != 0 ]; then
                ret_file_extract61_v0=''
                return "${__status}"
            fi
        else
            echo "Error: Unsupported file type"
            ret_file_extract61_v0=''
            return 3
        fi
    else
        echo "Error: File not found"
        ret_file_extract61_v0=''
        return 2
    fi
}

env_var_get__109_v0() {
    local name=$1
    command_8="$(echo ${!name})"
    __status=$?
    if [ "${__status}" != 0 ]; then
        ret_env_var_get109_v0=''
        return "${__status}"
    fi
    ret_env_var_get109_v0="${command_8}"
    return 0
}

is_command__111_v0() {
    local command=$1
    [ -x "$(command -v "${command}")" ]
    __status=$?
    if [ "${__status}" != 0 ]; then
        ret_is_command111_v0=0
        return 0
    fi
    ret_is_command111_v0=1
    return 0
}

has_failed__115_v0() {
    local command=$1
    eval ${command} >/dev/null 2>&1
    __status=$?
    ret_has_failed115_v0="$(( ${__status} != 0 ))"
    return 0
}

file_download__160_v0() {
    local url=$1
    local path=$2
    is_command__111_v0 "curl"
    ret_is_command111_v0__14_9="${ret_is_command111_v0}"
    is_command__111_v0 "wget"
    ret_is_command111_v0__17_9="${ret_is_command111_v0}"
    is_command__111_v0 "aria2c"
    ret_is_command111_v0__20_9="${ret_is_command111_v0}"
    if [ "${ret_is_command111_v0__14_9}" != 0 ]; then
        curl -L -o "${path}" "${url}" >/dev/null 2>&1
        __status=$?
    elif [ "${ret_is_command111_v0__17_9}" != 0 ]; then
        wget "${url}" -P "${path}" >/dev/null 2>&1
        __status=$?
    elif [ "${ret_is_command111_v0__20_9}" != 0 ]; then
        aria2c "${url}" -d "${path}" >/dev/null 2>&1
        __status=$?
    else
        ret_file_download160_v0=''
        return 1
    fi
}

# copy. original: https://github.com/amber-lang/amber/blob/0.4.0-alpha/setup/shared.ab
get_os__163_v0() {
    # Determine OS type
    command_9="$(uname -s)"
    __status=$?
    if [ "${__status}" != 0 ]; then
        echo "Failed to determine OS type (using \`uname\` command)."
        echo "Please try again or make sure you have it installed."
        exit 1
    fi
    os_type_14="${command_9}"
    if [ "$([ "_${os_type_14}" != "_Darwin" ]; echo $?)" != 0 ]; then
        ret_get_os163_v0="apple-darwin"
        return 0
    fi
    if [ "$([ "_${os_type_14}" == "_Linux" ]; echo $?)" != 0 ]; then
        echo "Unsupported OS type: ${os_type_14}"
        echo "Please try again or use another download method."
        exit 1
    fi
    has_failed__115_v0 "ls -l /lib | grep libc.musl"
    ret_has_failed115_v0__24_10="${ret_has_failed115_v0}"
    if [ "$(( ! ${ret_has_failed115_v0__24_10} ))" != 0 ]; then
        ret_get_os163_v0="unknown-linux-musl"
        return 0
    fi
    ret_get_os163_v0="unknown-linux-gnu"
    return 0
}

get_arch__164_v0() {
    # Determine architecture
    command_10="$(uname -m)"
    __status=$?
    if [ "${__status}" != 0 ]; then
        echo "Failed to determine architecture."
        echo "Please try again or use another download method."
        exit 1
    fi
    arch_type_8="${command_10}"
    array_11=("arm64" "aarch64")
    array_contains__2_v0 array_11[@] "${arch_type_8}"
    ret_array_contains2_v0__38_14="${ret_array_contains2_v0}"
    arch_12="$(if [ "${ret_array_contains2_v0__38_14}" != 0 ]; then echo "aarch64"; else echo "x86_64"; fi)"
    ret_get_arch164_v0="${arch_12}"
    return 0
}

# end copy
env_var_get__109_v0 "AMBER_CACHE_PATH"
__status=$?
cache_path_3="${ret_env_var_get109_v0}"
env_var_get__109_v0 "AMBER_VERSION"
__status=$?
amber_version_4="${ret_env_var_get109_v0}"
bin_path_5="${cache_path_3}/bin"
dest_path_6="${cache_path_3}/dest"
tmp_path_7="${cache_path_3}/tmp"
get_arch__164_v0 
arch_13="${ret_get_arch164_v0}"
get_os__163_v0 
os_15="${ret_get_os163_v0}"
file_exists__48_v0 "${dest_path_6}/script.sh"
ret_file_exists48_v0__56_5="${ret_file_exists48_v0}"
file_exists__48_v0 "${bin_path_5}/amber"
ret_file_exists48_v0__58_7="${ret_file_exists48_v0}"
if [ "${ret_file_exists48_v0__56_5}" != 0 ]; then
    echo "::notice::A compiled bash script found. Skipping install Amber."
elif [ "${ret_file_exists48_v0__58_7}" != 0 ]; then
    echo "::notice::Amber binary found. Skipping install Amber."
else
    url_16=""
    if [ "$([ "_${amber_version_4}" != "_0.5.0-alpha" ]; echo $?)" != 0 ]; then
        replace__12_v0 "${os_15}" "unknown-" ""
        ret_replace12_v0__64_103="${ret_replace12_v0}"
        replace__12_v0 "${ret_replace12_v0__64_103}" "apple-darwin" "macos"
        ret_replace12_v0__64_95="${ret_replace12_v0}"
        url_16="https://github.com/amber-lang/amber/releases/download/${amber_version_4}/amber-${ret_replace12_v0__64_95}-${arch_13}.tar.xz"
    else
        url_16="https://github.com/amber-lang/amber/releases/download/${amber_version_4}/amber-${arch_13}-${os_15}.tar.xz"
    fi
    dir_create__53_v0 "${tmp_path_7}"
    __status=$?
    if [ "${__status}" != 0 ]; then
        exit "${__status}"
    fi
    file_download__160_v0 "${url_16}" "${tmp_path_7}/amber.tar.xz"
    __status=$?
    if [ "${__status}" != 0 ]; then
        exit "${__status}"
    fi
    if [ "$([ "_${os_15}" != "_apple-darwin" ]; echo $?)" != 0 ]; then
        # There is a bug
        file_extract__61_v0 "${tmp_path_7}/amber.tar.xz" "${tmp_path_7}"
        __status=$?
        file_extract__61_v0 "${tmp_path_7}/amber.tar" "${tmp_path_7}"
        __status=$?
    else
        file_extract__61_v0 "${tmp_path_7}/amber.tar.xz" "${tmp_path_7}"
        __status=$?
    fi
    dir_create__53_v0 "${bin_path_5}"
    __status=$?
    if [ "${__status}" != 0 ]; then
        exit "${__status}"
    fi
    mv "${tmp_path_7}/amber-${arch_13}-${os_15}/amber" "${bin_path_5}/amber-${amber_version_4}"
    __status=$?
    if [ "${__status}" != 0 ]; then
        exit "${__status}"
    fi
    file_chmod__56_v0 "${bin_path_5}/amber-${amber_version_4}" "+x"
    __status=$?
    if [ "${__status}" != 0 ]; then
        exit "${__status}"
    fi
fi
