package {group_id}.{artifact_id};

import org.apache.log4j.Logger;

public class Foo {

    private static Logger logger = Logger.getLogger(Foo.class);

    public void say() {
        logger.info("Hello world");
    }

    public static void main(String[] args) {
        System.out.println("Hello World!");
    }
}
