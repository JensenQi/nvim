from .abstract_waiter import AbstractWaiter
from filegen import *


class NestJsWaiter(AbstractWaiter):

    def __init__(self):
        super(NestJsWaiter, self).__init__()

    def work(self, **_):
        self.box_print("Setup Nest.js project")
        name = self.ask("project name", "app")
        version = self.ask("version", "0.1.0")

        super().work(default_loc=name)

        StaticResource("quickstart-nestjs/src").save(f"{self.project_loc}/src")
        StaticResource("quickstart-nestjs/test").save(f"{self.project_loc}/test")

        StaticResource("quickstart-nestjs/nest-cli.json") \
            .save(f"{self.project_loc}/nest-cli.json")
        StaticResource("quickstart-nestjs/tsconfig.build.json") \
            .save(f"{self.project_loc}/tsconfig.build.json")
        StaticResource("quickstart-nestjs/tsconfig.json") \
            .save(f"{self.project_loc}/tsconfig.json")
        StaticResource("quickstart-nestjs/yarn.lock") \
            .save(f"{self.project_loc}/yarn.lock")

        DynamicResource("quickstart-nestjs/package.json")\
            .set("name", name) \
            .set("version", version) \
            .save(f"{self.project_loc}/package.json") \

