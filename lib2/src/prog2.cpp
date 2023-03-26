#include "lib2/lib2.h"

namespace lib2 {
std::string helloFromLib2() {
  return std::string( "Hello from Lib2" );
}

boost::uuids::uuid uuid() {
  return boost::uuids::random_generator()();
}
}  // namespace lib2
