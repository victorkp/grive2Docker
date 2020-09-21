#!/bin/bash
echo "Starting Grive2 Docker..."
if [ -f /usr/local/bin/drive/.grive ]; then
    echo "Configuration Exists!"
    /usr/local/bin/grive
else
    if [ -z "$ID" ]; then
        echo "
                Configuration is missing...


                First Time Setup (Action Required):	

                - Go to https://console.developers.google.com/apis/library. Login with your Google account and create a new project on Google Cloud Platform. You can also use an existing one.
                - Search for Google Drive API and enable it.
                - Go to API Credentials page (https://console.developers.google.com/apis/credentials)
                - Create a new OAuth Client credential. Select TV as device type. You will be provided with a id and a secret. 
                - Save both CLIENT_ID and SECRET because you gonna need it for grive2.
                - Run this container again with these ENV options : 
                                    docker run -it -e ID=YOURID -e SECRET=YOUR_CLIENT_SECRET  -v /mnt/user/appdata/drive:/drive agusalex/grive2 
                - Go to  URL Grant Access then copy and paste code when prompted in the terminal
                - Enjoy the Grive2!! 
                "
    else

        if [ -z "$CODE" ]; then
            echo "Configuration is missing...
                      Starting setup... "
            /usr/local/bin/grive -a --id $ID --secret $SECRET

        else
            echo "Auto-Configuring with provided authCode..."
            echo -ne "$CODE\n" | /usr/local/bin/grive -a --id $ID --secret $SECRET
        fi
    fi
fi
