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

        StaticResource("quickstart-c/cmake/cmocka.cmake")\
            .save(f"{self.project_loc}/cmake/cmocka.cmake")

        StaticResource("quickstart-c/include/bar.h")\
            .save(f"{self.project_loc}/include/bar.h")
        StaticResource("quickstart-c/include/foo.h")\
            .save(f"{self.project_loc}/include/foo.h")

        StaticResource("quickstart-c/src/bar.c")\
            .save(f"{self.project_loc}/src/bar.c")
        StaticResource("quickstart-c/src/foo.c")\
            .save(f"{self.project_loc}/src/foo.c")
        StaticResource("quickstart-c/src/CMakeLists.txt")\
            .save(f"{self.project_loc}/src/CMakeLists.txt")

        StaticResource("quickstart-c/test/test.c")\
            .save(f"{self.project_loc}/test/test.c")
        StaticResource("quickstart-c/test/test_bar.c")\
            .save(f"{self.project_loc}/test/test_bar.c")
        StaticResource("quickstart-c/test/test_foo.c")\
            .save(f"{self.project_loc}/test/test_foo.c")
        StaticResource("quickstart-c/test/CMakeLists.txt")\
            .save(f"{self.project_loc}/test/CMakeLists.txt")

        DynamicResource("quickstart-c/CMakeLists.txt")\
            .set("name", name) \
            .set("version", version) \
            .save(f"{self.project_loc}/CMakeLists.txt") \

        self.mkdir("build")
