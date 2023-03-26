#include "lib1/lib1.h"
#include "gtest/gtest.h"

TEST(lib1Test, helloTest) {
    EXPECT_EQ(lib1::helloFromLib1(), "Hello from Lib1");
}

TEST(lib1Test, getByteTest) {
    EXPECT_EQ(lib1::getByte(), std::byte{10});
}
