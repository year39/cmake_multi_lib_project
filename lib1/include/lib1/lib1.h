#pragma once
#include <cstddef>
#include <string>
#include <systemd/sd-bus.h>

namespace lib1 {
std::string helloFromLib1();
std::string busAddress();
std::byte getByte();
}  // namespace lib1
