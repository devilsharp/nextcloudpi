#!/bin/bash

# Batch creation of NextCloudPi image
# Tested with 2017-03-02-raspbian-jessie-lite.img
#
# Copyleft 2017 by Ignacio Nunez Hernanz <nacho _a_t_ ownyourbits _d_o_t_ com>
# GPL licensed (see end of file) * Use at your own risk!
#
# Usage:
#


IP=$1                   # First argument is the QEMU Raspbian IP address
IMG=$2                  # TODO

IMG=NextCloudPi_03-13-17.img

NO_CONFIG=1 NO_HALT_STEP=1 ./install-nextcloud.sh     $IP
NO_CONFIG=1 NO_CFG_STEP=1  ./installer.sh fail2ban.sh $IP $( ls -1t *.img | head -1 )
NO_CONFIG=1 NO_CFG_STEP=1  ./installer.sh no-ip.sh    $IP $( ls -1t *.img | head -1 )  
NO_CONFIG=1 NO_CFG_STEP=1  ./installer.sh dnsmasq.sh  $IP $( ls -1t *.img | head -1 ) 
#TODO rename to FULL

# License
#
# This script is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This script is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this script; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place, Suite 330,
# Boston, MA  02111-1307  USA
