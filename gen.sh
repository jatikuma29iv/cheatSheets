#Tab navigation                                                 #vimdiff commands                                     #MAC Screenshot
gt            go to next tab                                    ]c :        - next difference                           cmd+shit+3                      screen to file
gT            go to previous tab                                [c :        - previous difference                       cmd+shit+ctrl+3                 screen to clipboard
{i}gt         go to tab in position i                           do          - diff obtain                               cmd+shit+4                      block to file
                                                                dp          - diff put                                  cmd+shit+ctrl+4                 block to clicpboard
:tabs         list all tabs including their displayed windows   zo          - open folded text                          cmd+shit+4 then spacebar        current window to file
:tabm 0       move current tab to first                         zc          - close folded text                         cmd+shit+ctrl+4 then spacebar   current window to clipboard                          :set fdm=[manual|indent|syntax]          zf     - to fold
:tabm         move current tab to last                          :diffupdate - re-scan the files for differences           
:tabm {i}     move current tab to position i+1                                                                               
                                                                #open files in tabs                                          
:tabn         go to next tab                                    vim -p file1 file2                                           
:tabp         go to previous tab                                                                                          
:tabfirst     go to first tab                                   #delete row mathing pattern                                                          
:tablast      go to last tab                                    :g/pattern/d (/d to delete)                               

#CLIPBOARD                                                      #background jobs
:w !pbcopy           :r !pbpaste                                 fg  bg  jobs

#partitioning
csrutil disable
diskutil list
sudo fdisk /dev/disk0
sudo gpt -r -vv show disk0
sudo gdisk /dev/disk0
sudo fsck_exfat -d /dev/disk0s4

sudo tcpdump -A -s 10240 -i en1 'ip dst 192.168.26.11 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)' | egrep --line-buffered "^........(GET |HTTP\/|POST |HEAD )|^[A-Za-z0-9-]+: " | sed 's/^........\(GET |HTTP\/|POST |HEAD \)/\n\1/g'

sudo tcpdump -A -s 10240 -i en1 '(ip src 192.168.26.14 or ip dst 192.168.26.14) and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)' | egrep --line-buffered "^........(GET |HTTP\/|POST |HEAD )|^[A-Za-z0-9-]+: " | sed 's/^........\(GET |HTTP\/|POST |HEAD \)/\n\1/g'
cat ess-myspace | egrep --line-buffered "^........(GET |HTTP\/|POST |HEAD )|^[A-Za-z0-9-]+: " | sed 's/^........\(GET |HTTP\/|POST |HEAD \)/\n\1/g' > ess-myspace.txt

#Start FTP server
sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist
#Stop FTP server
sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist

#Visual Studio
install-package –IncludePrerelease ina.webapi -v 1.0.0-beta
