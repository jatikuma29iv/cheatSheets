# Window Service Management

## Create
```cmd
sc create "new_svc_name" binPath= "path\of\new_svc\executable" DisplayName="svc name" 
start=auto
```

## Start
```cmd
sc start "new_svc_name"

```

## Stop
```cmd
sc stop "new_svc_name"
```

## Delete Remove
```cmd
sc delete "new_svc_name"
```

## Grant Access to user

1. Login as an administrator.
1. Download subinacl.exe from Microsoft:
http://www.microsoft.com/en-us/download/details.aspx?id=23510
1. Grant permissions to the regular user account to manage the BST services.
(subinacl.exe is in C:\Program Files (x86)\Windows Resource Kits\Tools\).
1. cd C:\Program Files (x86)\Windows Resource Kits\Tools\
subinacl /SERVICE \\MachineName\bst /GRANT=domainname.com\username=F or
subinacl /SERVICE \\MachineName\bst /GRANT=username=F
1. Logout and log back in as the user. They should now be able to launch the BST service.
