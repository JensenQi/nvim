#include <bar.hpp>
#include <gtest/gtest.h>

TEST(test_bar, BasicAssertions) {
  EXPECT_EQ(word_count("Hello World"), 11);
  EXPECT_EQ(word_count("HelloWorld"), 10);
}

