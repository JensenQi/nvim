from filegen import *
import sys
import os

HEADER = '\033[95m'
BLUE = '\033[94m'
CYAN = '\033[96m'
GREEN = '\033[92m'
WARNING = '\033[93m'
FAIL = '\033[91m'
END = '\033[0m'
BOLD = '\033[1m'
UNDERLINE = '\033[4m'


class AbstractWaiter(object):
    def __init__(self):
        super(AbstractWaiter).__init__()
        self.project_loc = ""
        current_file_path = os.path.dirname(os.path.realpath(__file__))
        self.SHARE = f"{current_file_path}/../../share"

    @staticmethod
    def ask(question: str, default, choice=[]):
        sys.stdout.write(f"{BLUE}{question}{END} ")
        if default is not None:
            sys.stdout.write(f"(default = {GREEN}{default}{END}): ")
        else:
            sys.stdout.write(f": ")
        sys.stdout.flush()

        answer = sys.stdin.readline().strip()
        if not answer and default is None:
            print(f"{FAIL}{question} not default value, must type value{END}")
            answer = AbstractWaiter.ask(question, default, choice)
        if not answer:
            answer = default

        if isinstance(default, int):
            try:
                answer = int(answer)
            except ValueError:
                print(f"{FAIL}{question} must be int, type again{END}")
                answer = AbstractWaiter.ask(question, default, choice)
        else:
            answer = answer

        if choice and answer not in choice:
            print(f"{FAIL}{question} must choice from {choice}, type again{END}")
            return AbstractWaiter.ask(question, default, choice)

        return answer

    @staticmethod
    def box_print(message: str):
        char_num = len(message)
        line = "+-" + "-" * char_num + "-+"
        print(line)
        print(f"| {WARNING}{message}{END} |")
        print(line)

    def execute(self, command: str):
        os.system(f"cd {self.project_loc} && {command} >/dev/null 2>&1")
        # os.system(f"cd {self.project_loc} && {command} ")

    def mkdir(self, path):
        os.makedirs(f"{self.project_loc}/{path}", exist_ok=True)

    def work(self, **kwargs):
        default_loc = kwargs.get("default_loc") or "app"
        loc_choice = [default_loc] + [f"{default_loc}-{i}" for i in range(1, 1000)]
        for loc in loc_choice:
            if not os.path.exists(f"./{loc}"):
                default_loc = loc
                break

        self.project_loc = AbstractWaiter.ask("project location", default_loc)
        self.mkdir(".vim")

        StaticResource("LICENSE").save(f"{self.project_loc}/LICENSE")
        StaticResource("gitignore").save(f"{self.project_loc}/.gitignore")
        NewResource("").save(f"{self.project_loc}/README.md")

        self.execute(f"git init --initial-branch=master")
        self.execute(f"git add LICENSE .gitignore README.md")
        self.execute(f"git commit -m 'init'")
