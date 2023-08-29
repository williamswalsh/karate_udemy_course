Feature: Sign up new user

    Background:
        * def DataGenerator = Java.type('helpers.DataGenerator');
        Given url apiUrl

    @runMe
    Scenario:
        * def randomEmail = DataGenerator.getRandomEmail();
        * def randomUsername = DataGenerator.getRandomUsername();
        * def signUpRequest = 
        """
            {
                "user": {
                    "email": "#(randomEmail)",
                    "password": "dummyPwd",
                    "username": "#(randomUsername)"
                }
            }
        """
        Given path 'api/users'
        And request signUpRequest
        And method Post
        Then status 201

        Given path 'api/users'
        And request signUpRequest
        And method Post
        Then status 422

    Scenario:
    * def userData = { "email": "william99@example.com", "username": "william99"}
    # Embedded values
    # Can concat data to string by: 
    * def signUpRequest = {"user": { "email": "#('Test' + userData.email)", password: "dummyPwd", "username": "#('User' + userData.username)" }}
    Given path 'api/users'
    And request signUpRequest
    And method Post
    Then status 201