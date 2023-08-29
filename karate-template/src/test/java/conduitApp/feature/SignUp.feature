Feature: Sign up new user

    Background: Define apiUrl & common helper function calls.
        * def DataGenerator = Java.type('helpers.DataGenerator');
        * def randomEmail = DataGenerator.getRandomEmail();
        * def randomUsername = DataGenerator.getRandomUsername();
        Given url apiUrl

    Scenario:
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
        And match response ==
        """
        {
            "errors": {
                "email": ["has already been taken"],
                "username": ["has already been taken"]
            }
        }
        """

    @runMe
    Scenario Outline: Validate status codes using a Scenario Outline. NB

        * def signUpRequest = 
        """
            {
                "user": {
                    "email": "<email>",
                    "password": "<password>",
                    "username": "<username>"
                }
            }
        """
        Given path 'api/users'
        And request signUpRequest
        And method Post
        Then status <responseCode>
        And match response == <response>

        # For each Example a new randomEmail and randomUsername are generated, creating a new user -> 201
        # If the first example fails with wrong assertion value, it proceeds onto the next example.
        Examples:
            |email                   |password  |username             |responseCode |response                                                                                                             |
            |#(randomEmail)          |Karate123 |alreadyTakenUsername |422          |{"errors":{"username":["has already been taken"]}}                                                                   |
            |alreadyTakenemail@a.com |Karate123 |#(randomUsername)    |422          |{"errors":{"email":["has already been taken"]}}                                                                      |
            |#(randomEmail)          |Karate123 |#(randomUsername)    |201          |{"user":{"email":"#(randomEmail)","username":"#(randomUsername)", "bio": "##string", "image": "#string", "token": "#string"}} |
    Scenario:
        * def userData = { "email": "william99@example.com", "username": "william99"}

        # Embedded values
        # Can concat data to string by: 
        * def signUpRequest = {"user": { "email": "#('Test' + userData.email)", password: "dummyPwd", "username": "#('User' + userData.username)" }}
        Given path 'api/users'
        And request signUpRequest
        And method Post
        Then status 201