# loadgenerator

## Description
Small service used to generate load for other services in this project, targets:
- math-api

## Running the application
The application is written in Python

To build container run
```
cd /apps/loadgenerator
docker build . -t loadgenerator
```

To run the container
```
docker run -d -e SERVER_ADDR=http://localhost:5000 -e REQUESTS_PER_SECOND=5 loadgenerator
```

Check the container is running
```
docker ps
```