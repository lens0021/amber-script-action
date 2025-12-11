#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)
# version: 0.5.1-alpha
# We cannot import `bash_version` from `env.ab` because it imports `text.ab` making a circular dependency.
# This is a workaround to avoid that issue and the import system should be improved in the future.
trim_left__9_v0() {
    local text=$1
    command_0="$(echo "${text}" | sed -e 's/^[[:space:]]*//')"
    __status=$?
    ret_trim_left9_v0="${command_0}"
    return 0
}

trim_right__10_v0() {
    local text=$1
    command_1="$(echo "${text}" | sed -e 's/[[:space:]]*$//')"
    __status=$?
    ret_trim_right10_v0="${command_1}"
    return 0
}

trim__11_v0() {
    local text=$1
    trim_right__10_v0 "${text}"
    ret_trim_right10_v0__178_22="${ret_trim_right10_v0}"
    trim_left__9_v0 "${ret_trim_right10_v0__178_22}"
    ret_trim11_v0="${ret_trim_left9_v0}"
    return 0
}

dir_exists__37_v0() {
    local path=$1
    [ -d "${path}" ]
    __status=$?
    ret_dir_exists37_v0="$(( ${__status} == 0 ))"
    return 0
}

file_exists__38_v0() {
    local path=$1
    [ -f "${path}" ]
    __status=$?
    ret_file_exists38_v0="$(( ${__status} == 0 ))"
    return 0
}

file_write__40_v0() {
    local path=$1
    local content=$2
    command_2="$(echo "${content}" > "${path}")"
    __status=$?
    if [ "${__status}" != 0 ]; then
        ret_file_write40_v0=''
        return "${__status}"
    fi
    ret_file_write40_v0="${command_2}"
    return 0
}

dir_create__43_v0() {
    local path=$1
    dir_exists__37_v0 "${path}"
    ret_dir_exists37_v0__87_12="${ret_dir_exists37_v0}"
    if [ "$(( ! ${ret_dir_exists37_v0__87_12} ))" != 0 ]; then
        mkdir -p "${path}"
        __status=$?
        if [ "${__status}" != 0 ]; then
            ret_dir_create43_v0=''
            return "${__status}"
        fi
    fi
}

env_var_get__99_v0() {
    local name=$1
    command_3="$(echo ${!name})"
    __status=$?
    if [ "${__status}" != 0 ]; then
        ret_env_var_get99_v0=''
        return "${__status}"
    fi
    ret_env_var_get99_v0="${command_3}"
    return 0
}

# Calculate cache path
env_var_get__99_v0 "AMBER_SCRIPT_CACHE_PATH_INPUT"
__status=$?
cache_path_input_3="${ret_env_var_get99_v0}"
env_var_get__99_v0 "AMBER_SCRIPT_RUNNER_OS"
__status=$?
runner_os_4="${ret_env_var_get99_v0}"
trim__11_v0 "${cache_path_input_3}"
ret_trim11_v0__8_26="${ret_trim11_v0}"
amber_cache_path_5="$(if [ "$([ "_${ret_trim11_v0__8_26}" == "_" ]; echo $?)" != 0 ]; then echo "${cache_path_input_3}"; else echo "$(if [ "$([ "_${runner_os_4}" != "_Linux" ]; echo $?)" != 0 ]; then echo "/home/runner/.amber-script-action"; else echo "/Users/runner/.amber-script-action"; fi)"; fi)"
env_var_get__99_v0 "AMBER_SCRIPT_CONTENT"
__status=$?
script_content_6="${ret_env_var_get99_v0}"
env_var_get__99_v0 "AMBER_SCRIPT_VERSION"
__status=$?
amber_version_7="${ret_env_var_get99_v0}"
# Calculate hash for the given script
# Note: macos runner does not have sha256sum.
command_4="$(printf '%s
' "${script_content_6}" | openssl sha256 | cut -d' ' -f 2)"
__status=$?
if [ "${__status}" != 0 ]; then
code_8="${__status}"
    echo "Failed to calculate script hash"
    exit "${code_8}"
fi
script_hash_9="${command_4}"
dest_path_10="${amber_cache_path_5}/dest/${script_hash_9}.sh"
# Build the given script
file_exists__38_v0 "${dest_path_10}"
ret_file_exists38_v0__27_4="${ret_file_exists38_v0}"
if [ "${ret_file_exists38_v0__27_4}" != 0 ]; then
    echo "::debug::A compiled bash script found. Skip building."
else
    dir_create__43_v0 "${amber_cache_path_5}/tmp"
    __status=$?
    file_write__40_v0 "${amber_cache_path_5}/tmp/${script_hash_9}.ab" "${script_content_6}"
    __status=$?
    dir_create__43_v0 "${amber_cache_path_5}/dest"
    __status=$?
    "${amber_cache_path_5}/bin/amber-${amber_version_7}/amber" build "${amber_cache_path_5}/tmp/${script_hash_9}.ab" "${dest_path_10}"
    __status=$?
    if [ "${__status}" != 0 ]; then
    code_11="${__status}"
        echo "Failed to build script with exit code ${code_11}"
        exit "${code_11}"
    fi
fi
# Run the compiled script
bash "${dest_path_10}"
__status=$?
if [ "${__status}" != 0 ]; then
code_12="${__status}"
    echo "Failed to run script with exit code ${code_12}"
    exit "${code_12}"
fi
