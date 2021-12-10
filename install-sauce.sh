#!/bin/bash

# SAUCE-OS INSTALL FROM SOURCE SCRIPT

# ADD COLOR TO SCRIPT

# Ansi color code variables
red="\e[0;91m"
blue="\e[0;94m"
expand_bg="\e[K"
blue_bg="\e[0;104m${expand_bg}"
red_bg="\e[0;101m${expand_bg}"
green_bg="\e[0;102m${expand_bg}"
green="\e[0;92m"
white="\e[0;97m"
bold="\e[1m"
uline="\e[4m"
reset="\e[0m"

# horizontally expanded backgrounds
echo -e "${blue_bg}${reset}"
echo -e "${red_bg}${reset}"
echo -e "${green_bg}${reset}"

echo ""

# colored text
echo -e "${red}Hello World!${reset}"
echo -e "${blue}Hello World!${reset}"
echo -e "${green}Hello World!${reset}"
echo -e "${white}Hello World!${reset}"

echo ""

# bold colored text
echo -e "${red}${bold}Hello World!${reset}"
echo -e "${blue}${bold}Hello World!${reset}"
echo -e "${green}${bold}Hello World!${reset}"
echo -e "${white}${bold}Hello World!${reset}"

echo ""

# underlined colored text
echo -e "${red}${uline}Hello World!${reset}"
echo -e "${blue}${uline}Hello World!${reset}"
echo -e "${green}${uline}Hello World!${reset}"
echo -e "${white}${uline}Hello World!${reset}"

echo ""

# ansi across multiple lines
echo -e "${green}This is a sentence across"
echo "three lines to show how an ansi color"
echo -e "works across multiple lines with echo.${reset}"
echo ""


# INTRODUCTION

echo ""
echo ""
echo ""
echo -e "${green}**********"
echo "*SAUCE-OS*"
echo "**********"
echo ""
echo "Because compiling source code yourself is more secure"
echo "than trusting that task to strangers."
echo ""
echo "Version: v1.0.0.1-ketchup"
echo ""
echo "**********************************************"
echo "*Welcome to the SauceOS source code installer*"
echo "**********************************************"
echo ""
echo "A key element of the security offered by Sauce is that"
echo "the system is transparently compiled from a live system"
echo "with source code pulled from the project's official"
echo "repositories at the time of installation."
echo ""
echo "IMPORTANT: Compiling is a VERY time consuming process and"
echo "may take more than a day to complete."
echo ""
echo "Even after installation, complete blockchains need"
echo "downloading to ensure transaction privacy and provide"
echo "network resilience and that can also take another"
echo "day or two."
echo ""
echo "Your hardware specs and internet speed will largely"
echo "determine how long it takes."
echo ""
echo "After the one time installing and syncing, Sauce is a"
echo "fast and responsive environment."
echo ""
echo "At every point where your response is needed, the text"
echo "will be blue,and a beep will sound to alert you if you"
echo "have your speekers turned up.${reset}"
echo ""
echo -c "${blue}HIT ENTER TO HEAR THE BEEP NOW${reset}"
read
echo -en "\007"
echo ""
echo ""
echo -c "${green}MINIMUM SYSTEM REQUIREMENTS"
echo ""
echo "Hard Drive Size"
echo ""
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxx 1Tb"
echo ""
echo "Processor type"
echo ""
echo "amd64 64-bit version runs on x86-64 based computers."
echo "By limiting the OS to this platform, SauceOS has the"
echo "ability to access over 4 gigabytes of memory when"
echo "availible, and supports the use of multiple processor"
echo "cores. This resolves unacceptably long compiling times"
echo -c "on older systems${reset}"
echo ""
echo ""
echo -c "${blue}IMPORTANT: THIS WILL RESULT IN ALL EXISTING DATA BEING"
echo "DELETED FROM THE COMPUTER YOU ARE INSTALLING SOURCE ON!!!"
echo
echo -c "Press enter when you're ready to continue...${reset}"
echo -en "\007"
read
echo ""
echo ""
echo ""
echo -c "${green}VPN SETUP REQUIRED AT THIS POINT"
echo ""
echo "A VPN is required to keep your installation of SourceOS"
echo "private. Also, while tor and i2p are used to secure the"
echo "contents of network traffic, others will know you use"
echo "those privacy networks, and that in of itself is an"
echo "invasion of privacy."
echo ""
echo "You can download a wireguard configuration file from your"
echo "own current VPN provider, or buy service from any VPN"
echo "service you like."
echo ""
echo "SauceOS STRONGLY RECOMMENDS paying for your VPN with"
echo "cryptocurrency if at all possible. Think reputation, not"
echo "cost. We highly recommend  mullvad.net - It meets all"
echo "the requirements.${reset}"
echo ""
echo -c "${blue}ACTION NEEDED"
echo ""
echo "Please open the chromium browser from the desktop icon"
echo "now, and login to your VPN providers website to download"
echo "your  wireguard configuration. You only want one. You can"
echo "always add others later. Make sure it is a wireguard conf"
echo "file and not an OpenVPN conf file as SauceOS does not"
echo "support OpenVPN."
echo ""
echo "STEP 1"
echo "Download the file into the Downloads folder."
echo ""
echo "STEP 2"
echo "Open the file explorer Dolphin from the desktop."
echo "STEP 3"
echo "Click on the Downloads folder"
echo "STEP 4."
echo "Right click on the configuration file you downloaded and"
echo "rename it wg-vpn.conf"
echo ""
echo "Once you have completed the above configuration steps..."
echo ""
echo "HIT ENTER TO TURN ON THE WIREGUARD VPN NOW${reset}"
echo -en "\007"
read
echo ""
echo ""
echo -c "${green}WIREGUARD VPN SETUP STARTED"
echo ""
echo ""
echo "Moving Wireguard VPN configuration file wgvpn.conf"
echo "from //home/redcore/Documents to //etc/wireguard"
mkdir //etc/wireguard/
mv /home/redcore/Downloads/wgvpn.conf /etc/wireguard/
echo ""
echo "You may replace the contents of the file with any other"
echo "wireguard configuration downloads contents at any time in"
echo "the installed system from the root user account."
echo ""
echo "Installing Wireguard VPN software"
emerge net-vpn/wireguard-modules
emerge net-vpn/wireguard-tools
echo "Turning on Wireguard VPN"
wg-quick up wgvpn
echo "The Wireguard VPN should be connected now."
echo ""
echo "Please confirm the connection by"
echo "clicking on the network icon in the bottom right corner"
echo "of the desktop.${reset}"
echo ""
echo -c "${blue}IMPORTANT: In the event that you are not connected to"
echo "the VPN, we would strongly advise you to quit (ctrl+C)"
echo "and try the installation again. Understand that your use of"
echo "privacy networks and cryptocurrency protocols will be"
echo "viewable on the clearnet for others to see."
echo ""
echo ""
echo "HIT ENTER NOW TO FORMAT THE HARD DRIVE AND START"
echo -c "THE INSTALL OF SAUCE-OS${reset}"
echo -en "\007"
read
echo ""
echo ""
echo ""
echo -c "${green}PREPARING HARD DRIVE"
echo ""
echo ""
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
echo ""
echo ""
echo "HARD DRIVE CONFIGURATION COMPLETE"
echo ""
echo ""
echo "Installing STAGE 3 tarball"
echo ""
cd /mnt/gentoo
wget https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/20211205T170532Z/stage3-amd64-desktop-openrc-20211205T170532Z.tar.xz
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner
echo ""
echo "Installing portage..."
cd /mnt/gentoo
wget http://gentoo.osuosl.org/snapshots/portage-latest.tar.xz
tar xvJpf stage3-amd64-*.tar.xz --xattrs-include='*.*' --numeric-owner
echo "Cleaning up..."
rm -f portage-latest.tar.bz2
rm -f stage3-amd64-desktop-openrc-20211205T170532Z.tar.xz
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
echo "Portage updated, downloading kernel source...${reset}"
sleep 2

