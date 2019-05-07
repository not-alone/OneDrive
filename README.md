# OneDrive
OneDrive docker based on abraunegg/skilion Onedrive: https://github.com/abraunegg/onedrive.

May be the most current and supported to date OneDrive client for Linux.

DockerHub: https://hub.docker.com/r/notalone/onedrive-abraunegg.

## Setup - First Run

When first launching the container you will need to authenticate with your Microsoft account. The procedure requires a web browser. You will be asked to open a specific link where you will have to login into your Microsoft Account and give the application the permission to access your files. After giving the permission, you will be redirected to a blank page. Copy the URI of the blank page into the application.

To allow you to copy the URI back into the docker container you need to launch it in interactive mode, this can be done using the -it flag.

    docker run -it --name your_contaner_name \
    -e PUID=$(id -u) -e PGID=$(id -g) \
    -v your_config_directory:/OneDriveConf \
    -v your_data_directory:/OneDriveData \
    notalone/onedrive-abraunegg:latest

Once authenticated you can stop the sync process by ctrl+c, remove the container: 

    docker rm your_contaner_name

and restart the container in non-interactive mode

    docker run -itd --name your_contaner_name \
    -e PUID=$(id -u) -e PGID=(id -g) \
    -v your_config_directory:/OneDriveConf \
    -v your_data_directory:/OneDriveData \
    notalone/onedrive-abraunegg:latest

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side.

    -v your_config_directory:/OneDriveConf - This is where the OneDrive Client will store it's config. 
    -v your_data_directory:/OneDriveData - This is the folder that will be synced with OneDrive.
    -e PGID=1000 - for GroupID - This should match the GID of the user who owns the local files.
    -e PUID=1000 - for UserID - This should match the UID of the user who owns the local files.
