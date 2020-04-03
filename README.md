# Clueless
JHU Software Engineering Spring 2020 Course Project - Team TIAAT

## Purpose
This repository contains the necessary SW for building a debian installer for project Clueless for use in deployment
on the System Virtual Machines
The source code for Clueless are stored in separate repositories:
* `clueless_frontend` https://github.com/naterjlao/clueless_frontend
* `clueless_serverside` https://github.com/naterjlao/clueless_serverside
* `clueless_backend` https://github.com/naterjlao/clueless_backend

## Installation
### System Requirements
Clueless has only been developed and tested on Debian server with the following System Requirements:
* 2GB RAM
* 1 CPU core
* x86_64*

_Note*: architecture may be agnostic - was only tested on x86_64_

### Prerequisites
* The server must be connected to the internet.
* TCP ports 8080 and 3000 must be opened. (This can be later changed post-installation)

### Installation
Clueless requires network access to install dependencies. Command as root:

`apt install <DEB PACKAGE> -y`

## Package Configuration
The Clueless package configuration is defined in the build configuration repository:

https://github.com/naterjlao/clueless_config

There is one file that needs to be touched: `config.sh`

The variables in `config.sh` need to set to the Git `TAG` of the commit of the appropriate repository that will be 
included in the installer. The clueless_config itself will have to be tagged and committed. This tag _must_ be
in accordance to the debian installer version schema:

`<major>.<minor>-<revision>`

Where:
* `major`: a numeric value (0 -> skeletal, 1 -> minimal, 2 -> final delivery)
* `minor`: a numeric value (can be 1,..,9,10,11, incremented only when the system is stable)
* `revision`: an alphanumeric value (can be a word such as `demo`, `potato` or `dead_memes`)

This tag will be used as the `TAG_CONFIG` parameter for the Jenkins jobs.

## DEBIAN
The `DEBIAN` subdirectory defines the shell script that are ran when the Clueless package is installed on the Server.
* `control`: sets meta-information about the installer (i.e. version, package name, dependencies)
* `preinst`: runs before the package payload is installed on the system
* `postinst`: runs after the package payload is installed on the system
* `prerm`: runs before the package payload is removed from the system
* `postrm`: runs after the package payload is removed from the system

See Debian manual for more information: https://www.debian.org/doc/manuals/maint-guide/dother.en.html#maintscripts

## Jenkins Build Jobs
### BUILD_INSTALLER
http://jenkins.natelao.com:8080/job/Clueless/job/BUILD_INSTALLER/

#### Build Parameters
* `TAG_CONFIG`: The configuration tag from clueless_config. Must be formatted in the Debian version schema.
* `TAG_BUILDSCRIPT`: The tag for this revision of this repository (`Clueless`).

#### Description
This job builds the Clueless debian installer In the job, this repository is pulled according to its tag 
(`TAG_BUILDSCRIPT`) and the config repo is pulled with its tag (`TAG_CONFIG`). The script, buildscript.sh 
builds the debian installer directories:
```
/   
 `--opt/
    `-- clueless/
        |-- etc/
        |-- log/
        `-- src/
            |-- backend/
            |-- frontend/
            `-- serverside/
```
The buildscript then clones the Frontend, Serverside and Backend reposities according to the configuration
set in `config.sh`. The files that are in the repositories are then copied to the appropriate place in the build
directory. The `DEBIAN` subdirectory is then copied over. The installer is then built via the `dpkg-deb` command.

### DEPLOY_BUILD
http://jenkins.natelao.com:8080/job/Clueless/job/DEPLOY_BUILD/
#### Build Parameters
* `VM`: The Server name. Choices: `brian`, `freddie`, `john`, `roger`. (If `john`, then the job will use john.natelao.com)
* `TAG_CONFIG`: The configuration tag from clueless_config. Must be formatted in the Debian version schema.
* `TAG_BUILDSCRIPT`: The tag for this revision of this repository (`Clueless`).
* `TRANSFER`: If true, the job will wipe out all existing packages on the `VM` then transfer the newly built installer package to the `VM`.
* `INSTALL`: If true, the job will install the package on the `VM`. If `TRANSFER` is set to false in this case, the `VM`
will install whatever package already exists on the `VM`.
* `BOOTLOAD`: If true, the job will start up the Clueless Server on the `VM`.

#### Description
This build runs the `BUILD_INSTALLER` job with the provided `TAG_CONFIG` and `TAG_BUILDSCRIPT` parameters and collects
its artifacts (i.e. the Clueless debian installer). With the installer, it will `ssh` and `scp` to the `VM` and do one or
more of the following:
* inject the installer package (`TRANSFER`)
* install the package (`INSTALL`)
* run the server (`BOOTLOAD`)

### KILL_SERVER
_This job does not do anything because it is in work, do not use it._
