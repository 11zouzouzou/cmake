#include <cmath>
#include "MathFunctions.h"
//在mathFunction/CMAKELists.txt中注入
#ifdef USE_MYMATH
#include "mysqrt.h"
#endif

namespace mathfunctions
{
    double sqrt(double x)
    {
#ifdef USE_MYMATH
        return detail::mysqrt(x); // mysqrt.h也在mathfunctions命名空间下
#else
        return std::sqrt(x);
#endif
    }
}