from .abstract_waiter import AbstractWaiter
from filegen import *


class PythonWaiter(AbstractWaiter):

    def __init__(self):
        super(PythonWaiter, self).__init__()

    def work(self, **_):
        git_user = self.execute_output("git", "config", "user.name")
        git_email = self.execute_output("git", "config", "user.email")
        self.box_print("Setup python project")
        name = self.ask("project name", "pyexample")
        version = self.ask("version", "0.1.0")
        author = self.ask("authors", git_user)
        email = str(self.ask("email", git_email)).lower()

        super().work(default_loc=name)
        DynamicResource("quickstart-python/pyproject.toml") \
            .set("name", name) \
            .set("version", version) \
            .set("author", author) \
            .set("email", email) \
            .save(f"{self.project_loc}/pyproject.toml")

        StaticResource("quickstart-python/src/app.py") \
            .save(f"{self.project_loc}/src/app.py")
        NewResource("\n").save(f"{self.project_loc}/src/__init__.py")

        StaticResource("quickstart-python/src/foo/foo.py") \
            .save(f"{self.project_loc}/src/foo/foo.py")
        StaticResource("quickstart-python/src/bar/bar.py") \
            .save(f"{self.project_loc}/src/bar/bar.py")
        StaticResource("quickstart-python/src/foo/__init__.py") \
            .save(f"{self.project_loc}/src/foo/__init__.py")
        StaticResource("quickstart-python/src/bar/__init__.py") \
            .save(f"{self.project_loc}/src/bar/__init__.py")

        StaticResource("quickstart-python/tests/foo/test_foo.py") \
            .save(f"{self.project_loc}/tests/foo/test_foo.py")
        StaticResource("quickstart-python/tests/bar/test_bar.py") \
            .save(f"{self.project_loc}/tests/bar/test_bar.py")
        StaticResource("quickstart-python/tests/__init__.py") \
            .save(f"{self.project_loc}/tests/__init__.py")

