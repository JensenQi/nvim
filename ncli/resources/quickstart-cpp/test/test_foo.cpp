#include <foo.hpp>
#include <gtest/gtest.h>

TEST(test_foo, BasicAssertions) {
  auto ret = hello_world();
  EXPECT_TRUE(ret == "Hello World");
}

