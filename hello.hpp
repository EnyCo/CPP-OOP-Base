#ifndef hello_hpp
#define hello_hpp

// --------
// includes
// --------

#include <algorithm> // count, min_element, transform
#include <cassert>   // assert
#include <map>       // map
#include <string>    // string
#include <vector>    // vector

#include <iostream> // cin, cout, endl
#include <sstream>  // istringstream

#include "gtest/gtest.h"

using namespace std;

int tester(int inp) {
    cout << "Hello, World!" << endl;
    return inp + 1;
}

#endif