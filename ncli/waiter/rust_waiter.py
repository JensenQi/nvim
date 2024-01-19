from .abstract_waiter import AbstractWaiter
from filegen import *


class RustWaiter(AbstractWaiter):

    def __init__(self):
        super(RustWaiter, self).__init__()

    def work(self, **_):
        self.box_print("Setup Rust project")
        name = self.ask("name", "app")
        version = self.ask("version", "0.1.0")
        edition = self.ask("edition", "2021")

        super().work(default_loc=name)

        DynamicResource("quickstart-rust/cargo.toml")\
            .set("name", name) \
            .set("version", version) \
            .set("edition", edition) \
            .save(f"{self.project_loc}/Cargo.toml")

        StaticResource("quickstart-rust/foo.rs") \
            .save(f"{self.project_loc}/src/main.rs")

        NewResource("").save(f"{self.project_loc}/src/lib.rs")

        self.mkdir("src/utils")
        self.mkdir("tests/integration")
        self.mkdir("tests/unit")
