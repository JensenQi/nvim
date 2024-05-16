from .abstract_waiter import AbstractWaiter
from filegen import *
import json


class ScalaWaiter(AbstractWaiter):

    def __init__(self):
        super(ScalaWaiter, self).__init__()

    def work(self, **kwargs):
        self.box_print("Setup Scala project")
        group_id = self.ask("group_id", "tech.cuda")
        artifact_id = self.ask("artifact_id", "example")
        version = self.ask("version", "0.1.0-SNAPSHOT")
        use_maven = self.ask(
            question="use maven or gradle [1-maven, 2-gradle]",
            default=1,
            choice=[1, 2]
        ) == 1

        super().work(default_loc=artifact_id)

        package_path = f"{group_id.replace('.', '/')}/{artifact_id}"

        if use_maven:
            DynamicResource("quickstart-scala/pom-scala.xml") \
                .set("group_id", group_id) \
                .set("artifact_id", artifact_id) \
                .set("version", version) \
                .save(f"{self.project_loc}/pom.xml")

        DynamicResource("quickstart-java/Foo.java")\
            .set("group_id", group_id)\
            .set("artifact_id", artifact_id)\
            .save(f"{self.project_loc}/src/main/java/{package_path}/Foo.java")

        DynamicResource("quickstart-scala/Bar.scala")\
            .set("group_id", group_id)\
            .set("artifact_id", artifact_id)\
            .save(f"{self.project_loc}/src/main/scala/{package_path}/Bar.scala")

        DynamicResource("quickstart-java/FooTest.java")\
            .set("group_id", group_id)\
            .set("artifact_id", artifact_id)\
            .save(f"{self.project_loc}/src/test/java/{package_path}/FooTest.java")

        DynamicResource("quickstart-scala/BarSuite.scala")\
            .set("group_id", group_id)\
            .set("artifact_id", artifact_id)\
            .save(f"{self.project_loc}/src/test/scala/{package_path}/BarSuite.scala")

        StaticResource("log4j.properties")\
            .save(f"{self.project_loc}/src/main/resources/log4j.properties") \
            .save(f"{self.project_loc}/src/test/resources/log4j.properties") \

