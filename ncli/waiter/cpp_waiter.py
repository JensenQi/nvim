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

        StaticResource("quickstart-cpp/cmake/googletest.cmake")\
            .save(f"{self.project_loc}/cmake/googletest.cmake")

        StaticResource("quickstart-cpp/include/bar.hpp")\
            .save(f"{self.project_loc}/include/bar.hpp")
        StaticResource("quickstart-cpp/include/foo.hpp")\
            .save(f"{self.project_loc}/include/foo.hpp")

        StaticResource("quickstart-cpp/src/bar.cpp")\
            .save(f"{self.project_loc}/src/bar.cpp")
        StaticResource("quickstart-cpp/src/foo.cpp")\
            .save(f"{self.project_loc}/src/foo.cpp")
        StaticResource("quickstart-cpp/src/CMakeLists.txt")\
            .save(f"{self.project_loc}/src/CMakeLists.txt")

        StaticResource("quickstart-cpp/test/test.cpp")\
            .save(f"{self.project_loc}/test/test.cpp")
        StaticResource("quickstart-cpp/test/test_bar.cpp")\
            .save(f"{self.project_loc}/test/test_bar.cpp")
        StaticResource("quickstart-cpp/test/test_foo.cpp")\
            .save(f"{self.project_loc}/test/test_foo.cpp")
        StaticResource("quickstart-cpp/test/CMakeLists.txt")\
            .save(f"{self.project_loc}/test/CMakeLists.txt")

        DynamicResource("quickstart-cpp/CMakeLists.txt")\
            .set("name", name) \
            .set("version", version) \
            .save(f"{self.project_loc}/CMakeLists.txt") \

        self.mkdir("build")
