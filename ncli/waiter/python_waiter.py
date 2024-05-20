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

        StaticResource("quickstart-python/src").save(f"{self.project_loc}/src")
        StaticResource("quickstart-python/tests").save(f"{self.project_loc}/tests")
        NewResource("\n").save(f"{self.project_loc}/src/__init__.py")

