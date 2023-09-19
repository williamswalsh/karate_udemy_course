Feature: Dummy

    Scenario: Dummy scenario - used in Hooks example.
        # NB: note using Java.type not read("classpath:...")
        * def DataGenerator = Java.type('helpers.DataGenerator')
        * def username = DataGenerator.getRandomUsername()
        * print "Dummy - username: ", username
