from .abstract_waiter import AbstractWaiter
from filegen import *


class CppWaiter(AbstractWaiter):

    def __init__(self):
        super(CppWaiter, self).__init__()

    def work(self, **_):
        self.box_print("Setup C++ project")
        name = self.ask("project name", "app")
        version = self.ask("version", "0.1.0")

        super().work(default_loc = name)

        StaticResource("quickstart-cpp/app/app.cpp")\
            .save(f"{self.project_loc}/app/{name}.cpp")
        StaticResource("quickstart-cpp/app/CMakeLists.txt")\
            .save(f"{self.project_loc}/app/CMakeLists.txt")

        StaticResource("quickstart-cpp/cmake").save(f"{self.project_loc}/cmake")
        StaticResource("quickstart-cpp/include").save(f"{self.project_loc}/include")
        StaticResource("quickstart-cpp/src").save(f"{self.project_loc}/src")
        StaticResource("quickstart-cpp/test").save(f"{self.project_loc}/test")

        DynamicResource("quickstart-cpp/CMakeLists.txt")\
            .set("name", name) \
            .set("version", version) \
            .save(f"{self.project_loc}/CMakeLists.txt") \

        self.mkdir("build")

