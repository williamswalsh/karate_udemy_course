
Feature:

Scenario:
    * url 'http://google.com'
    * method get

Scenario:
    * url 'https://httpbin.org/anything'
    * request { "myKey": "myValue"}
    * method post

