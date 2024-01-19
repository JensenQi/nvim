package {group_id}.{artifact_id};

import static org.junit.Assert.assertTrue;
import org.junit.Test;
import org.apache.log4j.Logger;

public class FooTest {

    private static Logger logger = Logger.getLogger(FooTest.class);

    @Test
    public void shouldAnswerWithTrue() {
        assertTrue(true);
        logger.info("test success");
    }
}
