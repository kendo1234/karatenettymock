Feature: Comic Book Mock Server

Background:
    * def comics = {}
    * def uuid = function(){ return java.util.UUID.randomUUID() + ''}
    * configure responseHeaders = {'Content-Type':'application/json'}
    * configure cors = true
    * configure afterScenario = function(){ karate.set('responseDelay',200 + Math.random()* 400)}
    * def abortWithStatus =
    """
    function(status,data)
    {
        karate.set("responseStatus",status);
        karate.set("response",{content: data});
        karate.abort();
    }
    """


Scenario: pathMatches('/comics') && methodIs('get')
    * def responseStatus = 200
    * def response = read('MockData/comics.json')

Scenario: pathMatches('/comic') && methodIs('get') && paramExists('name')
    * def content = 'Title - ' + paramValue('name')
    * def responseStatus = 200
    * def responseDelay = 4000
    * def id = uuid()
    * def response = {id :'#(id)', name:'#(name)', content:'#(content)'}

Scenario: pathMatches('/comic') && methodIs('post') && !headerContains('Auth','secret')
    * print request
    * def comic = request
    * def id = uuid()
    * comic.id = id
    * comics[id] = comic
    * def response = comic

Scenario: pathMatches('/comic/{id}') && methodIs('get')
    * def result = comics[pathParams.id]
    * eval if(!result) abortWithStatus(404,"comic book data not found")
    * def response = result

Scenario: pathMatches('/comic/{id}') && methodIs('delete')
    * def toDelete = comics[pathParams.id]
    * eval if(!toDelete) abortWithStatus("500","comic book is already deleted or not found")
    * delete comics[pathParams.id]
    * def responseStatus = 200
    * def response = toDelete

Scenario:
    * print request
    * def responseStatus = 404
    * def response = {content : "Not a valid url"}

