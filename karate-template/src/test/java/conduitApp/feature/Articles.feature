Feature: Testing the login flow

    Background: Login to site
        Given url apiUrl
        # DOCUMENT - how to call feature file from another feature
        # Call feature file once
        # any vars created in feature can be reffered to by capturing return of the feature call
        # * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') { "email": "william@test.com", "password": "karate123" }
        # * def token = tokenResponse.authToken
        * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.feature')

    @runMe
    Scenario: Create an article
        Given path 'api/articles/'
        # And header Authorization = 'Token ' + authToken
        And header content-type = 'application/json'
        And header accept = 'application/json'
        And request articleRequestBody
        And method Post
        # Then status 422 
        Then status 201 
        # Duplicate article error expected


        Given path 'api/articles'
        Given params { "limit": 10, "offset": 0 }
        When method Get
        Then status 200
        * print response
        And match response.articles[0].title == "Something already created 34"
        # Match fails because API does not add article to list
    
    @ignore
    Scenario: Create and delete an article - Ignored as can't identify ariticle in articles response json body
        Given path 'api/articles/'
        And header Authorization = 'Token ' + token
        And header content-type = 'application/json'
        And header accept = 'application/json'
        And request { "article": { "title": "Something definitely unique802", "description": "about", "body": "info", "tagList": ["tag"] } }
        And method Post
        Then status 201
        And match response.article.title == "Something definitely unique802"
        * def articleId = response.article.slug

        Given path 'api/articles'
        Given params { "limit": 10, "offset": 0 }
        When method Get
        Then status 200
        And match response.articles[0].title == "Something definitely unique802"

    #   Given path 'api/articles', articleId -> No slash needed if using comma in given path command -> not as expressive as basic concatenation method
        Given path 'api/articles/' + articleId
        And header Authorization = 'Token ' + token
        And method Delete
        Then status 200
        
        Given path 'api/articles'
        Given params { "limit": 10, "offset": 0 }
        When method Get
        Then status 200
        And match response.articles[0].title != "Something definitely unique802"

# DOCUMENT - mvn test -Dkarate.env="dev" - how to set env variable in karate
# General form: mvn test -Dkarate.<variable_name>="whatever"

# DOCUMENT 
# When calling feature from karate-config yo uneed to use karate.callSingle(classpath:faeture, config) method
# General form:
# var authToken = karate.callSingle(<FEATURE_FILE>, <FEATURE_ARGUMENT_OBJECT>).authToken 

# General config - cross-tests
# karate.configure('headers', {Authorization: 'Token ' + accessToken})
# return config;

# Working 
#   var authToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken 
#   karate.configure('headers', {Authorization: 'Token ' + authToken})

# #('Test_' + userData.username)