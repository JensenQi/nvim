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

        StaticResource("quickstart-nestjs/src/app.controller.spec.ts") \
            .save(f"{self.project_loc}/src/app.controller.spec.ts")
        StaticResource("quickstart-nestjs/src/app.controller.ts") \
            .save(f"{self.project_loc}/src/app.controller.ts")
        StaticResource("quickstart-nestjs/src/app.module.ts") \
            .save(f"{self.project_loc}/src/app.module.ts")
        StaticResource("quickstart-nestjs/src/app.service.ts") \
            .save(f"{self.project_loc}/src/app.service.ts")
        StaticResource("quickstart-nestjs/src/main.ts") \
            .save(f"{self.project_loc}/src/main.ts")

        StaticResource("quickstart-nestjs/test/app.e2e-spec.ts") \
            .save(f"{self.project_loc}/test/app.e2e-spec.ts")
        StaticResource("quickstart-nestjs/test/jest-e2e.json") \
            .save(f"{self.project_loc}/test/jest-e2e.json")

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

