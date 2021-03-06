yum -y update
yum -y install wget curl openssh-server

# Install root certificates
yum -y install ca-certificates

# Make ssh faster by not waiting on DNS
echo "UseDNS no" >> /etc/ssh/sshd_config

# Install the EPEL repo in order to install nss-mdns
yum -y install epel-release
yum -y install nss-mdns
