import unittest

from bar import Bar


class TestBar(unittest.TestCase):
    def test_foo(self):
        bar = Bar()
        cnt = bar.word_count("hello world")
        self.assertEqual(cnt, 11)

