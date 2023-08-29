package helpers;

import com.github.javafaker.Faker;

public class DataGenerator {
    
    public static final String getRandomEmail() {
        Faker faker = new Faker();
        return faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
    }

    public static final String getRandomUsername() {
        Faker faker = new Faker();
        return faker.name().username();
    }
}
