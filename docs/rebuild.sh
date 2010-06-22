#!/usr/bin/env bash
#
# Generating rvm self documents
#

# uncomment for debugging
#set -x

# checking system requirements
[[ `which asciidoc 2> /dev/null` ]] || (echo "'asciidoc' is not installed on your system, exiting..."; exit 1)
[[ `which docbook2man 2> /dev/null` ]] || (echo "'docbook2x' is not installed on your system, exiting..."; exit 1)

DIRNAME=$(dirname $0)
rvm_base_dir=$(cd $DIRNAME/../; pwd)
rvm_docs_src_dir=${rvm_base_dir}/docs
rvm_tmp_dir=${rvm_base_dir}/tmp
rvm_docs_target_man_dir=${rvm_base_dir}/man

mkdir -p ${rvm_tmp_dir}
mkdir -p ${rvm_docs_target_man_dir}

echo "Starting doc generation run through."

# processing manpages
find ${rvm_docs_src_dir} -type f -name *.txt | while read i; do
    _manpage_file="${i}"

    # trying to detect manpage name automatically
    # (just for fun, I don't think, that rvm will ever have
    # moar then one manpage :)
    # The name of the generated manpage is initially specified
    # within the source file in asciidoc format,
    # so we'll do some simple parsing
    # We assume, that it will be specified at one of the 3(three) first lines
    # of the source file.

    # it should be smth like 'RVM(1)'
    _manpage_name_full="$(cat ${_manpage_file} | head -n 3 | grep -o '^[^(]*[(][^)]*[)]$')"
    [[ -z "${_manpage_name_full}" ]] && (echo "Unable to detect manpage name, stopping build process..."; exit 1)
    # we need smth like 'rvm.1'
    _manpage_name=$(echo ${_manpage_name_full} | sed "s|(|.|;s|)||" | tr '[[:upper:]]' '[[:lower:]]')
    # we need '1'
    _manpage_name_part=$(echo ${_manpage_name} | cut -d '.' -f 2)
    # So, the manpage directory will be the following:
    _manpage_dir=${rvm_docs_target_man_dir}/man${_manpage_name_part}
    mkdir -p ${_manpage_dir}

    echo "Generating docbook format from source file for $_manpage_name"
    asciidoc -d manpage -b docbook -o "${rvm_tmp_dir}/${_manpage_name}.dbk" ${_manpage_file}
    pushd "$rvm_tmp_dir" >/dev/null 2>&1
    echo "Generating manpage from docbook file."
    docbook2man "${rvm_tmp_dir}/${_manpage_name}.dbk"
    popd >/dev/null 2>&1
    echo "Moving manpage to the the correct folder"
    mv "${rvm_tmp_dir}/${_manpage_name}" "${_manpage_dir}"
    # compression is optional, but gzip check added for neatness
    echo "If gzip is available, compressing"
    [[ `which gzip` ]] && gzip -f "${_manpage_dir}/${_manpage_name}"
done

# vim: ft=sh
