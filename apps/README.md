# Running apps with Docker compose
Docker compose is used to quickly build and run containers and necessary networks for communication purposes.

## Docker compose commands
Docker compose up, will create everything specified in the file.

If the images are not located on the machine, it will build them locally first.

Create containers:
```
cd ./apps
docker compose up
```

Destroy containers:
```
docker compose down
```

Note: If you make a change to the code for one of the applications, make sure you re-build the images first
```
docker compose build
docker compose up
```