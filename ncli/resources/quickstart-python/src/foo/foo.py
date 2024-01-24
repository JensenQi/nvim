class Foo(object):
    def __init__(self):
        super(Foo, self).__init__()
        self.words = "Hello World"

    def say(self) -> str:
        return self.words

