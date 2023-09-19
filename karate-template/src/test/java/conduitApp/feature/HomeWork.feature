Feature:

Background: Login to site
    Given url apiUrl

Scenario: Favorite an Article
    # Get Articles
    Given path 'api/articles'
    And params { "limit": 10, "offset": 0 }
    And method Get
    Then status 200
    
    # Get first article fav count and slug id
    * def slug = response.articles[0].slug
    * def favoritesCount = response.articles[0].favoritesCount
    
    # Do POST to increment favourite count
    Given path 'api/articles/' + slug + '/favorite'
    And header content-type = 'application/json'
    And header accept = 'application/json'
    And method Post
    Then status 200


    # verify response schema
    And match response ==
    """
    { 
        "article": {
            "id": 357143,
            "slug": "Ben-207953",
            "title": "Ben",
            "description": "Oldtown",
            "body": "The things I do for love.",
            "createdAt": "2023-09-19T09:02:54.967Z",
            "updatedAt": "2023-09-19T09:02:54.967Z",
            "authorId": 207953,
            "tagList": [
                "tag"
            ],
            "author": {
                "username": "william1234",
                "bio": null,
                "image": "https://api.realworld.io/images/smiley-cyrus.jpeg",
                "following": false
            },
            "favoritedBy": [
                {
                    "id": 207953,
                    "email": "william@test.com",
                    "username": "william1234",
                    "password": "$2a$10$i5gHweo1DQaY4Ce.D5/rA.P7Dg67Agukbvt81HheHOMdEkSYFg7CC",
                    "image": "https://api.realworld.io/images/smiley-cyrus.jpeg",
                    "bio": null,
                    "demo": false
                }
            ],
            "favorited": true,
            "favoritesCount": 1
        }
    }
    """
    # * def initialCount = 0
    # * def response = {"favouritesCount": 1}
    # * match response.favouritesCount == initialCount + 1
    # * print "Response: ", response