SauceOS

The Sauce operating system is a resiliant anonymous cryptocurrency platform.
The included application suite of completely decentralized peer-to-peer software works together to acheive the purchase, storage, exchange and spending of cyptocurrency even when common centralized services become unavailible at the least convenient time.

The security of SourceOS is rooted in it's architecture. By compiling source code from project repositories directly at the time of installation trust is greatly improved, but at the cost of VERY long installation times.

Requirements

1. A 64 bit PC with a minimum hard drive size of 1Tb, ideally 2Tb to avoid future issues with blockchain size growing too large.
2. A Gentoo "Minimal Installation CD" Live OS on a USB to initially boot the computer. The iso file can be downloaded from the  gentoo.org website. Etcher from Balena.io can be used for creating the USB drive with the file.

Installation

First, boot the PC with the Gentoo Live USB then instal as folows...

git clone https://github.com/sauceos/sauceos.git
cd sauceos
chmod +x sauceos-install.sh
./sauceos-install.sh

Now, watch in real time as the entire system is (very slowly) compiled from source. After a day or so when the install is complete, reboot and wait another couple of days for the blockchains to sync. After that one time process, you are free to enjoy a fast and reliable boot into the system.
