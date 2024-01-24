from foo import Foo
from bar import Bar

if __name__ == "__main__":
    foo = Foo()
    bar = Bar()

    words = foo.say()
    word_count = bar.word_count(words)
    print(f"{words} word count = {word_count}")

