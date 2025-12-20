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

dir_exists__38_v0() {
    local path=$1
    [ -d "${path}" ]
    __status=$?
    ret_dir_exists38_v0="$(( ${__status} == 0 ))"
    return 0
}

file_exists__39_v0() {
    local path=$1
    [ -f "${path}" ]
    __status=$?
    ret_file_exists39_v0="$(( ${__status} == 0 ))"
    return 0
}

file_write__41_v0() {
    local path=$1
    local content=$2
    command_2="$(echo "${content}" > "${path}")"
    __status=$?
    if [ "${__status}" != 0 ]; then
        ret_file_write41_v0=''
        return "${__status}"
    fi
    ret_file_write41_v0="${command_2}"
    return 0
}

dir_create__44_v0() {
    local path=$1
    dir_exists__38_v0 "${path}"
    ret_dir_exists38_v0__87_12="${ret_dir_exists38_v0}"
    if [ "$(( ! ${ret_dir_exists38_v0__87_12} ))" != 0 ]; then
        mkdir -p "${path}"
        __status=$?
        if [ "${__status}" != 0 ]; then
            ret_dir_create44_v0=''
            return "${__status}"
        fi
    fi
}

env_var_get__100_v0() {
    local name=$1
    command_3="$(echo ${!name})"
    __status=$?
    if [ "${__status}" != 0 ]; then
        ret_env_var_get100_v0=''
        return "${__status}"
    fi
    ret_env_var_get100_v0="${command_3}"
    return 0
}

# Load environment variables
env_var_get__100_v0 "AMBER_SCRIPT_AMBER_PATH"
__status=$?
amber_path_3="${ret_env_var_get100_v0}"
env_var_get__100_v0 "AMBER_SCRIPT_CACHE_PATH_INPUT"
__status=$?
cache_path_input_4="${ret_env_var_get100_v0}"
env_var_get__100_v0 "AMBER_SCRIPT_CONTENT"
__status=$?
script_content_5="${ret_env_var_get100_v0}"
env_var_get__100_v0 "AMBER_SCRIPT_HASH"
__status=$?
script_hash_6="${ret_env_var_get100_v0}"
# Calculate cache path
trim__11_v0 "${cache_path_input_4}"
ret_trim11_v0__13_28="${ret_trim11_v0}"
env_var_get__100_v0 "HOME"
__status=$?
ret_env_var_get100_v0__14_18="${ret_env_var_get100_v0}"
amber_cache_path_7="$(if [ "$([ "_${ret_trim11_v0__13_28}" != "_" ]; echo $?)" != 0 ]; then echo "${ret_env_var_get100_v0__14_18}/.cache/amber-script-action"; else echo "${cache_path_input_4}"; fi)"
dist_path_8="${amber_cache_path_7}/dist/${script_hash_6}.sh"
outputs_path_9="${amber_cache_path_7}/outputs/${script_hash_6}.txt"
# Build the given script
file_exists__39_v0 "${dist_path_8}"
ret_file_exists39_v0__21_6="${ret_file_exists39_v0}"
if [ "${ret_file_exists39_v0__21_6}" != 0 ]; then
    echo "::debug::A compiled bash script found. Skip building."
else
    dir_create__44_v0 "${amber_cache_path_7}/tmp"
    __status=$?
    if [ "${__status}" != 0 ]; then
        exit "${__status}"
    fi
    file_write__41_v0 "${amber_cache_path_7}/tmp/${script_hash_6}.ab" "${script_content_5}"
    __status=$?
    if [ "${__status}" != 0 ]; then
        exit "${__status}"
    fi
    dir_create__44_v0 "${amber_cache_path_7}/dist"
    __status=$?
    if [ "${__status}" != 0 ]; then
        exit "${__status}"
    fi
    "${amber_path_3}" build "${amber_cache_path_7}/tmp/${script_hash_6}.ab" "${dist_path_8}"
    __status=$?
    if [ "${__status}" != 0 ]; then
    code_10="${__status}"
        echo "Failed to build script with exit code ${code_10}"
        exit "${code_10}"
    fi
fi
# Prepare outputs collection
dir_create__44_v0 "${amber_cache_path_7}/outputs"
__status=$?
if [ "${__status}" != 0 ]; then
    exit "${__status}"
fi
touch ${outputs_path_9}
__status=$?
if [ "${__status}" != 0 ]; then
    exit "${__status}"
fi
AMBER_SCRIPT_OUTPUT="${outputs_path_9}"
__status=$?
if [ "${__status}" != 0 ]; then
    exit "${__status}"
fi
export AMBER_SCRIPT_OUTPUT
__status=$?
if [ "${__status}" != 0 ]; then
    exit "${__status}"
fi
# Run the compiled script
bash "${dist_path_8}"
__status=$?
if [ "${__status}" != 0 ]; then
    exit "${__status}"
fi
# Process outputs into JSON and write to GITHUB_OUTPUT
command_5="$(jq -R -s 'split("
") | map(select(length > 0)) | map(split("=")) | map({(.[0]): .[1]}) | add // {}' "{}")"
__status=$?
if [ "${__status}" != 0 ]; then
    echo "::warning::Failed to process outputs, using empty object"
    echo "{\\}"
fi
json_output_11="${command_5}"
echo "script_outputs=${json_output_11}" >> $GITHUB_OUTPUT
__status=$?
if [ "${__status}" != 0 ]; then
code_12="${__status}"
    echo "::warning::Failed to set script_outputs with code ${code_12}"
fi
