#pragma once
#include <boost/uuid/uuid.hpp>
#include <boost/uuid/uuid_generators.hpp>
#include <boost/uuid/uuid_io.hpp>
#include <string>

namespace lib2 {
std::string helloFromLib2();
boost::uuids::uuid uuid();
} // namespace lib2
