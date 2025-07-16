#!/bin/bash

#@author: Patrick Siandji
#Date: 15/07/2025

# This Install.sh script will be use to setup the local environment 
# for the Developper.
# It install on local environment: 
# 
#   -> opentofu
#   -> libvirt , virt_manager, cockpit, Qemu_KVM
#   -> Ansible
# 



#activate the venv
source .venv/bin/activate


#################################################################################
#           Install Opentofu                                                    #
#################################################################################


OPENTOFU_URL='https://get.opentofu.org/install-opentofu.sh'
OPENTOFU_INSTALL_SCRIPT_FILE='install-opentofu.sh'

# Download the installer script:
curl --proto '=https' --tlsv1.2 -fsSL ${OPENTOFU_URL} -o ${OPENTOFU_INSTALL_SCRIPT_FILE}
# Alternatively: wget --secure-protocol=TLSv1_2 --https-only https://get.opentofu.org/install-opentofu.sh -O install-opentofu.sh

# Give it execution permissions:
chmod +x ${OPENTOFU_INSTALL_SCRIPT_FILE}

# Please inspect the downloaded script

# Run the installer:
'./'${OPENTOFU_INSTALL_SCRIPT_FILE} --install-method deb

# Remove the installer:
rm -f ${OPENTOFU_INSTALL_SCRIPT_FILE}


# Export tofu binary into .venv
export PATH="/usr/bin/tofu:$PATH"


#################################################################################
#           Install KVM , QEMU, Libvirt, Cockpit, Virtmanager                   #
#################################################################################


sudo apt install -y libvirt-daemon-system    \
                    virt-manager             \
                    qemu-kvm                 \
                    libvirt-clients          \
                    cockpit cockpit-machines \



#################################################################################
#           Install Ansible                                                     #
#################################################################################

sudo apt install -y python3-pip
pip install --include-deps ansible
