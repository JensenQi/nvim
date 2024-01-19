#include <foo.hpp>
#include <gtest/gtest.h>

TEST(TestFoo, BasicAssertions) {
  auto ret = hello_world();
  EXPECT_TRUE(ret == "Hello World");
}
