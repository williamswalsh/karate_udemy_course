package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class ConduitTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:conduitApp")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}

// mvn test -Dtest=ConduitTest#testTags
// OR
// mvn test -Dkarate.options="--tags=@debug"
// Can skip a specific test by annotating it with @skipMe
// then using the mvn test -Dkarate.options="--tags=~@skipMe" -> ~ -> negation operator like @ignore
// just use ignore

// Can run specific scenario by referencing the file line:
// mvn test -Dkarate.options="classpath:conduitApp/feature/HomePage.feature:6"