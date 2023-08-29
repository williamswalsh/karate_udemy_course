# Karate Integration testing
My tests created during "Karate DSL: API Automation and Performance from Zero to Hero" course.

#### Project Structure
- angular-real-world-app - this will be ran locally to run karate tests against - this doesn't change.
- karate-template - this is the collection of integration tests to test angular-real-world-app.
- karate-todo - this most likely can be removed.



#### Run commands:  
```bash
# To start the test app
cd angular-real-world-example-app
npm start

# To trigger test
cd ../karate-template
clear && mvn clean && clear && mvn test -Dkarate.options="--tags=@runMe"
```