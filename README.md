# oracle-12.2-vagrant
A vagrant box that provisions Oracle Database 12c release 2 automatically, using Vagrant, an Oracle Linux 7.3 box and a shell script.

## Getting started
1. Clone this repository `git clone https://github.com/totalamateurhour/oracle-12.2-vagrant`
2. Download the Oracle Database 12c binaries linuxx64_12201_database.zip
from http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html and unzip to `database/`
3. Install Oracle VM VirtualBox
4. Install Vagrant
5. Run `vagrant up`
    6. The first time you run this it will provision everything and may take a while. Ensure you have a good internet connection!
7. Connect to the database.
8. You can shutdown the box via the usual `vagrant halt` and the start it up again via `vagrant up`.

## Connecting to Oracle
* Hostname: `localhost`
* Port: `1521`
* SID: `orcl`
* All passwords are `password`.

## Acknowledgements
Based on @steveswinsburg's work here: https://github.com/steveswinsburg/oracle12c-vagrant

## Other info

* If you need to, you can connect to the machine via `vagrant ssh`.
* You can `sudo su - oracle` to switch to the oracle user.
* The Oracle installation path is `/opt/oracle/`
* On the guest OS, the directory `/vagrant` is a shared folder and maps to wherever you have this file checked out.

## Known issues


