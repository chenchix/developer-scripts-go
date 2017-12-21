#!/bin/bash

# Copyright 2017 Cavium Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Author: chencho


set -e


compileAll(){
SELECTED_MODULES=($@)
for m in ${SELECTED_MODULES[@]} ;  do
    if [ -d $m ] ; then
        echo "Compiling $m"
        # Nothing to do
        if [ $m == 'export-go' ]; then
            continue
        fi

        cd $m
        # No vendor extensions
        if [[ "$m" =~ ^(support-domain-go|support-notifications-client-go)$ ]]; then
            go install
            cd ..
            continue
        fi

        glide up
        
        # No need to be built
        if [ $m == 'core-domain-go' ]; then
            cd ..
            continue
        fi

        # Specific directories
        if [ $m == 'core-clients-go' ]; then
            go install ./coredataclients
            go install ./metadataclients
            cd ..
            continue
        fi

        go build
        echo "$m: Done"
        cd ..
    fi
done

}

usage(){
	echo "Error, you must press 'y' or 'n'"
	exit 0
}


start(){
rm -rf dist
mkdir -p dist
cp core-metadata-go/core-metadata-go dist/
cp core-data-go/core-data-go dist/
cp core-command-go/core-command-go dist/

compileAll "${MODULES[@]}"
echo "Done!"
}



if [ $# -eq 0 ]; then
	. ./MODULES
	start
else
	compileAll $@
fi

