from .abstract_waiter import AbstractWaiter
from filegen import *


class CWaiter(AbstractWaiter):

    def __init__(self):
        super(CWaiter, self).__init__()

    def work(self, **_):
        self.box_print("Setup C project")
        name = self.ask("project name", "app")
        version = self.ask("version", "0.1.0")

        super().work(default_loc=name)

        StaticResource("quickstart-c/app/app.c")\
            .save(f"{self.project_loc}/app/{name}.c")
        StaticResource("quickstart-c/app/CMakeLists.txt")\
            .save(f"{self.project_loc}/app/CMakeLists.txt")

        StaticResource("quickstart-c/cmake").save(f"{self.project_loc}/cmake")
        StaticResource("quickstart-c/include").save(f"{self.project_loc}/include")
        StaticResource("quickstart-c/src").save(f"{self.project_loc}/src")
        StaticResource("quickstart-c/test").save(f"{self.project_loc}/test")

        DynamicResource("quickstart-c/CMakeLists.txt")\
            .set("name", name) \
            .set("version", version) \
            .save(f"{self.project_loc}/CMakeLists.txt") \

        self.mkdir("build")

