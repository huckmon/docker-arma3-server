# Introduction
This is an Arma 3 server container intended to be capable of being used as vanilla or modded.  

This readme should include all that you need to get the server up and running.  

Please feel free to open an issue with problems you're having, just remember to include logs, proof or at least a description of the issue and step to reproduce.

# Steps for Use
You'll need to do some specific steps due to the fact that downloading and updating Arma 3 server files with steamcmd requires a steam account that owns the game. Other sections under this one will also inform you on how to mount server files and the general directory of the container
## Caching user credentials
To download the server files, you'll need to login with a steam profile that owns Arma 3.  
To add steam user credentials to the container, follow these steps.
1. add `entrypoint: "/bin/bash"` to compose file
2. `sudo docker exec -it <container-name> bash`
3. `su arma` 
4. `steamcmd +login <steam-username>` 
5. login with password and steam guard if enabled
6. `quit` (from steamcmd)
7. `quit` (from exec session)
8. Remove the entrypoint line from the compose file
Your steam profile should now be cached to allow the container to download updates for the server without having to repeat these steps  
It's slightly janky, but other options need a lot of work (which is a later issue if at all).

## Data Directory
All files are stored in the `./data` volume
- Server files will be within top of the `/data` directory
- Arma Profile files and folders will be located in `/data/.local/share/Arma 3 - Other Profiles/<username>` and the default profile will be located at `/data/.local/share/Arma 3`
    - To use files you've added to the Other Profiles folder, use the arma_user container variable when starting the container

## Environment Variables

The following table has all current environment variables
| Name       | Desc                                                                                       | Default | Required |
| ---------- | ------------------------------------------------------------------------------------------ | ------- | -------- |
| steam_user | steam user for steamcmd to use for downloading sever files                                 | ""      | yes      |
| arma_user  | arma profile name to run server as if using files from "Arma 3 - Other Profiles" directory | ""      | no       |

## Ports Used
The following ports are used by the container

UDP ports 
- 2302
- 2303
- 2304
- 2305
- 2306
- 2344  

TCP ports
- 2344
- 2345

## Adding/Using Workshop Mods
To add mods to the server, create a file called `modlist.txt` and place it in the `/data` directory.  
To add mods with the modlist file, add the mods by taking the steamworkshop ID number and placing it in the text file each seperated by a line e.g.
```
2867537125
1638341685
1724884525
```
Planning to add the ability to add mods with a container environment variable where you can enter comma-seperated, workshop IDs in a single line in the case you don't want to make a text file with them or something weird.
# Running
## Docker Run
I don't recommend docker run because docker-compose is just easier. At least make a script for the command if you do use it.
`docker run -d -it -p 2301-2306:2301-2306/udp -p 2344-2345:2344:2345/udp -p 2345:2345 -e steam_user:<steamuser> -v ./data:/data huckmong/arma3-server:latest`
## Docker Compose example
```
services:
  arma:
    image: huckmong/arma3-server:latest
    environment:
      steam_user: "steam"
    ports:
      - "2301:2301/udp"
      - "2302:2302/udp"
      - "2303:2303/udp"
      - "2304:2304/udp"
      - "2305:2305/udp"
      - "2306:2306/udp"
      - "2344:2344/udp"
      - "2345:2345"
    volumes:
      - ./data:/data
    restart: unless-stopped
    stdin_open: true
    tty: true
    #entrypoint: "/bin/bash" # This line needs to be uncommented when exec'ing into the container
```

# Common Issues

## Q: Some of the workshop items are failing to install/download!!!
A: This seems to be a common issue in steamcmd when installing large workshop items as part of a bulk download. I recommend exec'ing into the container and then downloading the large mods individually.

## Q: My Mods aren't Loading!!!
A: This might be because you've left spaces in the modlist.txt document. Currently the container doesn't filter spaces from the lines and I intend to fix this eventually.  
EDIT: this has been fixed, the only thing that will ruin your modlist file now is if you add other numeric characters that aren't part of the workshop ID (go ham with the whitespaces and/or commas, you *should* be able to add text to name/describe mods).
