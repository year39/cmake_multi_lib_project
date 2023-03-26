#include <iostream>
#include <lib1/lib1.h>
#include <lib2/lib2.h>
#include <libNet/libNet.h>
#include <mongoose.h>

int main(int, char**) {
  std::cout << lib1::helloFromLib1() << ":" << lib1::busAddress() << std::endl;
  std::cout << lib2::helloFromLib2() << ":" << lib2::uuid() << std::endl;
  return 0;
}
