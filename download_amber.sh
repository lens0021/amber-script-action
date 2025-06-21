#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)
# version: 0.4.0-alpha
# date: 2025-06-21 12:38:55
array_find__0_v0() {

# bshchk (https://git.blek.codes/blek/bshchk)
deps=('[' '[' 'return' 'true' 'bc' 'sed' 'return' 'bc' 'sed' 'return' 'return' '[' 'sed' '[' 'bc' 'sed' 'sed' 'sed' '[' '[' 'return' 'return' '[' '[' 'return' 'return' '[' '[' 'return' 'return' '[' 'bc' 'sed' 'mkdir' '[' 'chmod' 'return' 'return' '[' '[' 'tar' '[' 'return' '[' 'tar' '[' 'return' '[' 'tar' '[' 'return' '[' 'bunzip2' '[' 'return' '[' 'dpkg-deb' '[' 'return' '[' 'gunzip' '[' 'return' '[' 'unrar' '[' 'return' '[' 'rpm2cpio' 'cpio' '[' 'return' '[' 'tar' '[' 'return' '[' 'xz' '[' 'return' '[' '7z' '[' 'return' '[' 'unzip' '[' 'return' 'return' 'return' '[' 'return' 'return' '[' '[' 'return' 'return' 'eval' 'bc' 'sed' 'return' '[' 'curl' '[' 'wget' '[' 'aria2c' 'return' 'return' 'uname' '[' 'exit' '[' '[' 'return' '[' '[' 'exit' '[' 'bc' 'sed' 'return' 'return' 'uname' '[' 'exit' '[' 'return' '[' '[' '[' '[' 'mv' '[' 'exit')
non_ok=()

for d in $deps
do
    if ! command -v $d > /dev/null 2>&1; then
        non_ok+=$d
    fi
done

if (( ${#non_ok[@]} != 0 )); then
    >&2 echo "RDC Failed!"
    >&2 echo "  This program requires these commands:"
    >&2 echo "  > $deps"
    >&2 echo "    --- "
    >&2 echo "  From which, these are missing:"
    >&2 echo "  > $non_ok"
    >&2 echo "Make sure that those are installed and are present in \$PATH."
    exit 1
fi

unset non_ok
unset deps
# Dependencies are OK at this point


    local array=("${!1}")
    local value=$2
    index=0
    for element in "${array[@]}"; do
        if [ $(
            [ "_${value}" != "_${element}" ]
            echo $?
        ) != 0 ]; then
            __AF_array_find0_v0=${index}
            return 0
        fi
        ((index++)) || true
    done
    __AF_array_find0_v0=$(echo '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    return 0
}
array_contains__2_v0() {
    local array=("${!1}")
    local value=$2
    array_find__0_v0 array[@] "${value}"
    __AF_array_find0_v0__26_18="$__AF_array_find0_v0"
    local result="$__AF_array_find0_v0__26_18"
    __AF_array_contains2_v0=$(echo ${result} '>=' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    return 0
}
replace__10_v0() {
    local source=$1
    local search=$2
    local replace=$3
    __AF_replace10_v0="${source//${search}/${replace}}"
    return 0
}
match_regex__27_v0() {
    local source=$1
    local search=$2
    local extended=$3
    replace__10_v0 "${search}" "/" "\/"
    __AF_replace10_v0__130_18="${__AF_replace10_v0}"
    search="${__AF_replace10_v0__130_18}"
    local output=""
    if [ ${extended} != 0 ]; then
        # GNU sed versions 4.0 through 4.2 support extended regex syntax,
        # but only via the "-r" option; use that if the version information
        # contains "GNU sed".
        re='\bCopyright\b.+\bFree Software Foundation\b'
        [[ $(sed --version 2>/dev/null) =~ $re ]]
        __AS=$?
        local flag=$(if [ $(echo $__AS '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "-r"; else echo "-E"; fi)
        __AMBER_VAL_0=$(echo "${source}" | sed "${flag}" -ne "/${search}/p")
        __AS=$?
        output="${__AMBER_VAL_0}"
    else
        __AMBER_VAL_1=$(echo "${source}" | sed -ne "/${search}/p")
        __AS=$?
        output="${__AMBER_VAL_1}"
    fi
    if [ $(
        [ "_${output}" == "_" ]
        echo $?
    ) != 0 ]; then
        __AF_match_regex27_v0=1
        return 0
    fi
    __AF_match_regex27_v0=0
    return 0
}
dir_exists__42_v0() {
    local path=$1
    [ -d "${path}" ]
    __AS=$?
    if [ $__AS != 0 ]; then
        __AF_dir_exists42_v0=0
        return 0
    fi
    __AF_dir_exists42_v0=1
    return 0
}
file_exists__43_v0() {
    local path=$1
    [ -f "${path}" ]
    __AS=$?
    if [ $__AS != 0 ]; then
        __AF_file_exists43_v0=0
        return 0
    fi
    __AF_file_exists43_v0=1
    return 0
}
dir_create__48_v0() {
    local path=$1
    dir_exists__42_v0 "${path}"
    __AF_dir_exists42_v0__52_12="$__AF_dir_exists42_v0"
    if [ $(echo '!' "$__AF_dir_exists42_v0__52_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        mkdir -p "${path}"
        __AS=$?
    fi
}
file_chmod__49_v0() {
    local path=$1
    local mode=$2
    file_exists__43_v0 "${path}"
    __AF_file_exists43_v0__61_8="$__AF_file_exists43_v0"
    if [ "$__AF_file_exists43_v0__61_8" != 0 ]; then
        chmod "${mode}" "${path}"
        __AS=$?
        __AF_file_chmod49_v0=1
        return 0
    fi
    echo "The file ${path} doesn't exist"'!'""
    __AF_file_chmod49_v0=0
    return 0
}
file_extract__54_v0() {
    local path=$1
    local target=$2
    file_exists__43_v0 "${path}"
    __AF_file_exists43_v0__117_8="$__AF_file_exists43_v0"
    if [ "$__AF_file_exists43_v0__117_8" != 0 ]; then
        match_regex__27_v0 "${path}" "\.\(tar\.bz2\|tbz\|tbz2\)\$" 0
        __AF_match_regex27_v0__119_13="$__AF_match_regex27_v0"
        match_regex__27_v0 "${path}" "\.\(tar\.gz\|tgz\)\$" 0
        __AF_match_regex27_v0__120_13="$__AF_match_regex27_v0"
        match_regex__27_v0 "${path}" "\.\(tar\.xz\|txz\$\)\$" 0
        __AF_match_regex27_v0__121_13="$__AF_match_regex27_v0"
        match_regex__27_v0 "${path}" "\.bz2\$" 0
        __AF_match_regex27_v0__122_13="$__AF_match_regex27_v0"
        match_regex__27_v0 "${path}" "\.deb\$" 0
        __AF_match_regex27_v0__123_13="$__AF_match_regex27_v0"
        match_regex__27_v0 "${path}" "\.gz\$" 0
        __AF_match_regex27_v0__124_13="$__AF_match_regex27_v0"
        match_regex__27_v0 "${path}" "\.rar\$" 0
        __AF_match_regex27_v0__125_13="$__AF_match_regex27_v0"
        match_regex__27_v0 "${path}" "\.rpm\$" 0
        __AF_match_regex27_v0__126_13="$__AF_match_regex27_v0"
        match_regex__27_v0 "${path}" "\.tar\$" 0
        __AF_match_regex27_v0__127_13="$__AF_match_regex27_v0"
        match_regex__27_v0 "${path}" "\.xz\$" 0
        __AF_match_regex27_v0__128_13="$__AF_match_regex27_v0"
        match_regex__27_v0 "${path}" "\.7z\$" 0
        __AF_match_regex27_v0__129_13="$__AF_match_regex27_v0"
        match_regex__27_v0 "${path}" "\.\(zip\|war\|jar\)\$" 0
        __AF_match_regex27_v0__130_13="$__AF_match_regex27_v0"
        if [ "$__AF_match_regex27_v0__119_13" != 0 ]; then
            tar xvjf "${path}" -C "${target}"
            __AS=$?
            if [ $__AS != 0 ]; then
                __AF_file_extract54_v0=''
                return $__AS
            fi
        elif [ "$__AF_match_regex27_v0__120_13" != 0 ]; then
            tar xzf "${path}" -C "${target}"
            __AS=$?
            if [ $__AS != 0 ]; then
                __AF_file_extract54_v0=''
                return $__AS
            fi
        elif [ "$__AF_match_regex27_v0__121_13" != 0 ]; then
            tar xJf "${path}" -C "${target}"
            __AS=$?
            if [ $__AS != 0 ]; then
                __AF_file_extract54_v0=''
                return $__AS
            fi
        elif [ "$__AF_match_regex27_v0__122_13" != 0 ]; then
            bunzip2 "${path}"
            __AS=$?
            if [ $__AS != 0 ]; then
                __AF_file_extract54_v0=''
                return $__AS
            fi
        elif [ "$__AF_match_regex27_v0__123_13" != 0 ]; then
            dpkg-deb -xv "${path}" "${target}"
            __AS=$?
            if [ $__AS != 0 ]; then
                __AF_file_extract54_v0=''
                return $__AS
            fi
        elif [ "$__AF_match_regex27_v0__124_13" != 0 ]; then
            gunzip "${path}"
            __AS=$?
            if [ $__AS != 0 ]; then
                __AF_file_extract54_v0=''
                return $__AS
            fi
        elif [ "$__AF_match_regex27_v0__125_13" != 0 ]; then
            unrar x "${path}" "${target}"
            __AS=$?
            if [ $__AS != 0 ]; then
                __AF_file_extract54_v0=''
                return $__AS
            fi
        elif [ "$__AF_match_regex27_v0__126_13" != 0 ]; then
            rpm2cpio "${path}" | cpio -idm
            __AS=$?
            if [ $__AS != 0 ]; then
                __AF_file_extract54_v0=''
                return $__AS
            fi
        elif [ "$__AF_match_regex27_v0__127_13" != 0 ]; then
            tar xf "${path}" -C "${target}"
            __AS=$?
            if [ $__AS != 0 ]; then
                __AF_file_extract54_v0=''
                return $__AS
            fi
        elif [ "$__AF_match_regex27_v0__128_13" != 0 ]; then
            xz --decompress "${path}"
            __AS=$?
            if [ $__AS != 0 ]; then
                __AF_file_extract54_v0=''
                return $__AS
            fi
        elif [ "$__AF_match_regex27_v0__129_13" != 0 ]; then
            7z -y "${path}" -o "${target}"
            __AS=$?
            if [ $__AS != 0 ]; then
                __AF_file_extract54_v0=''
                return $__AS
            fi
        elif [ "$__AF_match_regex27_v0__130_13" != 0 ]; then
            unzip "${path}" -d "${target}"
            __AS=$?
            if [ $__AS != 0 ]; then
                __AF_file_extract54_v0=''
                return $__AS
            fi
        else
            echo "Error: Unsupported file type"
            __AF_file_extract54_v0=''
            return 3
        fi
    else
        echo "Error: File not found"
        __AF_file_extract54_v0=''
        return 2
    fi
}
env_var_get__101_v0() {
    local name=$1
    __AMBER_VAL_2=$(echo ${!name})
    __AS=$?
    if [ $__AS != 0 ]; then
        __AF_env_var_get101_v0=''
        return $__AS
    fi
    __AF_env_var_get101_v0="${__AMBER_VAL_2}"
    return 0
}
is_command__103_v0() {
    local command=$1
    [ -x "$(command -v ${command})" ]
    __AS=$?
    if [ $__AS != 0 ]; then
        __AF_is_command103_v0=0
        return 0
    fi
    __AF_is_command103_v0=1
    return 0
}
has_failed__107_v0() {
    local command=$1
    eval ${command} >/dev/null 2>&1
    __AS=$?
    __AF_has_failed107_v0=$(echo $__AS '!=' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    return 0
}
file_download__150_v0() {
    local url=$1
    local path=$2
    is_command__103_v0 "curl"
    __AF_is_command103_v0__9_9="$__AF_is_command103_v0"
    is_command__103_v0 "wget"
    __AF_is_command103_v0__12_9="$__AF_is_command103_v0"
    is_command__103_v0 "aria2c"
    __AF_is_command103_v0__15_9="$__AF_is_command103_v0"
    if [ "$__AF_is_command103_v0__9_9" != 0 ]; then
        curl -L -o "${path}" "${url}"
        __AS=$?
    elif [ "$__AF_is_command103_v0__12_9" != 0 ]; then
        wget "${url}" -P "${path}"
        __AS=$?
    elif [ "$__AF_is_command103_v0__15_9" != 0 ]; then
        aria2c "${url}" -d "${path}"
        __AS=$?
    else
        __AF_file_download150_v0=0
        return 0
    fi
    __AF_file_download150_v0=1
    return 0
}
# copy. original: https://github.com/amber-lang/amber/blob/0.4.0-alpha/setup/shared.ab
get_os__153_v0() {
    # Determine OS type
    __AMBER_VAL_3=$(uname -s)
    __AS=$?
    if [ $__AS != 0 ]; then
        echo "Failed to determine OS type (using \`uname\` command)."
        echo "Please try again or make sure you have it installed."
        exit 1
    fi
    local os_type="${__AMBER_VAL_3}"
    if [ $(
        [ "_${os_type}" != "_Darwin" ]
        echo $?
    ) != 0 ]; then
        __AF_get_os153_v0="apple-darwin"
        return 0
    fi
    if [ $(
        [ "_${os_type}" == "_Linux" ]
        echo $?
    ) != 0 ]; then
        echo "Unsupported OS type: ${os_type}"
        echo "Please try again or use another download method."
        exit 1
    fi
    has_failed__107_v0 "ls -l /lib | grep libc.musl"
    __AF_has_failed107_v0__24_10="$__AF_has_failed107_v0"
    if [ $(echo '!' "$__AF_has_failed107_v0__24_10" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_get_os153_v0="unknown-linux-musl"
        return 0
    fi
    __AF_get_os153_v0="unknown-linux-gnu"
    return 0
}
get_arch__154_v0() {
    # Determine architecture
    __AMBER_VAL_4=$(uname -m)
    __AS=$?
    if [ $__AS != 0 ]; then
        echo "Failed to determine architecture."
        echo "Please try again or use another download method."
        exit 1
    fi
    local arch_type="${__AMBER_VAL_4}"
    __AMBER_ARRAY_5=("arm64" "aarch64")
    array_contains__2_v0 __AMBER_ARRAY_5[@] "${arch_type}"
    __AF_array_contains2_v0__38_14="$__AF_array_contains2_v0"
    local arch=$(if [ "$__AF_array_contains2_v0__38_14" != 0 ]; then echo "aarch64"; else echo "x86_64"; fi)
    __AF_get_arch154_v0="${arch}"
    return 0
}
# end copy
env_var_get__101_v0 "AMBER_CACHE_PATH"
__AS=$?
__AF_env_var_get101_v0__46_26="${__AF_env_var_get101_v0}"
__0_cache_path="${__AF_env_var_get101_v0__46_26}"
env_var_get__101_v0 "AMBER_VERSION"
__AS=$?
__AF_env_var_get101_v0__47_29="${__AF_env_var_get101_v0}"
__1_amber_version="${__AF_env_var_get101_v0__47_29}"
__2_bin_path="${__0_cache_path}/bin"
__3_dest_path="${__0_cache_path}/dest"
__4_tmp_path="${__0_cache_path}/tmp"
get_arch__154_v0
__AF_get_arch154_v0__51_14="${__AF_get_arch154_v0}"
__5_arch="${__AF_get_arch154_v0__51_14}"
get_os__153_v0
__AF_get_os153_v0__52_12="${__AF_get_os153_v0}"
__6_os="${__AF_get_os153_v0__52_12}"
declare -r argv=("$0" "$@")
file_exists__43_v0 "${__3_dest_path}/script.sh"
__AF_file_exists43_v0__56_5="$__AF_file_exists43_v0"
file_exists__43_v0 "${__2_bin_path}/amber"
__AF_file_exists43_v0__58_7="$__AF_file_exists43_v0"
if [ "$__AF_file_exists43_v0__56_5" != 0 ]; then
    echo "::notice::A compiled bash script found. Skipping install Amber."
elif [ "$__AF_file_exists43_v0__58_7" != 0 ]; then
    echo "::notice::Amber binary found. Skipping install Amber."
else
    url="https://github.com/amber-lang/amber/releases/download/0.4.0-alpha/amber-${__5_arch}-${__6_os}.tar.xz"
    dir_create__48_v0 "${__4_tmp_path}"
    __AF_dir_create48_v0__62_7="$__AF_dir_create48_v0"
    echo "$__AF_dir_create48_v0__62_7" >/dev/null 2>&1
    file_download__150_v0 "${url}" "${__4_tmp_path}/amber.tar.xz"
    __AF_file_download150_v0__63_7="$__AF_file_download150_v0"
    echo "$__AF_file_download150_v0__63_7" >/dev/null 2>&1
    if [ $(
        [ "_${__6_os}" != "_apple-darwin" ]
        echo $?
    ) != 0 ]; then
        # There is a bug
        file_extract__54_v0 "${__4_tmp_path}/amber.tar.xz" "${__4_tmp_path}"
        __AS=$?
        __AF_file_extract54_v0__66_15="$__AF_file_extract54_v0"
        echo "$__AF_file_extract54_v0__66_15" >/dev/null 2>&1
        file_extract__54_v0 "${__4_tmp_path}/amber.tar" "${__4_tmp_path}"
        __AS=$?
        __AF_file_extract54_v0__67_15="$__AF_file_extract54_v0"
        echo "$__AF_file_extract54_v0__67_15" >/dev/null 2>&1
    else
        file_extract__54_v0 "${__4_tmp_path}/amber.tar.xz" "${__4_tmp_path}"
        __AS=$?
        __AF_file_extract54_v0__69_15="$__AF_file_extract54_v0"
        echo "$__AF_file_extract54_v0__69_15" >/dev/null 2>&1
    fi
    dir_create__48_v0 "${__2_bin_path}"
    __AF_dir_create48_v0__71_7="$__AF_dir_create48_v0"
    echo "$__AF_dir_create48_v0__71_7" >/dev/null 2>&1
    mv "${__4_tmp_path}/amber-${__5_arch}-${__6_os}/amber" "${__2_bin_path}/amber-${__1_amber_version}"
    __AS=$?
    if [ $__AS != 0 ]; then

        exit $__AS
    fi
    file_chmod__49_v0 "${__2_bin_path}/amber-${__1_amber_version}" "+x"
    __AF_file_chmod49_v0__73_7="$__AF_file_chmod49_v0"
    echo "$__AF_file_chmod49_v0__73_7" >/dev/null 2>&1
fi
