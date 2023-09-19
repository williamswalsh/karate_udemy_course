@runMe
Feature: Demostrate Hooks.

    Background: This is the before hook.
        # call - will execute fx for each test. (BeforeEach)
        # callonce - will execute fx once and cache value for subsequent scenarios. (BeforeFeature)
        * def result = call read('classpath:helpers/Dummy.feature')
        * def username = result.username

        # After hooks - after Feature call JS function.
        # * configure afterFeature = function() { karate.call('classpath:helpers/Dummy.feature') }

        # After each scenario call JS function.
        # * configure afterScenario = function() { karate.call('classpath:helpers/Dummy.feature') }

        # Excution of inline JS function
        * configure afterScenario = 
        """
        function() {
            karate.log("Karate inline JS after scenario.");
        }
        """

    Scenario: Scenario 1
        * print "S1: ", username
        * print "Scenario 1"

    Scenario:Scenario 2
        * print "S2: ", username
        * print "Scenario 2"