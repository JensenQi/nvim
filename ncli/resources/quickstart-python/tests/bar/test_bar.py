import unittest

from bar import Bar


class TestFoo(unittest.TestCase):
    def test_foo(self):
        bar = Bar()
        cnt = bar.word_count("hello world")
        self.assertEqual(cnt, 11)

