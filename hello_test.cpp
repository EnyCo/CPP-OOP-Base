// ---------------
// test_hello.cpp
// ---------------

//Unit Tests!

// --------
// includes
// --------

#include <map>    // map
#include <string> // string
#include <vector> // vector

#include "gtest/gtest.h"

#include "hello.hpp"

using namespace std;

// ----------------
// hello_test_eval
// ----------------

TEST(grades_eval, test_0) {
    const int test = tester(0);
    ASSERT_EQ(test, 1);
}
