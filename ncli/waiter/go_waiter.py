from .abstract_waiter import AbstractWaiter
from filegen import *


class GoWaiter(AbstractWaiter):

    def __init__(self):
        super(GoWaiter, self).__init__()

    def work(self, **_):
        self.box_print("Setup Go project")
        name = self.ask("name", "app")

        super().work(default_loc=name)

        self.execute(f"{self.SHARE}/go/bin/go mod init {name}")

        StaticResource("quickstart-go/foo.go")\
            .save(f"{self.project_loc}/cmd/main.go")

        self.mkdir("internal/app")
        self.mkdir("internal/pkg")
        self.mkdir("test")
