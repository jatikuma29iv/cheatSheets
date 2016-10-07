#log with details                                                         #if you want to revert changes made 
#add '-p'                      #log with only filenames                   #to your working copy, do this:
  git log -p                     git log --name-status                      git checkout .
                                                                          
#Graph View                                                               #If you want to revert changes made to 
  git log --graph --all --date=relative --abbrev-commit --oneline         #the index (i.e., that you have added), 
  git log --graph --all --date=relative --abbrev-commit --decorate        #do this. Warning this will reset all of 
  git log --stat                                                          #your unpushed commits to master!:
                                                                            git reset
 #Show tags refs                                                          
   git show-ref --abbrev                                                  #If you want to revert a change that you 
                                                                          #have committed, do this:
 #Find commits yet to be applied to upstream                                git revert ...
   git cherry -v master (git cherry -v [upstream])                        
                                                                          #If you want to remove untracked files 
 #add to ignore list                                                      #(e.g., new files, generated files):
   git rm -r --cached bin                                                   git clean -f
                                                                          
 #ignore white space                                                      #Or untracked directories (e.g., new or 
   git diff -w (--ignore-all-space)                                       #automatically generated directories):
   git diff -b                                                              git clean -fd
   git diff --ignore-space-at-eol                 
   git diff --stat                                                        #get all updated from parent branch
                                                                            git rebase <branch>
  #git merge                                      
  :diffg LO      :diffg RE | diffu                                        #create zip/tar
                                                                            git archive mergeSushmaDBChanges2Develep --format=zip --output=../test.zip
  #ignore folder                                  
    git diff ver -- ':!path/to/ignore' 
                                                         
  #grep exclue dir                                
    grep –exclude-dir=\.git -rn “foo” .