echo "#!/bin/bash" > /mnt/gentoo/portage
echo 'USE="-doc symlink" emerge gentoo-sources' >> /mnt/gentoo/portage
chmod 700 /mnt/gentoo/portage
chroot /mnt/gentoo ./portage
rm -f /mnt/gentoo/portage

echo "#!/bin/bash" > /mnt/gentoo/portage
echo 'cd /usr/src/linux' >> /mnt/gentoo/portage
echo 'echo ""' >> /mnt/gentoo/portage
echo -c "${blue}"
echo "***************************************************"' >> /mnt/gentoo/portage
echo 'echo "**            KERNEL CONFIGURATION               **"' >> /mnt/gentoo/portage
echo 'echo "***************************************************"' >> /mnt/gentoo/portage
echo 'echo "* You will now be prompted with the linux kernel  *"' >> /mnt/gentoo/portage
echo 'echo "*menu configurator, please ensure that you specify*"' >> /mnt/gentoo/portage
echo 'echo "*the right settings, as once you exit this script *"' >> /mnt/gentoo/portage
echo 'echo "*will compile and install the new kernel          *"' >> /mnt/gentoo/portage
echo 'echo "***************************************************"' >> /mnt/gentoo/portage
echo 'echo ""' >> /mnt/gentoo/portage
echo -c "${reset}"
echo -c 'echo "Please press enter to continue"' >> /mnt/gentoo/portage
echo -en "\007"
echo 'read' >> /mnt/gentoo/portage
echo 'make menuconfig' >> /mnt/gentoo/portage
echo 'make && make modules_install' >> /mnt/gentoo/portage
echo 'cp arch/i386/boot/bzImage /boot/originalKernel' >> /mnt/gentoo/portage
echo 'echo ""' >> /mnt/gentoo/portage
chmod 700 /mnt/gentoo/portage
chroot /mnt/gentoo ./portage
rm -f /mnt/gentoo/portage

echo -c "${reset}"
echo -c "${green}Generating FSTAB{reset}"
#GENERATE FSTAB
echo "# /etc/fstab: static file system information." > /mnt/gentoo/etc/fstab
echo "#" >> /mnt/gentoo/etc/fstab
echo "# noatime turns off atimes for increased performance (atimes normally aren't" >> /mnt/gentoo/etc/fstab
echo "# needed. notail increases performance of ReiserFS at the expense of storage" >> /mnt/gentoo/etc/fstab
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
echo -c "${green}Configuring rc scripts{reset}"
chroot /mnt/gentoo rc-update add net.eth0 default
chroot /mnt/gentoo rc-update add sshd default
echo -c "${blue}*************** ROOT PASSWORD ********************"
echo "YOU ARE NOW REQUIRED TO ENTER A NEW ROOT PASSWORD "
echo "**************************************************{reset}"
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
echo -c "${blue}Live install complete"
echo ""
echo ""
echo "*****************************************************"
echo "*****************************************************"
echo "************** HIT ENTER TO REBOOT NOW **************"
echo "*****************************************************"
ECHO "** INSTALL WILL COMPLETE FROM NEW INSTALLED SYSTEM **"
echo "*****************************************************"
echo -c "*****************************************************${reset}"
echo -en "\007"
read
sleep 5
reboot
