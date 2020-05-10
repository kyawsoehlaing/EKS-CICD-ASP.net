FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY src/*.sln .
COPY src/BookWormClub/*.csproj ./BookWormClub/
RUN dotnet restore

# copy everything else and build app
COPY src/BookWormClub/. ./BookWormClub/
WORKDIR /app/BookWormClub
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=build /app/BookWormClub/out ./
ENV ASPNETCORE_URLS http://*:5000
ENTRYPOINT ["dotnet", "BookWormClub.dll"]