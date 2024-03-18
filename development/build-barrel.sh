#!/bin/bash

# This script builds a Garmin Connect IQ Barrel project.
# It assumes that the SDKs bin folder (that includes monkeyc compiler, etc.) is set CIQ_SDK environment variable.
# It takes two arguments: the path to the jungle file of your project and the version of the barrel.

# Warning: This script requires the Garmin Connect IQ SDK to be installed and configured.

# check if CIQ_SDK environment variable is set
if [ -z "$CIQ_SDK" ]
then
    echo "CIQ_SDK environment variable is not set. Set it to the path of the Garmin Connect IQ SDK."
    exit 1
fi

function show_message_and_exit {
    local message=$1
    echo $message
    echo
    usage
    exit 1
}

function check_if_file_exists_or_exit {
    local file=$1
    local file_description=${2:-$file}

    if [ ! -f "$file" ]
    then
        show_message_and_exit "The $file_description does not exist."
    fi
}

# WRITE function that prints the usage of the script and explain the parameters
function usage {
    echo "Usage: build-barrel.sh -j <path to the .jungle file> -v <version>"
    echo
    echo "Options:"
    echo "  -j, --jungle-file <path to the .jungle file>  The path to the .jungle file of your project. REQUIREDG"
    echo "  -v, --version <version>                       The version of the barrel. OPTIONAL"
    echo "  -o, --output <output directory>               The output directory for the barrel file. OPTIONAL"
    echo
    echo "Important:"
    echo "   If <version> is not given, the script will try to read it from the .jungle file (manifest.xml actually)."
    echo "   If <version> is given, the SCRIPT WILL UPDATE the .jungle file with the new version."
    echo
    echo "Example:"
    echo "  build-barrel.sh -j barrel.jungle".
    echo "  build-barrel.sh -j barrel.jungle -o bin"
    echo "  build-barrel.sh -j /path/to/project.jungle -v 1.0.0"

}

function get_manifest_file {
    local jungle_file=$1
    if [ ! -f "$jungle_file" ]
    then
        echo "The jungle file does not exist."
        echo
        usage
        exit 1
    fi
    # read project.manifest value from the jungle file
    local manifest_file=$(grep -oP 'project.manifest = \K.*' $jungle_file)
    echo $manifest_file
}



function get_version_from_manifest {
    local manifest_file=$1
    local version=$(grep 'iq:barrel' $manifest_file | grep -oP 'version="\K[^"]*' )
    echo $version

}

function get_name_from_manifest {
    local manifest_file=$1
    local name=$(grep 'iq:barrel' $manifest_file | grep -oP 'module="\K[^"]*' )
    echo $name
}

function update_manifest_file {
    local manifest_file=$1
    local new_version=$2

    # Use sed to replace the version in the manifest file
    sed -i -r 's/(<iq:barrel[^>]* version=")[^"]*/\1'"$new_version"'/' $manifest_file
}

# initialize parameters
jungle_file=""
version=""
output_directory="."


# parse parameters
TEMP=`getopt -o j:v:o: --long version:,output: -n 'build-barrel.sh' -- "$@"`
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$TEMP"
while true ; do
    case "$1" in
        -j) jungle_file="$2" ; shift 2 ;;
        -v|--version) version="$2" ; shift 2 ;;
        -o|--output) output_directory="$2" ; shift 2 ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done


# check if parameters are passed
if [ -z "$jungle_file" ]
then
    show_message_and_exit "Incorrect arguments supplied. Supply the path to the .jungle file and the version."
fi

# get the directory of the project file
project_dir=$(dirname "$jungle_file")

# !!! execute following logic in project directory
pushd $project_dir

# get project manifest file
manifest_file=$(get_manifest_file $jungle_file)
check_if_file_exists_or_exit $manifest_file "manifest file"

# If <version> is not given, the script will try to read it from the manifest.xml. manifest is delcaret in jungle file with "project.manifest = manifest.xml"
if [ -z "$version" ]
then
    version=$(get_version_from_manifest $manifest_file)
    echo "--------Version: $version"
else
    echo "--------Updating manifest file with new version: $version"
    update_manifest_file $manifest_file $version
fi

# output_file_name is the name of the barrel file; it consist of the name (read from manifest) and the version
output_file_name=$(get_name_from_manifest $manifest_file)-$version.barrel

# my_barrelbuild path is CIQ_SDK/bin/barrelbuild
my_barrelbuild=$CIQ_SDK/bin/barrelbuild
check_if_file_exists_or_exit $my_barrelbuild "barrelbuild binary"


echo $my_barrelbuild -o $output_directory/$output_file_name -f $jungle_file
$my_barrelbuild -o $output_directory/$output_file_name -f $jungle_file

popd
