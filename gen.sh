# Jatin Kumar Copyright (C) 2016 - All Rights Reserved. See the LICENSE
# file at the top-level directory of this distribution 
# Author: Jatin Kumar <jatinkr@gmail.com>

#vim Tab navigation                              #vimdiff commands                     #MAC Screenshot
gt          go to next tab                       ]c :     - next difference            cmd+shit+3             screen to file
gT          go to previous tab                   [c :     - previous difference        cmd+shit+ctrl+3        screen to clipboard
{i}gt       go to tab in position i              do       - diff obtain                cmd+shit+4             block to file
:tabs       list all tabs including              dp       - diff put                   cmd+shit+ctrl+4        block to clicpboard
            their displ                          zo       - open folded text           cmd+shit+4 spacebar    current window to file
:tabm 0     move current tab to first            zc       - close folded text          cmd+shit+ctrl+4 space  window to clipboard
:tabm       move current tab to last             zf       - to fold
:tabm {i}   move current tab to position i+1     :diffu   - re-scan for diff           #Lock Screen
:tabn       go to next tab                                                             ctrl+Shift+Eject       lock Screen
:tabp       go to previous tab                   #enabling folding
:tabfirst   go to first tab                      :set fdm=[manual|indent|syntax]       #Win Screenshot
:tablast    go to last tab															   FN+Shift+F11           Capture Full Screen
																					   FN+Option+Shift+F11    Capture Front Window
                                                 #delete row mathing pattern           
vim -p file1 file2                               :g/pattern/d (/d to delete)

#CLIPBOARD                                       #background jobs
:w !pbcopy           :r !pbpaste                 fg  bg  jobs

#vim command mode shortcuts, add to .vimrc       #for vim powered  command window      #partitioning
cnoremap <C-a> <Home>                            q:                                    csrutil disable
cnoremap <C-e> <End>                                                                   diskutil list
cnoremap <C-p> <Up>                                                                    sudo fdisk /dev/disk0
cnoremap <C-n> <Down>                                                                  sudo gpt -r -vv show disk0
cnoremap <C-b> <Left>                                                                  sudo gdisk /dev/disk0
cnoremap <C-f> <Right>                                                                 sudo fsck_exfat -d /dev/disk0s4
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

sudo tcpdump -A -s 10240 -i en1 'ip dst 192.168.26.11 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)' | egrep --line-buffered "^........(GET |HTTP\/|POST |HEAD )|^[A-Za-z0-9-]+: " | sed 's/^........\(GET |HTTP\/|POST |HEAD \)/\n\1/g'

sudo tcpdump -A -s 10240 -i en1 '(ip src 192.168.26.14 or ip dst 192.168.26.14) and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)' | egrep --line-buffered "^........(GET |HTTP\/|POST |HEAD )|^[A-Za-z0-9-]+: " | sed 's/^........\(GET |HTTP\/|POST |HEAD \)/\n\1/g'
cat ess-myspace | egrep --line-buffered "^........(GET |HTTP\/|POST |HEAD )|^[A-Za-z0-9-]+: " | sed 's/^........\(GET |HTTP\/|POST |HEAD \)/\n\1/g' > ess-myspace.txt

#Start FTP server
sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist
#Stop FTP server
sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist

#enable telnet from cmd line
dism /online /Enable-Feature /FeatureName:TelnetClient

"Sync With Active Document"
Ctrl+[, S
Ctrl+[, Ctrl+S

./Ina.Logger/_CreateNewNuGetPackage/DoNotModify/NuGet.exe locals all -clear && \
    ./Ina.Logger/_CreateNewNuGetPackage/DoNotModify/NuGet.exe push ./Ina.Logger/bin/Debug/Ina.Logger.1.0.0-gamma.Debug.AnyCPU.nupkg -s https://bluestage.petrofac.com:443/nuget/ sbstgnhnXsgGguto && \
    ./Ina.Logger/_CreateNewNuGetPackage/DoNotModify/NuGet.exe push ./Ina.Logger/bin/Release/Ina.Logger.1.0.0-gamma.Release.AnyCPU.nupkg -s https://bluestage.petrofac.com:443/nuget/ sbstgnhnXsgGguto

./Ina.WebApi/_CreateNewNuGetPackage/DoNotModify/NuGet.exe locals all -clear && \
    ./Ina.WebApi/_CreateNewNuGetPackage/DoNotModify/NuGet.exe push ./Ina.WebApi/bin/Ina.WebApi.1.0.0-gamma.Debug.AnyCPU.nupkg -s https://bluestage.petrofac.com:443/nuget/ sbstgnhnXsgGguto && \
    ./Ina.Logger/_CreateNewNuGetPackage/DoNotModify/NuGet.exe push ./Ina.Logger/bin/Ina.WebApi.1.0.0-gamma.Release.AnyCPU.nupkg -s https://bluestage.petrofac.com:443/nuget/ sbstgnhnXsgGguto
	
	get-package | uninstall-package -removedependencies -force
	
	CreateNewNuGetPackageFromProjectAfterEachBuild -v 1.8.9
	log4net -v 2.0.8
	

	155131 travel

#configuration
EmailSubject':'error/QA(APP006)/OneAPI/&lt;!--ULogId--&gt;','EmailTo':'jatin@techjini.com

EmailSubject':'error/Staging(Demo)/OneAPI/&lt;!--ULogId--&gt;','EmailTo':'jatin@techjini.com

copy /y "$(ProjectDir)index.$(ConfigurationName).html" "$(ProjectDir)index.html"
copy /y "$(ProjectDir)Json\OneAPICMS.$(ConfigurationName).json" "$(ProjectDir)Json\OneAPICMS.json"
	
#powershell
Invoke-WebRequest -UseBasicParsing https://pfcapi.petrofac.com/api/fieldvisit/V1.0/UserDetail -ContentType "application/json" -Method POST -Body "{'email_id': 'test_bpemp1@petrofac.com'}"

#power Invoke-WebRequest with headers
 $headers = @{}
 $headers.Add("Accept-Encoding","gzip")
 $headers.Add("User-Agent","(Linux;Android 6.0)")
 Invoke-WebRequest -Uri "https://pfcapi.petrofac.com/api/HSSE/V1.0/Submission/Document/Download/2406615e-3b19-4637-9f37-8f88c82662c3/VID_20170921_141528439.mp4" -Headers $headers -OutFile "xxx.mp4"
 
 
#Wifi
boardmeeting passwd: epl2015#

#Line of Code Loc
## C#
### Loc
grep -r --include='*.cs' --exclude='*TemporaryGeneratedFile*' --exclude-dir="Service References" -v "^\s*$\|^\S*\s*[/*]" . | wc -l
269415

### files processed
grep -lr --include='*.cs' --exclude='*TemporaryGeneratedFile*' --exclude-dir="Service References" -v "^\s*$\|^\S*\s*[/*]" . | wc -l

## Angular
### files processed
find . | grep "^[^ ]*/app/[^ ]*js$" | grep -v "^[^ ]*app/js/[^ ]*js$" | grep -v "^[^ ]*modules/shared[^ ]*js$" | xargs grep -lv "^\s*$\|^\S*\s*[/*]" | less

### Loc
find . | grep "^[^ ]*/app/[^ ]*js$" | grep -v "^[^ ]*app/js/[^ ]*js$" | grep -v "^[^ ]*modules/shared[^ ]*js$" | xargs grep -v "^\s*$\|^\S*\s*[/*]" | wc -l