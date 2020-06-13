
# Dual Boot Linux on Mac
## Plan
```
ext4      LinuxData   ~50GB
ext4      Ubuntu       14GB
ext4      CentOS       14GB
ext4      ALPINE       9GB
FAT       Installer   ~8GB
SWAP                   4GB
EFI       Linux_EFI   ~150Mb
```

### Understanding Bootloader
#### EFI

On the `EFI System` partition, Grub installs `/EFI/grub/grubx64.efi`. If the `EFI` firmware is old, then it looks for `/efi/boot/bootx64.efi`

On Mac the Partition type it GPT. My Mac used UEFI firmware. So the plan is to use grub2-efi boot loader. This will be installed on Ubuntu partition.
To install `grub efi` on `alpine` partition, the `alpine` `system partition` should be formatted using `xfs` or `ext2` type. 

## Step 1
From `Disk Util` create 110GB partition. The scheme will look like this:
```bash
$ sudo gpt -vv -r show disk0 && diskutil list disk0 && sudo gdisk -l /dev/disk0
gpt show: disk0: mediasize=500107862016; sectorsize=512; blocks=976773168
gpt show: disk0: Suspicious MBR at sector 0
gpt show: disk0: Pri GPT at sector 1
gpt show: disk0: Sec GPT at sector 976773167
      start       size  index  contents
          0          1         MBR
          1          1         Pri GPT header
          2         32         Pri GPT table
         34          6
         40     409600      1  GPT part - C12A7328-F81F-11D2-BA4B-00A0C93EC93B
     409640  761519736      2  GPT part - 48465300-0000-11AA-AA11-00306543ECAC
  761929376    1269536      3  GPT part - 426F6F74-0000-11AA-AA11-00306543ECAC
  763198912  213312072      4  GPT part - EBD0A0A2-B9E5-4433-87C0-68B6B72699C7
  976510984     262151
  976773135         32         Sec GPT table
  976773167          1         Sec GPT header
/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *500.1 GB   disk0
   1:                        EFI EFI                     209.7 MB   disk0s1
   2:                  Apple_HFS Macintosh HD            389.9 GB   disk0s2
   3:                 Apple_Boot Recovery HD             650.0 MB   disk0s3
   4:       Microsoft Basic Data LINUX                   109.2 GB   disk0s4
GPT fdisk (gdisk) version 1.0.1

Warning: Devices opened with shared lock will not have their
partition table automatically reloaded!
Partition table scan:
  MBR: hybrid
  BSD: not present
  APM: not present
  GPT: present

Found valid GPT with hybrid MBR; using GPT.
Disk /dev/disk0: 976773168 sectors, 465.8 GiB
Logical sector size: 512 bytes
Disk identifier (GUID): 00002F53-53FC-0000-595B-00003A6B0000
Partition table holds up to 128 entries
First usable sector is 34, last usable sector is 976773134
Partitions will be aligned on 8-sector boundaries
Total free space is 262157 sectors (128.0 MiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1              40          409639   200.0 MiB   EF00  EFI system partition
   2          409640       761929375   363.1 GiB   AF00  Customer
   3       761929376       763198911   619.9 MiB   AB00
   4       763198912       976510983   101.7 GiB   0700
```

## Step 2
Create Partition
```bash
$ sudo gdisk /dev/disk0
#print table
p
# delete 4th partition
d
4
# create new partition
n
4
#press enter to choose default start sector
<ENTER>
# give size in GB
+50G
.
. repeate to add all partitions

p # print
w # write
y # confirm write
```

