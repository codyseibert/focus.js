#!/bin/bash
rm -rf /vagrant/modules || true
mkdir /vagrant/modules

cd /vagrant
/usr/local/share/gems/gems/r10k*/bin/r10k puppetfile install -v
ln -s /vagrant /vagrant/modules/{{puppetName}}
cd /
puppet apply --modulepath=/vagrant/modules -e "include {{puppetName}}::role::prod"
