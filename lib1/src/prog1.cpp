#include "lib1/lib1.h"

namespace lib1 {

std::string helloFromLib1() {
  return std::string("Hello from Lib1");
}

std::string busAddress() {
  sd_bus* bus = nullptr;
  const char* addr;
  int r = sd_bus_default_system(&bus);
  r = sd_bus_get_address(bus, &addr);
  if (r < 0)
    return std::string {"error opening bus connection"};

  std::string s {addr};
  bus = sd_bus_unref(bus);
  return std::string {s};
}

std::byte getByte() {
  return std::byte{10};
}

}  // namespace lib1
