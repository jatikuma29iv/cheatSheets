# Spring

## Tutorials

1) installing in eclipse https://www.youtube.com/watch?v=sNX7YQ8Ev3I&t=140s

2) understanding of spring framework https://www.youtube.com/watch?v=6xB-uXqbOqo

3) Spring boot student-course example https://www.youtube.com/watch?v=YEEUn5JZ9t0

## Azure

### For Linux shell

```bash
[Get token]
TENANT_ID=55f0a13b-1f0f-4d5e-b590-91dc9f07e692
CLIENT_ID=cc8dc625-22aa-48ea-b8b9-46cfe8abe989
CLIENT_SECRET=pA2m/vDr4smSYhpujjYd9w2s+0vnAq3tKBj2QGYNpKw=
ENCODED_CLIENT_SECRET=`printf ${CLIENT_SECRET} | php -r 'echo urlencode(file_get_contents("php://stdin"));'`

TOKEN=`curl -X POST https://login.microsoftonline.com/${TENANT_ID}/oauth2/token \
  -d grant_type=client_credentials \
  -d client_id=${CLIENT_ID} \
  -d client_secret=${ENCODED_CLIENT_SECRET} \
  -d resource=https://graph.microsoft.com | jq -r .access_token`


# Decode TOKEN(JWT) whitch are composed of three parts. (dot-sepalated)
declare -a TOKEN_PART=()
TOKEN_PART=$(echo ${TOKEN}|tr '.' ' ')
for PART in ${TOKEN_PART[@]};
do
  echo ${PART}
  printf ${PART} | base64 -d | jq
done


[Get User Info & Image]

USER_ID=556f060d-cd48-4d5c-931c-a15eef1ee9d9
UPN=hyonemori@toyo-eng.com

curl -X GET https://graph.microsoft.com/v1.0/users/${USER_ID} \
 -H "Authorization: Bearer ${TOKEN}" | jq

curl -X GET https://graph.microsoft.com/v1.0/users/${UPN} \
 -H "Authorization: Bearer ${TOKEN}" | jq

# curl -X GET https://graph.microsoft.com/v1.0/users/${USER_ID}/photo/$value \
# -H "Authorization: Bearer ${TOKEN}" | jq

curl -X GET https://graph.microsoft.com/v1.0/users/${USER_ID}/photo/%24value \
 -H "Authorization: Bearer ${TOKEN}" > j.jpeg
```

#### For Powershell

```powershell
$TENANT_ID="55f0a13b-1f0f-4d5e-b590-91dc9f07e692"
$CLIENT_ID="cc8dc625-22aa-48ea-b8b9-46cfe8abe989"
$CLIENT_SECRET="pA2m/vDr4smSYhpujjYd9w2s+0vnAq3tKBj2QGYNpKw="

<#----- Get token -----#>
$TOKEN_RESULT = Invoke-RestMethod `
  -Uri "https://login.microsoftonline.com/${TENANT_ID}/oauth2/token" `
  -Method Post `
  -Body @{grant_type="client_credentials"; client_id="${CLIENT_ID}"; client_secret="${CLIENT_SECRET}"; resource="https://graph.microsoft.com"}
$TOKEN=$TOKEN_RESULT.access_token

$JWT = $TOKEN.Split(".")

$PAD = ""
if(0 -lt $JWT[1].Length %4) {$PAD="="*(4-($JWT[1].Length %4))}

ConvertFrom-Json([System.Text.Encoding]::Default.GetString([System.Convert]::FromBase64String($JWT[1] + $PAD)))


### Get user Info & image

$USER_ID="556f060d-cd48-4d5c-931c-a15eef1ee9d9"
$UPN="hyonemori@toyo-eng.com"
$IMAGE_FILE="C:\Users\hyonemori\Desktop\pict.jpeg"

<#----- Get user by id. -----#>
$USER_RESULT = Invoke-RestMethod `
  -Uri "https://graph.microsoft.com/v1.0/users/${USER_ID}" `
  -Method Get `
  -Headers @{Authorization="Bearer ${TOKEN}"}

$USER_RESULT

<#----- Get user by userPrincipalName. -----#>
$USER_RESULT_UPN = Invoke-RestMethod `
  -Uri "https://graph.microsoft.com/v1.0/users/${UPN}" `
  -Method Get `
  -Headers @{Authorization="Bearer ${TOKEN}"}

$USER_RESULT_UPN

Invoke-WebRequest `
  -Uri "https://graph.microsoft.com/v1.0/users/${USER_ID}/photo/%24value" `
  -Method Get `
  -Headers @{Authorization="Bearer ${TOKEN}"} `
  -OutFile $IMAGE_FILE
```
