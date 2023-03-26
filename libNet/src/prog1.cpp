#include "libNet/libNet.h"
#include <mongoose.h>

/*
** this is a useless and put here just to prove the linkage is good!
** see https://github.com/cesanta/mongoose/tree/master/examples for examples
*/
namespace libNet {
    struct mg_mgr mgr;
    struct mg_connection *c;
}  // namespace libNet
