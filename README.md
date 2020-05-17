# EKS-ASP.NET-Core-3

Watch the walkthrough of this project on Twitch!

https://www.twitch.tv/videos/620610887

[![Twitch Video](https://github.com/enghwa/EKS-CICD-ASP.net/blob/master/DevAx%20Connect%20-%20EKS%20CICD%20ASP.NET%20Core%203%20Apps.png)](https://player.twitch.tv/?autoplay=false&video=620610887)

### Local build and run
```
docker build -t book .
docker run --name mysql -e MYSQL_ROOT_PASSWORD=password2 -d mysql:5.7 
docker build -t dbmigrate -f Dockerfile.DBMigrate .

# db setup and migrate
docker run -e ASPNETCORE_ENVIRONMENT=Development --link mysql:mysql dbmigrate  /bin/sh -c "dotnet ef migrations add CreateIdentitySchema && dotnet ef migrations add InitialCreate && dotnet ef database update"

# run the apps
docker run -it -p8080:5000 -e ASPNETCORE_ENVIRONMENT=Development  --link mysql:mysql book
```
