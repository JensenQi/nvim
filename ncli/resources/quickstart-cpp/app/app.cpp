#include "bar.hpp"
#include "foo.hpp"

#include <iostream>

int main() {
  std::cout << "Simple example C++ compiled correctly and ran." << std::endl;
  auto words = hello_world();
  std::cout << words << " word count" << word_count(words) << std::endl;
  return 0;
}
