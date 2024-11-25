 FROM mcr.microsoft.com/dotnet/sdk:6.0 AS installer-env
 COPY ./bin/Release/net6.0/publish/ /home/site/wwwroot # this will copy published artifacts to wwwroot folder
 # To enable ssh & remote debugging on app service change the base image to the one below
 # FROM mcr.microsoft.com/azure-functions/dotnet:4-appservice
 FROM mcr.microsoft.com/azure-functions/dotnet:4
 ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
     AzureFunctionsJobHost__Logging__Console__IsEnabled=true

 ENV SB_Conn_String=<sb_connection_string>

 #added commands for custom access keys- part 2
 RUN mkdir /etc/secrets/
 ENV FUNCTIONS_SECRETS_PATH=/etc/secrets
 ENV AzureWebJobsSecretStorageType=Files
 ADD host_secrets.json /etc/secrets/host.json
 ADD HttpTrigger1_secrets.json /etc/secrets/httptrigger1.json
 # end of commands for custom access keys- part 2

 COPY --from=installer-env ["/home/site/wwwroot", "/home/site/wwwroot"]
