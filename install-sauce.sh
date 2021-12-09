#!/bin/bash

# SAUCE-OS INSTALL FROM SOURCE SCRIPT

# Intro

echo "Thanks for installing SauceOS from source code."
echo "Because source code is always best."
echo "A key element of the security offered by Sauce is that the system can be transparently and automatically compiled from the source code of the individual projects official repositories at the time of install. It is a VERY time consuming process and may take more than a day to complete. The good news is it is automated so you can go back to your main pc and check in the next day."
echo "Even after installation, complete blockchains need downloading to increase privacy and provide network resilience and that can also take another day or more."
echo "After the one time install and blockchains sync, Sauce is as fast and responsive environment."
echo "Not sure you are ready to commit that amount of time yet?"
echo "It's not too late to quit now and install the much faster binaries version from the desktop instead. Evaluate the system after it's synced and if you like it you can reinstall from source from the desktop item later."
echo "IMPORTANT: THIS NEXT STEP WILL RESULT IN ALL EXISTING DATA BEING DELETED FROM THE COMPUTER YOU ARE INSTALLING SAUCE ON!!!"
echo "Press enter only when you're ready to continue, or control c to exit."
read

# Configure Virtual Private Network

echo "A VPN is REQUIRED to keep your installation of SourceOS private. Also, while tor and i2p are used to secure the contents of network traffic, others will know you use those privacy networks, and that in of itself is an invasion of privacy."
echo "You can download a wireguard configuration file from your own current VPN provider, or buy service from any VPN service you like."
echo "SauceOS STRONGLY RECOMMENDS paying for your VPN with cryptocurrency. Think reputation, not cost. We highly recommend  mullvad.net - It meets all the requirements."
echo "ACTION NEEDED"
echo "Please open the chromium browser from the desktop icon now, and login to your VPN providers website to download your  wireguard configuration. You only want one. You can always add others later. Make sure it is a wireguard conf file and not an OpenVPN conf file as SauceOS does not support OpenVPN. Download it into the Downloads folder."
echo "Next, open the file explorer (Dolphin) and in the Downloads folder, right click on the file and rename it"
echo "wg-vpn.conf"
echo "Only hit enter to continue once you have completed the above configuration steps."
echo "HIT ENTER TO TURN ON THE WIREGUARD VPN NOW"
read
mkdir //etc/wireguard/
mv //home/redcore/Downloads/wgvpn.conf //etc/wireguard/
echo "Wireguard VPN configuration file wgvpn.conf moved from //home/redcore/Documents to //etc/wireguard"
echo "You may replace the contents of the file with any other wireguard configuration downloads contents at any time in the installed system from the root user account."
echo "Updating all packages"
emerge --sync
echo "Updating the package manager"
emerge --oneshot sys-apps/portage
echo "Installing Wireguard VPN software"
emerge net-vpn/wireguard-modules
emerge net-vpn/wireguard-tools
echo "Turning on Wireguard VPN"
wg-quick up wgvpn
echo "The Wireguard VPN should be connected now."
echo "Please confirm the connection by ;ppling for a popup in the bottom right corner of the desktop or clicking on the network icon there. Alternatively, scroll back above and read the text output of wg-quick."
echo "In the event that you are not connected to the VPN, we would strongly advise you to quit (control-C) and try again, or understand that your use of privacy networks and cryptocurrency are viewable on the clear net for others to see."
echo "HIT ENTER NOW TO FORMAT THE HARD DRIVE AND START THE INSTALL OF SAUCE-OS"
read

# Format hard disk

