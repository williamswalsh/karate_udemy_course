Feature: Test for the home page

    Background:
        Given url apiUrl
    
    Scenario: Get all tags 
        Given path 'api/tags'
        When method Get
        Then status 200

    Scenario: Get 10 articles from page 
        # Can't specify by path if params are present in path - this fails: Given path 'api/articles?limit=10&offset=0'
        Given url 'https://conduit.productionready.io/api/articles?limit=10&offset=0'
        When method Get
        Then status 200

    Scenario: Get 10 articles from page with params defined not in URL
        Given path 'api/articles'
        Given param limit = 10
        Given param offset = 0
        When method Get
        Then status 200

    Scenario: Get 10 articles from page with params defined as single object
        Given path 'api/articles'
        Given params { "limit": 10, "offset": 0 }
        When method Get
        Then status 200
    
    Scenario: Get 10 articles from page with path defined separately
        Given url apiUrl
        Given path 'api/articles'
        Given params { "limit": 10, "offset": 0 }
        When method Get
        Then status 200

    Scenario: Get 10 articles from page with path defined separately
        Given url apiUrl
        Given path 'api/articles'
        Given params { "limit": 10, "offset": 0 }
        When method Get
        Then status 200
    
    Scenario: Get 10 articles from page, url defined in Background section.
        Given path 'api/articles'
        Given params { "limit": 10, "offset": 0 }
        When method Get
        Then status 200

    Scenario: Get all tags, assert single value in response tags array
        Given path 'api/tags'
        When method Get
        Then status 200
        And match response.tags contains 'welcome'
    
    Scenario: Get all tags
        Given path 'api/tags'
        When method Get
        Then status 200
        
        # assert response tags array contains these elements 
        And match response.tags contains [ 'introduction', 'welcome' ]
        
        # assert response tags array contains any(at least 1) of these elements - welcome is present
        And match response.tags contains any [ 'not_present', 'also_not_present', 'welcome' ]
        
        # assert response tags array contains only these elements - must provide full array - doesn't need to be in same order
        And match response.tags contains only [ "welcome","implementations","introduction","codebaseShow","ipsum", "qui", "cupiditate", "et", "quia", "tag" ]
        
        # assert response tags array doesn't contain an element
        And match response.tags !contains [ 'bug' ]
        
        # assert that the response tags array is an array
        And match response.tags == '#array'
        
        # assert that the response tags array element 0 is not an array and it's a string
        And match response.tags[0] != '#array'
        And match response.tags[0] == '#string'
        
        # assert that each element in the array is a string 
        And match each response.tags == '#string'
    
    Scenario: Get all tags, assert that the response tags array element 0 is not an array
        Given path 'api/tags'
        When method Get
        Then status 200
        And match each response.tags == '#string'

    Scenario: Get articles from page, assert articleCount in response is a number and is 197 and is not the string '197'
        * def timeValidator = read('classpath:helpers/TimeValidator.js')
        
        Given path 'api/articles'
        When method Get
        Then status 200
        And match response.articlesCount == '#number'
        * print "response.articlesCount: ", response.articlesCount
        And match response.articlesCount == 224
        And match response.articlesCount != '224'
        # String('224') vs number(224)

        # Assert response structure:
        And match response == { "articles": "#array", "articlesCount": 224 }

        # Assert string contains this years value
        And match response.articles[0].createdAt contains "2023"

        # Assert that at least one value of field of multiple objects in array contain the value 0
        And match response.articles[*].favoritesCount contains 0
        
        # Negation of previous command - any field doesn't contain value 5
        And match response.articles[*].favoritesCount !contains 5
        
        # Assert that all favourite counts are of type number
        And match each response..favoritesCount == '#number'

        # Assert at least one of the bios field in object array has value null
        And match response.articles[*].author.bio contains null

        # Same command but just with wildcard path - (at least one)
        And match response..bio contains null

        # Double hash -> ## -> each bio should be string or null or is optional in object
        And match each response..bio == '##string'

        # assert each/every value is false
        And match each response..following == false

        # assert each/every value is a boolean
        And match each response..following == '#boolean'

        # Schema validation
        # match each elem in array
        And match each response.articles == 
        """
            {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
                }
            }
        """

    Scenario: Get 10 articles from page, assert article array has a size of 10
        Given path 'api/articles'
        Given params { "limit": 10, "offset": 0 }
        When method Get
        Then status 200
        Then match response.articles == '#[10]'
    