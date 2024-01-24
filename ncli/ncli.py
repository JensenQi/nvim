import sys
from typing import Dict
from waiter import *

if __name__ == "__main__":

    waiters: Dict[str, AbstractWaiter] = {
        'java': JavaWaiter(),
        'scala': ScalaWaiter(),
        'go': GoWaiter(),
        'rust': RustWaiter(), 'rs': RustWaiter(),
        'c': CWaiter(),
        'cpp': CppWaiter(), 'c++': CppWaiter(),
        'python': PythonWaiter(), 'py': PythonWaiter(),
    }
    support_langs = list(waiters.keys())

    if len(sys.argv) == 1:
        lang = AbstractWaiter.ask(
            f"Which language? [{', '.join(support_langs)}]",
            default="java",
            choice=list(waiters.keys())
        )
    elif sys.argv[1] not in support_langs:
        lang = AbstractWaiter.ask(
            f"{sys.argv[1]} not supported, support language [{', '.join(support_langs)}]",
            default="java",
            choice=list(waiters.keys())
        )
    else:
        lang = sys.argv[1]

    waiters[str(lang)].work()
    print("finish")

