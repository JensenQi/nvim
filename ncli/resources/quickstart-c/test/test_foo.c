#include <stdarg.h>
#include <stddef.h>
#include <setjmp.h>
#include <cmocka.h>
#include <foo.h>

void test_foo(void **state) {
    char* words = hello_world();
    assert_string_equal(words, "Hello World");
}
