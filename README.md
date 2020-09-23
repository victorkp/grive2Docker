# grive2Docker
Docker Container for [grive2](https://github.com/vitalif/grive2).

This will sync all Drive account's folders and files to a path specified

This container's snapshot tag will be built automatically on docker hub every 1st of the month based on the master branch of grive2. 


# Installation

```
docker pull agusalex/grive2 
```
# Drive Setup
- Go to https://console.developers.google.com/apis/library. Login with your Google account and create a new project on Google Cloud Platform. You can also use an existing one.
- Search for Google Drive API and enable it.
- Go to API Credentials page (https://console.developers.google.com/apis/credentials)
- Create a new OAuth Client credential. Select TV as device type. You will be provided with a id and a secret. 
- Save both **CLIENT_ID** and **SECRET** because you gonna need it for grive2.
- Run this container again with these **ENV** options : 
```docker run -it -e **ID=YOURID** -e **SECRET=YOUR_CLIENT_SECRET**  -v /your/host/folder:/drive agusalex/grive2 ```
- Go to the provided URL -> Grant Access then copy and paste the **CODE** when prompted in the terminal
- It will start sync
- Enjoy Grive2!! 
# Running
```
docker run -v /your/host/folder:/drive agusalex/grive2 
```
Also if you already have your response code you can use this (warning this will expose your credentials to anyone with access to the computer)
```
docker run -it -e ID=YOURID -e SECRET=YOUR_CLIENT_SECRET -e CODE=YOUR_CODE_RESPONSE -v /your/host/folder:/drive agusalex/grive2 
```
You can grab your response code by appending your **CLIENT_ID** to this URL:

https://accounts.google.com/o/oauth2/auth?scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&client_id= **FILL_HERE_YOUR_CLIENT_ID**

# Grive Setup

You may override this container entrypoint for setting your own Grive configs for example syncing only one folder with -s etc.

All docs can be found here https://yourcmc.ru/wiki/Grive2
