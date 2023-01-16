# math-api

## Description
Small API for calculating the largest prime factor for a given number

## Endpoints
/largest-prime-factor/\<num>
Provide a number in the URI, the response will contain the largest prime factor.

## Running the application
The application is written in Python, and used the Flask framework.

To build container run
```
cd /apps/math-api
docker build . -t maths-api
```

To run the container
```
docker run -p 5000:5000 math-api
```

Example curl to test
```
curl localhost:5000/largest-prime-factor/5156513
```
Expect the following output
```
84533
```