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

## Jobs/Messages

### Hangfire

[Schedule Background Jobs Using Hangfire in .NET Core](https://codeburst.io/schedule-background-jobs-using-hangfire-in-net-core-2d98eb64b196)

[Schedule Background Jobs Using Hangfire In ASP.NET Core](https://www.c-sharpcorner.com/article/schedule-background-jobs-using-hangfire-in-asp-net-core/#:~:text=Hangfire%20offers%20integrated%20web%20monitoring,for%20the%20required%20database%20schema.)


