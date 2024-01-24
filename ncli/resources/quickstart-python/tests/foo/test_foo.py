import unittest

from foo import Foo


class TestFoo(unittest.TestCase):
    def test_foo(self):
        foo = Foo()
        words = foo.say()
        self.assertEqual(words, "Hello World")

