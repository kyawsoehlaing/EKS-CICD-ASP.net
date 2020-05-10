# EKS-ASP.NET-Core-3

### Local build and run
```
docker build -t book .
docker run --name mysql -e MYSQL_ROOT_PASSWORD=password2 -d mysql:5.7 
docker run -it -p8080:5000 -e ASPNETCORE_ENVIRONMENT=Development  --link mysql:mysql book

```
