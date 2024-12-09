.DEFAULT_GOAL := all
SHELL         := bash

ASTYLE        := astyle
BOOST         := /usr/include/boost
CPPCHECK      := cppcheck
CXX           := g++
CXXFLAGS      := --coverage -g -std=c++20 -Wall -Wextra -Wpedantic
GCOV          := gcov
GTEST         := /usr/include/gtest
LDFLAGS       := -lgtest -lgtest_main -pthread
LIB           := /usr/lib
VALGRIND      := valgrind

FILES :=                    \
    hello					\
	hello_test

%: %.cpp
	$(CPPCHECK) $<
	$(CXX) $(CXXFLAGS) $< -o $@ $(LDFLAGS)

%.cppx: %
	./$<

%.cppy: %
	$(VALGRIND) ./$<
ifeq ($(shell uname -s), hello)
	$(GCOV) $<-$<.cpp | grep -B 2 "cpp.gcov"
else
	$(GCOV) $<.cpp | grep -B 2 "cpp.gcov"
endif


# compile run harness
run: hello.cpp
	-$(CPPCHECK) hello.cpp
	$(CXX) $(CXXFLAGS) hello.cpp -o hello

# compile test harness
hello_test: hello.hpp hello_test.cpp
	-$(CPPCHECK) hello_test.cpp
	$(CXX) $(CXXFLAGS) hello_test.cpp -o hello_test $(LDFLAGS)

# compile all
all: $(FILES)

# execute test harness with coverage
test: hello_test
	$(VALGRIND) ./hello_test
	$(GCOV) hello_test.cpp | grep -B 2 "hpp.gcov"

# auto format the code
format:
	$(ASTYLE) hello.hpp
	$(ASTYLE) hello.cpp
	$(ASTYLE) hello_test.cpp
	
# remove executables and temporary files
clean:
	rm -f  *.gcda
	rm -f  *.gcno
	rm -f  *.gcov
	rm -f  *.gen.txt
	rm -f  *.tmp.txt
	rm -f  $(FILES)
	rm -rf *.dSYM

versions:
	uname -p

	@echo
	uname -s

	@echo
	which $(ASTYLE)
	@echo
	$(ASTYLE) --version

	@echo
	which cmake
	@echo
	cmake --version | head -n 1

	@echo
	which $(CPPCHECK)
	@echo
	$(CPPCHECK) --version

	@echo
	which $(CXX)
	@echo
	$(CXX) --version | head -n 1

	@echo
	which $(GCOV)
	@echo
	$(GCOV) --version | head -n 1

	@echo
	which git
	@echo
	git --version

	@echo
	which make
	@echo
	make --version | head -n 1

ifneq ($(VALGRIND),)
	@echo
	which $(VALGRIND)
	@echo
	$(VALGRIND) --version
endif

	@echo
	which vim
	@echo
	vim --version | head -n 1

	@echo
	grep "#define BOOST_LIB_VERSION " $(BOOST)/version.hpp

	@echo
	ls -al $(GTEST)/gtest.h
	@echo
	pkg-config --modversion gtest
	@echo
	ls -al $(LIB)/libgtest*.a
