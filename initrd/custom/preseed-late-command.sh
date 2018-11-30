#!/bin/sh

# This script is invoked at the end of the install.
in-target sh -c 'echo "PermitRootLogin yes" >>/etc/ssh/sshd_config'
