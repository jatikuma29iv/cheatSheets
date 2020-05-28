# k8s
```bash
# countdown
$ function countdn() { local i=$1; while [ "$i" -gt "0" ]; do printf "\r repeating after $i sec"; i=`expr $i - 1`; sleep 1; done; echo . }

# alias syntax highlighted less
$ alias cless="/usr/local/bin/ccat --color='always' | less -R"

# busypods
$ while true; do kubectl get pods -A --sort-by=.metadata.creationTimestamp | grep -v Running | grep -v Completed | tail -r; echo ""; countdn 60; done #getbusypods
```

# jx

## patches
```bash

```
