#include <stdarg.h>
#include <stddef.h>
#include <setjmp.h>
#include <cmocka.h>
#include <bar.h>

void test_bar(void **state) {
    int cnt = word_count("Hello World");
    assert_int_equal(cnt, 11);
}
