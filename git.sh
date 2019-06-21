# Jatin Kumar Copyright (C) 2016 - All Rights Reserved. See the LICENSE
# file at the top-level directory of this distribution 
# Author: Jatin Kumar <jatinkr@gmail.com>


# checking in changes
  git add .                        # to select files for checkin
  git commit -m 'write you comment here'
  git push                         # if branch is already pushed
  #else
  git push -u origin <branchname>  #if branch is newly created


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
    #suppose you want to merge your branch `xyz`
    # to master
      # commit your code to your branch
      git checkout master              #step 1
      git merge xyz                    #step 2

  #removing conflicts
  git mergeool

  :diffg LO      :diffg RE | diffu                                        #create zip/tar
                                                                            git archive mergeSushmaDBChanges2Develep --format=zip --output=../test.zip
  #ignore folder           								
    git diff ver -- ':!path/to/ignore' 					git clone git://github.com/foo/bar.git
                                                        cd bar
  #submodules
    # for fresh clone
    git submodule update --init [--recursive | libs/hoge ]

    # for checking out correct versions in submodule
    git submodule update

    #
    git submodule foreach git checkout [branch]

  #grep exclue dir                                
    grep –exclude-dir=\.git -rn “foo” .

#global defaults                                                          #delete local branch                        #delte tags
git config --global diff.tool vimdiff                                     git branch -d <branchname>                  git tag -d 12345
git config --global difftool.prompt false                                                                             git push origin :refs/tags/12345
git config --global alias.d difftool                                      #delete remote branch
                                                                          git push origin --delete <branchname>
                                                                          git push origin :<branchname>
git config merge.tool vimdiff
git config merge.conflictstyle diff3
git config mergetool.prompt false

#Nuget Push
-s https://bluestage.petrofac.com:443/nuget/ sbstgnhnXsgGguto

#tagging
  # add tag with comment/annotation                   #push all tags
  git tag -a v1.2.0 -m "add comment"                  git push --tags
  
  #tagging later                                      #push single tags
  git log --pretty=oneline // and get hash#           git push origin <tag_name>
  git tag -a v1.2.0 9fceb02
  
  #list tag
  git tag
  git tag -l "v1.0.*"

  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
| MIGRATING A DIRECTORY INTO A NEW REPOSITORY WITH HISTORY                                                            |
                                                                                                                       
| CONSTRAINTS                                                                                                         |
  - - - - - -                                                                                                          
| * Git repo A contains other directories that we don’t want to move.                                                 |
  * We’d like to perserve the Git commit history for the directory we are moving.                                      
|                                                                                                                     |
  FILTER BRANCH THE SUBDIRECTORY                              |                                                        
| cd to root folder of your repository and                                                                            |
  issue the follow commands:                                  |                                                        
|   git remote rm origin                                                                                              |
    git filter-branch --subdirectory-filter <dir 1> -- --all  |   git clone repository B                               
|   git reset --hard                                              cd repository B                                     |
    git gc --aggressive                                       |   git remote add repo-A-branch <git rep A dir>         
|   git prune                                                     git pull repo-A-branch master                       |
                                                              |   git remote rm repo-A-branch                          
|   git clone repository B                                        git remote add origin git <repo-A-branch-git-path>  |
    cd repository B                                           |                                                        
|   git remote add repo-A-branch <git rep A dir>                this creates new branch in repository B               |
    git pull repo-A-branch master                             | on merging repo B branch with repo A 'refusing to      
|   git remote rm repo-A-branch                                 merge unrelated histories' will occur                 |
    git remote add origin git <repo-A-branch-git-path>        | use                                                    
|                                                                   git merge --allow-unrelated-histories             |
  this creates new branch in repository B                     | to merge repo-B branch to repa-A                       
| on merging repo B branch with repo A 'refusing to                                                                   |
  merge unrelated histories' will occur                       |                                                        
| use                                                                                                                 |
      git merge --allow-unrelated-histories                   |                                                        
| to merge repo-B branch to repa-A                                                                                    |
  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# How to create and apply a patch with Git
# https://ariejan.net/2009/10/26/how-to-create-and-apply-a-patch-with-git/
  git format-patch master --stdout > fix_empty_poster.patch
  git apply --stat fix_empty_poster.patch // to see patch status
  git apply --check fix_empty_poster.patch // to test the patch
  git am --signoff < fix_empty_poster.patch // apply the patch
  
# Three way compare manually


## How to add more to Git Bash on Windows
[https://gist.github.com/evanwill/0207876c3243bbb6863e65ec5dc3f058](https://gist.github.com/evanwill/0207876c3243bbb6863e65ec5dc3f058)

  git show <commit/branch/ref>:<file/path> > <outputfile>
  
  export LOCAL="PetroceptDc/PetroceptDc.WebApi/App_Start/WebApiConfig.cs" && git show e805ddc:"$LOCAL" > REMOTE && git show 821dc38:"$LOCAL" > BASE &&  diff3 "$LOCAL" BASE REMOTE -m | sed 's/^M$//' > OUT && vim -d -c "wincmd J" OUT "$LOCAL" BASE REMOTE -c 'set diffopt+=iwhite'

blueprint-directive-menubar> git init
blueprint-directive-menubar> git remote add ssh://git@techjini.repositoryhosting.com/techjini/blueprint-directive-menubar.git
Edit .gitignore
/node_modules
/.tmp
/.sass-cache
/bower_components
/.tmp
*.sw?
[note: do not add dist folder to .gitignore]

blueprint-directive-menubar> git add .
blueprint-directive-menubar> git commit -a
blueprint-directive-menubar> git push -u origin master