New partition will look like this:
```bash
$ sudo gpt -vv -r show disk0 && diskutil list disk0 && sudo gdisk -l /dev/disk0
gpt show: disk0: mediasize=500107862016; sectorsize=512; blocks=976773168
gpt show: disk0: Suspicious MBR at sector 0
gpt show: disk0: Pri GPT at sector 1
gpt show: disk0: Sec GPT at sector 976773167
      start       size  index  contents
          0          1         MBR
          1          1         Pri GPT header
          2         32         Pri GPT table
         34          6
         40     409600      1  GPT part - C12A7328-F81F-11D2-BA4B-00A0C93EC93B
     409640  761519736      2  GPT part - 48465300-0000-11AA-AA11-00306543ECAC
  761929376    1269536      3  GPT part - 426F6F74-0000-11AA-AA11-00306543ECAC
  763198912  104857600      4  GPT part - 933AC7E1-2EB4-4F13-B844-0E14E2AEF915
  868056512   29360128      5  GPT part - 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709
  897416640   29360128      6  GPT part - 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709
  926776768   20971520      7  GPT part - 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709
  947748288   16777216      8  GPT part - EBD0A0A2-B9E5-4433-87C0-68B6B72699C7
  964525504    9437184      9  GPT part - 0657FD6D-A4AB-43C4-84E5-0933C84B4F4F
  973962688     409600     10  GPT part - C12A7328-F81F-11D2-BA4B-00A0C93EC93B
  974372288    2400847
  976773135         32         Sec GPT table
  976773167          1         Sec GPT header

/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *500.1 GB   disk0
   1:                        EFI EFI                     209.7 MB   disk0s1
   2:                  Apple_HFS Macintosh HD            389.9 GB   disk0s2
   3:                 Apple_Boot Recovery HD             650.0 MB   disk0s3
   4: 933AC7E1-2EB4-4F13-B844-0E14E2AEF915               53.7 GB    disk0s4
   5: 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709               15.0 GB    disk0s5
   6: 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709               15.0 GB    disk0s6
   7: 4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709               10.7 GB    disk0s7
   8:       Microsoft Basic Data                         8.6 GB     disk0s8
   9:                 Linux Swap                         4.8 GB     disk0s9
  10:                        EFI                         209.7 MB   disk0s10
GPT fdisk (gdisk) version 1.0.1

Warning: Devices opened with shared lock will not have their
partition table automatically reloaded!
Partition table scan:
  MBR: hybrid
  BSD: not present
  APM: not present
  GPT: present

Found valid GPT with hybrid MBR; using GPT.
Disk /dev/disk0: 976773168 sectors, 465.8 GiB
Logical sector size: 512 bytes
Disk identifier (GUID): 00002F53-53FC-0000-595B-00003A6B0000
Partition table holds up to 128 entries
First usable sector is 34, last usable sector is 976773134
Partitions will be aligned on 8-sector boundaries
Total free space is 2400853 sectors (1.1 GiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1              40          409639   200.0 MiB   EF00  EFI system partition
   2          409640       761929375   363.1 GiB   AF00  Customer
   3       761929376       763198911   619.9 MiB   AB00
   4       763198912       868056511   50.0 GiB    8302  Linux /home
   5       868056512       897416639   14.0 GiB    8304  Linux x86-64 root (/)
   6       897416640       926776767   14.0 GiB    8304  Linux x86-64 root (/)
   7       926776768       947748287   10.0 GiB    8304  Linux x86-64 root (/)
   8       947748288       964525503   8.0 GiB     0700  Microsoft basic data
   9       964525504       973962687   4.5 GiB     8200  Linux swap
  10       973962688       974372287   200.0 MiB   EF00  EFI System
```
	
## Installing using VirtualBox
- Run VirtualBox as Super User
- know partition number
	
```bash
VBoxManage internalcommands createrawvmdk -filename Linux.vmdk -rawdisk /dev/disk0 -partitions 4,5,6,7,8,9,10
```

## Alpine Linux Installation


https://wiki.alpinelinux.org/wiki/Installation


https://wiki.alpinelinux.org/wiki/Installing_Alpine_on_HDD_dualbooting


https://wiki.alpinelinux.org/wiki/Install_to_disk


https://wiki.alpinelinux.org/wiki/Setting_up_a_laptop

## Steps to install

