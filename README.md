Set of scripts to setup an environment with docker and go projects

-compile.sh  docker-compose.yml	MODULES  prepare.sh  run-it

Run prepare.sh to download all neccessary stuff. (dockers and go projects from edgexfoundry) and then compile.sh to build binaries.

Finally, run all the mess using run-it.

NOTES:
MODULES:
 - defines projects to be downloaded

docker-compose.yml
 - defines dockers to be built
 