HDD="/dev/${sda}"
echo "p" | fdisk $HDD
echo -n "Generating fdisk operation file"
((i = 1))
while (( i < 3 ))
do
echo "d" >> fdisc.in
echo "$i" >> fdisc.in
((i += 1))
done
echo "d" 	>> fdisc.in	# Delete last sector
echo "n" 	>> fdisc.in	# New Partiton
echo "p" 	>> fdisc.in	# Primary
echo "1" 	>> fdisc.in	# Partion 1
echo "" 	>> fdisc.in	# default
echo "+32M" 	>> fdisc.in	# 32 MB size
echo "a" 	>> fdisc.in	# Set flag
echo "1" 	>> fdisc.in	# bootable
echo -n "."
echo "n" 	>> fdisc.in	# New Partion
echo "p" 	>> fdisc.in	# Primary
echo "2" 	>> fdisc.in	# Partion 2
echo "" 	>> fdisc.in	# default
echo "+512M" 	>> fdisc.in	# 512 MB size
echo "t" 	>> fdisc.in	# Set partition type
echo "2" 	>> fdisc.in	# Partition 2
echo "82" 	>> fdisc.in	# 82 = SWAP
echo -n "."
echo "n" 	>> fdisc.in	# New Partition
echo "p" 	>> fdisc.in	# Primary
echo "3" 	>> fdisc.in	# Partition 2
echo "" 	>> fdisc.in	# default
echo "" 	>> fdisc.in	# new Line
echo -n "."
echo "w" 	>> fdisc.in	# Write partion table
echo "q" 	>> fdisc.in	# Quit
echo ". Done"
# Execute file
echo "Executing fdisk script ..."
echo
fdisk $HDD < fdisc.in
#clean up
rm -f fdisc.in
echo ""
echo "Partions created"
echo "Applying filesystem to partitions"
mke2fs /dev/${HD_DEVICE}1
mke2fs -j /dev/${HD_DEVICE}3
mkswap /dev/${HD_DEVICE}2
echo "Activating swap partition"
swapon /dev/${HD_DEVICE}2
echo ""
echo "Mounting partitions"
mount /dev/${HD_DEVICE}3 /mnt/gentoo
mkdir /mnt/gentoo/boot
mount /dev/${HD_DEVICE}1 /mnt/gentoo/boot
echo "Installing STAGE 3"
echo ""
cd /mnt/gentoo
wget https://gentoo.osuosl.org/releases/amd64/autobuilds/current-stage3-amd64-desktop-openrc/stage3-amd64-desktop-openrc-20211205T170532Z.tar.xz
tar xvjpf stage3-amd64-desktop-openrc-20211205T170532Z.tar.xz
echo ""
echo "Installing portage..."
cd /mnt/gentoo
wget http://gentoo.osuosl.org/snapshots/portage-latest.tar.bz2
tar xvjf /mnt/gentoo/portage-latest.tar.bz2 -C /mnt/gentoo/usr
echo "Cleaning up..."
rm -f portage-latest.tar.bz2
rm -f stage3-x86-2006.1.tar.bz2
echo ""
echo "Getting ready to CHROOT"
cp -L /etc/resolv.conf /mnt/gentoo/etc/resolv.conf
mount -t proc none /mnt/gentoo/proc
mount -o bind /dev /mnt/gentoo/dev
echo "Chrooted"
echo "Updating portage..."
sleep 2
chroot /mnt/gentoo emerge --sync
echo "Patch portage..."
chroot /mnt/gentoo emerge portage
echo "Portage updated, downloading kernel source..."
sleep 2

echo "#!/bin/bash" > /mnt/gentoo/portage
echo 'USE="-doc symlink" emerge gentoo-sources' >> /mnt/gentoo/portage
chmod 700 /mnt/gentoo/portage
chroot /mnt/gentoo ./portage
rm -f /mnt/gentoo/portage

echo "#!/bin/bash" > /mnt/gentoo/portage
echo 'cd /usr/src/linux' >> /mnt/gentoo/portage
echo 'echo ""' >> /mnt/gentoo/portage
echo 'echo "***************************************************"' >> /mnt/gentoo/portage
echo 'echo "**            KERNEL CONFIGURATION               **"' >> /mnt/gentoo/portage
echo 'echo "***************************************************"' >> /mnt/gentoo/portage
echo 'echo "* You will now be prompted with the linux kernel  *"' >> /mnt/gentoo/portage
echo 'echo "*menu configurator, please ensure that you specify*"' >> /mnt/gentoo/portage
echo 'echo "*the right settings, as once you exit this script *"' >> /mnt/gentoo/portage
echo 'echo "*will compile and install the new kernel          *"' >> /mnt/gentoo/portage
echo 'echo "***************************************************"' >> /mnt/gentoo/portage
echo 'echo ""' >> /mnt/gentoo/portage
echo 'echo "Please press enter to continue"' >> /mnt/gentoo/portage
echo 'read' >> /mnt/gentoo/portage
echo 'make menuconfig' >> /mnt/gentoo/portage
echo 'make && make modules_install' >> /mnt/gentoo/portage
echo 'cp arch/i386/boot/bzImage /boot/originalKernel' >> /mnt/gentoo/portage
echo 'echo ""' >> /mnt/gentoo/portage
chmod 700 /mnt/gentoo/portage
chroot /mnt/gentoo ./portage
rm -f /mnt/gentoo/portage