```bash
# get partition number
$ fdisk /dev/sda

# create file system
$ apk add e2fsprogs
$ mkfs.ext4 /dev/sda4
$ mkfs.ext4 /dev/sda7
$ mkswap /dev/sda10
$ msfs.vfat /dev/sda9
$ apk del e2fsprogs

# create mount point for ESP
$ mkdir /esp

# mount / for installation
mount -t ext4 /dev/sda7 /mnt

# Basic setup
$ setup-timezone
$ setup-alpine -q
$ setup-sshd
$ setup-ntp

# Install Alpine
$ setup-disk -m sys /mnt
```

### Bootloader

#### UEFI

##### Create ESP Partition
[ESP](#anc-esp-specs) (`EFI System Partition`)
https://apple.stackexchange.com/questions/207639/how-to-change-the-gpt-partition-type-of-an-efi-partition/342139

## Fixing MBR Tables on iMac or MBP Triple Boot Setups
[https://jonsview.com/fixing-mbr-tables-on-imac-or-mbp-triple-boot-setups](https://jonsview.com/fixing-mbr-tables-on-imac-or-mbp-triple-boot-setups)


## Dual Booting Reference
- [How to Install and Dual Boot Linux and Mac OS](https://www.lifewire.com/dual-boot-linux-and-mac-os-4125733)
	- Very detailed guide
- [How to Install Ubuntu 12.10 In Macbook Air](https://www.maketecheasier.com/install-ubuntu-12-10-in-macbook-air/)
	- Another guide

## Connecting to a wireless access point
[https://wiki.alpinelinux.org/wiki/Connecting_to_a_wireless_access_point#Broadcom_Wi-Fi_Chipset_Users](https://wiki.alpinelinux.org/wiki/Connecting_to_a_wireless_access_point#Broadcom_Wi-Fi_Chipset_Users)

## Install Software
```bash
$ apk add wireless-tools wpa_supplicant
$ apk add screen git 
```

## Install Docker
edit the  **/etc/apk/repositories**  file to add (or uncomment) a line like: `[http://dl-cdn.alpinelinux.org/alpine/latest-stable/community](http://dl-cdn.alpinelinux.org/alpine/latest-stable/community)`

## Troubleshooting
- [Virtualbox fail to bootup guest from GPT physical partition](https://stackoverflow.com/questions/34371180/virtualbox-fail-to-bootup-guest-from-gpt-physical-partition)
- [Tools and References for the  MBR and OS Boot Records  (and GPT, EFI/UEFI too)!](https://thestarman.pcministry.com/asm/mbr/BootToolsRefs.htm)
-  [Corrupted GUID partition table on secondary hard drive](https://apple.stackexchange.com/questions/290705/corrupted-guid-partition-table-on-secondary-hard-drive)

## My Alpine Desktop - Setting Up a Software Development Environment on Alpine Linux
[https://blog.overops.com/my-alpine-desktop-setting-up-a-software-development-environment-on-alpine-linux/](https://blog.overops.com/my-alpine-desktop-setting-up-a-software-development-environment-on-alpine-linux/)

## Notes

### ESP
#### <a name="anc-esp-specs"></a>Specs
The  _EFI SYSTEM PARTITION_  (see  [UEFI](http://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface)  and  [EFI System partition](http://en.wikipedia.org/wiki/EFI_System_partition))  is frequently known as "$ESP". The most commonly supported filesystem format for $ESP is FAT32, although the UEFI specs allow for others too. Each firmware might recognize additional / different / several filesystems for $ESP  (e.g. other FAT variants, UDF, HPF+, NTFS,...).Adding Bootloader
[https://wiki.alpinelinux.org/wiki/Bootloaders](https://wiki.alpinelinux.org/wiki/Bootloaders)

[https://wiki.archlinux.org/index.php/GRUB#GUID_Partition_Table_(GPT)_specific_instructions](https://wiki.archlinux.org/index.php/GRUB#GUID_Partition_Table_(GPT)_specific_instructions)

[https://wiki.alpinelinux.org/wiki/Create_A_VirtualBox_Guest_with_Grub_and_XFS](https://wiki.alpinelinux.org/wiki/Create_A_VirtualBox_Guest_with_Grub_and_XFS)
