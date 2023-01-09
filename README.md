# Karate Mock

To support my contract testing learning, I have been looking at the mocking capabilities of Karate. This repo contains a simple mock server with a set of pre-defined endpoints and behaviours. 

## The Mock

A simple service to retreive comic books

## Dependencies

Karate standalone Jar, found [HERE](https://github.com/karatelabs/karate/releases) 

## Getting Started

* Download the latest jar
* Add it to project/repo (drag and drop)
* Run the following command
```
java -jar karate-1.3.1.jar -m bookmock.feature -p 5000
```
You should see the following - 

11:15:13.056 [main]  INFO  com.intuit.karate - Karate version: 1.3.1
11:15:13.628 [main]  INFO  com.intuit.karate - mock server initialized: bookmock.feature
11:15:13.886 [main]  DEBUG com.intuit.karate.http.HttpServer - server started: r7q54kk4rv:5000

* Head to localhost:5000/books and voila! you have a mock configured with Karate DSL

## Mock Walkthrough

* Line 1 & 20 - Standard defenition of feature and scenario. In this case, the "scenario" is a mocked endpoint with a CRUD method

* Lines 3 - Background provides values and behaviours to any scenario in the mock. Here, these include shared response headers, cors conifg, a function to generate UUID for a dynamic response, after hook to define response delay AND an abort status for the call detailed below 

* Line 4 - This sets a disctionary object that forms a global state for 'comics'

* Line 31 - this adds some complexity to a POST call. First of all, headerContains() is a Karate/Netty function to check a header has a certain value. Next, this endpoint takes a valid body and populates comics value map. For example, post the following body using /comic

```json
{
  "Book_3": {
    "name": "Punisher Max Complete Collection Vol. 2",
    "publishedDate": "14-04-2016",
    "ISBN": "978-1302900168",
    "id": "Book_2"
  }
}
```

This will add a new comic to your mock data set

* Line 44 - This is a delete endpoint to remove an item from your mock dataset (or the map of values on line 4). As with the POST, you can use the GET calls to verify the behaviour.

* Line 51 - This is some self explanatory error messaging that you can use to mimic your real world service' behaviour


For more ways to use Karate/Netty, head [HERE](https://karatelabs.github.io/karate/karate-netty/#background) 