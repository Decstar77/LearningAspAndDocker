# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

#restore
COPY ["LearnDockerAndASP/LearnDockerAndASP.csproj", "LearnDockerAndASP/"]
RUN dotnet restore "LearnDockerAndASP/LearnDockerAndASP.csproj"

#build
COPY ["LearnDockerAndASP", "LearnDockerAndASP"]
RUN dotnet build "LearnDockerAndASP/LearnDockerAndASP.csproj" -c Release -o /app/build

# Stage 2: Publish
FROM build AS publish
RUN dotnet publish "LearnDockerAndASP/LearnDockerAndASP.csproj" -c Release -o /app/publish

# Stage 3: Run
FROM publish AS run
EXPOSE 3000
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LearnDockerAndASP.dll"]
