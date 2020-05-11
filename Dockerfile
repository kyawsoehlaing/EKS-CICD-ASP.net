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

ENV USERNAME=appuser
ENV GROUP=grp
ENV HOME=/home/${USERNAME}
RUN mkdir -p ${HOME}

# Create a group and an user (system account) which will execute the app
RUN groupadd -r ${GROUP} &&\
    useradd -r -g ${GROUP} -d ${HOME} -s /sbin/nologin -c "Docker image user" ${USERNAME}


WORKDIR /app
COPY --from=build /app/BookWormClub/out ./
ENV ASPNETCORE_URLS http://*:5000

USER ${USERNAME}
ENTRYPOINT ["dotnet", "BookWormClub.dll"]