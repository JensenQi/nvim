#include <bar.hpp>
#include <gtest/gtest.h>

TEST(TestBar, BasicAssertions) {
  EXPECT_EQ(word_count("Hello World"), 11);
  EXPECT_EQ(word_count("HelloWorld"), 10);
}
