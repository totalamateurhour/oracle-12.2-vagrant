#!/bin/sh


echo 'INSTALLER: Starting up'

# get up to date
yum upgrade -y

echo 'INSTALLER: System updated'

# fix locale warning
yum reinstall -y glibc-common
echo LANG=en_US.utf-8 >> /etc/environment
echo LC_ALL=en_US.utf-8 >> /etc/environment

echo 'INSTALLER: Locale set'

# install Oracle Database prereq packages
yum install -y oracle-database-server-12cR2-preinstall

echo 'INSTALLER: Oracle preinstall complete'

# create directories
mkdir /opt/oracle
chown oracle:oinstall -R /opt/oracle

echo 'INSTALLER: Oracle directories created'

# set environment variables
echo "export ORACLE_BASE=/opt/oracle" >> /home/oracle/.bashrc \
 && echo "export ORACLE_HOME=/opt/oracle/product/12.2.0.1/dbhome_1" >> /home/oracle/.bashrc \
 && echo "export ORACLE_SID=ORCLCDB" >> /home/oracle/.bashrc \
 && echo "export PATH=\$PATH:\$ORACLE_HOME/bin" >> /home/oracle/.bashrc

echo 'INSTALLER: Environment variables set'

# install Oracle
unzip /vagrant/linux*122*.zip -d /vagrant
su -l oracle -c "yes | /vagrant/database/runInstaller -silent -showProgress -ignorePrereq -waitforcompletion -responseFile /vagrant/ora-response/db_install.rsp"
/opt/oracle/oraInventory/orainstRoot.sh
/opt/oracle/product/12.2.0.1/dbhome_1/root.sh
rm -rf /vagrant/database

echo 'INSTALLER: Oracle installed'

ORACLE_HOME=/opt/oracle/product/12.2.0.1/dbhome_1

echo 'INSTALLER: Oracle installation fixed and relinked'

# create listener via netca
su -l oracle -c "netca -silent -responseFile /vagrant/ora-response/netca.rsp"
echo 'INSTALLER: Listener created'

# create database
su -l oracle -c "dbca -silent -createDatabase -responseFile /vagrant/ora-response/dbca.rsp"
echo 'INSTALLER: Database created'

sed '$s/N/Y/' /etc/oratab | sudo tee /etc/oratab > /dev/null
echo 'INSTALLER: Oratab configured'

# configure systemd to start oracle instance on startup
sudo cp /vagrant/scripts/oracle-rdbms.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable oracle-rdbms
sudo systemctl start oracle-rdbms
echo "INSTALLER: Created and enabled oracle-rdbms systemd's service"

echo 'INSTALLER: Installation complete'
