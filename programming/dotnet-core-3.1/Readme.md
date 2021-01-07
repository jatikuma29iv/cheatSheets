# dotnet core 3.1
ref:
- [REST specs](../REST.specs)

## checklist
- Auth
- RBAC
- Query Params
- HATEOAS

|ref |desc |
|:-|:-|
|[.Net Core REST API](https://solidfish.com/dotnet-core-rest-api/) |provides checklist of best practices |

## boilerplates

## cheatSheet
```bash                                                     
dotnet new sln -n Chatty

dotnet new webapi -f net3.0 --no-https                      
   # takes name of current folder
dotnet new console -n microsoft.botsay -f net5.0            
   # -n app_name
   
dotnet new webapi -o Chatty.Api
dotnet sln add ./Chatty.Api/Chatty.Api.csproj
   
# ref: https://docs.microsoft.com/en-us/aspnet/core/security/enforcing-ssl?view=aspnetcore-3.1&tabs=visual-studio
# export cert
$ dotnet dev-certs https -ep %USERPROFILE%\.aspnet\https\aspnetapp.pfx -p <cryptic-password>
$ dotnet dev-certs https --trust

# run in 
$ ASPNETCORE_Kestrel__Certificates__Default__Password="<cryptic-password>" \
  ASPNETCORE_Kestrel__Certificates__Default__Path=/mnt/c/Users/user-name/.aspnet/https/aspnetapp.pfx \
  dotnet watch run
```

| http://localhost:5000 / https://localhost:5001 <br/>[5 ways to set the URLs for an ASP.NET Core app](https://andrewlock.net/5-ways-to-set-the-urls-for-an-aspnetcore-app/) | |
|-|-|
| - | - |