echo "Generating FSTAB"
#GENERATE FSTAB
echo "# /etc/fstab: static file system information." > /mnt/gentoo/etc/fstab
echo "#" >> /mnt/gentoo/etc/fstab
echo "# noatime turns off atimes for increased performance (atimes normally aren't" >> /mnt/gentoo/etc/fstab
echo "# needed; notail increases performance of ReiserFS (at the expense of storage" >> /mnt/gentoo/etc/fstab
echo "# efficiency).  It's safe to drop the noatime options if you want and to" >> /mnt/gentoo/etc/fstab
echo "# switch between notail / tail freely." >> /mnt/gentoo/etc/fstab
echo "#" >> /mnt/gentoo/etc/fstab
echo "# The root filesystem should have a pass number of either 0 or 1." >> /mnt/gentoo/etc/fstab
echo "# All other filesystems should have a pass number of 0 or greater than 1." >> /mnt/gentoo/etc/fstab
echo "#" >> /mnt/gentoo/etc/fstab
echo "# See the manpage fstab(5) for more information." >> /mnt/gentoo/etc/fstab
echo "#" >> /mnt/gentoo/etc/fstab
echo "" >> /mnt/gentoo/etc/fstab
echo "# <fs>                  <mountpoint>    <type>          <opts>          <dump/pass>" >> /mnt/gentoo/etc/fstab
echo "" >> /mnt/gentoo/etc/fstab
echo "# NOTE: If your BOOT partition is ReiserFS, add the notail option to opts." >> /mnt/gentoo/etc/fstab
echo "/dev/${HD_DEVICE}1               /boot           ext2            noauto,noatime  1 2" >> /mnt/gentoo/etc/fstab
echo "/dev/${HD_DEVICE}3               /               ext3            noatime         0 1" >> /mnt/gentoo/etc/fstab
echo "/dev/${HD_DEVICE}2               none            swap            sw              0 0" >> /mnt/gentoo/etc/fstab
echo "#/dev/cdroms/cdrom0      /mnt/cdrom      iso9660         noauto,ro       0 0" >> /mnt/gentoo/etc/fstab
echo "#/dev/fd0               /mnt/floppy     auto            noauto          0 0" >> /mnt/gentoo/etc/fstab
echo "" >> /mnt/gentoo/etc/fstab
echo "# NOTE: The next line is critical for boot!" >> /mnt/gentoo/etc/fstab
echo "proc                    /proc           proc            defaults        0 0" >> /mnt/gentoo/etc/fstab
echo "" >> /mnt/gentoo/etc/fstab
echo "# glibc 2.2 and above expects tmpfs to be mounted at /dev/shm for" >> /mnt/gentoo/etc/fstab
echo "# POSIX shared memory (shm_open, shm_unlink)." >> /mnt/gentoo/etc/fstab
echo "# (tmpfs is a dynamically expandable/shrinkable ramdisk, and will" >> /mnt/gentoo/etc/fstab
echo "#  use almost no memory if not populated with files)" >> /mnt/gentoo/etc/fstab
echo "shm                     /dev/shm        tmpfs           nodev,nosuid,noexec     0 0" >> /mnt/gentoo/etc/fstab
cat /mnt/gentoo/etc/fstab
echo ""
echo "Configuring rc scripts"
chroot /mnt/gentoo rc-update add net.eth0 default
chroot /mnt/gentoo rc-update add sshd default
echo "*************** ROOT PASSWORD ********************"
echo "YOU ARE NOW REQUIRED TO ENTER A NEW ROOT PASSWORD "
echo "**************************************************"
chroot /mnt/gentoo passwd
echo "Installing tools..."
chroot /mnt/gentoo emerge syslog-ng vixie-cron slocate dhcpcd
chroot /mnt/gentoo rc-update add syslog-ng default
chroot /mnt/gentoo rc-update add vixie-cron
echo ""
echo ""
echo "Installing LILO"
chroot /mnt/gentoo emerge lilo
echo "boot=/dev/${HD_DEVICE}       # Install LILO in the MBR" >> /mnt/gentoo/etc/lilo.conf
echo "prompt                    # Give the user the chance to select another section" >> /mnt/gentoo/etc/lilo.conf
echo "timeout=50                # Wait 5 (five) seconds before booting the default section" >> /mnt/gentoo/etc/lilo.conf
echo "default=gentoo            # When the timeout has passed, boot the "gentoo" section" >> /mnt/gentoo/etc/lilo.conf
echo "" >> /mnt/gentoo/etc/lilo.conf
echo "# For non-genkernel users" >> /mnt/gentoo/etc/lilo.conf
echo "image=/boot/originalKernel" >> /mnt/gentoo/etc/lilo.conf
echo "        label=gentoo            # Name we give to this section" >> /mnt/gentoo/etc/lilo.conf
echo "        read-only               # Start with a read-only root. Do not alter!" >> /mnt/gentoo/etc/lilo.conf
echo "        root=/dev/${HD_DEVICE}3          # Location of the root filesystem" >> /mnt/gentoo/etc/lilo.conf
chroot /mnt/gentoo lilo
cd /
umount /mnt/gentoo/boot /mnt/gentoo/dev /mnt/gentoo/proc /mnt/gentoo
echo "Done"
echo "****************************"
echo "****************************"
echo "** SYSTEM WILL NOW REBOOT **"
echo "****************************"
echo "****************************"
sleep 5
reboot
