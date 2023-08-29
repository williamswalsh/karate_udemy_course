Feature: Create user token

Scenario: Create Token
    Given url apiUrl
    Given path 'api/users/login'
    And header content-type = 'application/json'
    And header accept = 'application/json'
    # DOCUMENT - how to pass value to feature -> #() -> Embedded expression
    And request { "user": { "email": "#(userEmail)", "password": "#(userPassword)" } }
    And method Post    
    Then status 200
    * def authToken = response.user.token
