#include <cmath>
#include <iostream>

#include "TutorialConfig.h"

//宏判断
#ifdef USE_MYMATH
#include "MathFunctions.h"
#endif
int main(int argc, char *argv[])
{
    // argc 参数个数，argv 参数值
    if (argc < 2)
    {
        std::cout << argv[0] << " Version " << Tutorial_VERSION_MAJOR << "."
                  << Tutorial_VERSION_MINOR << std::endl;
        std::cout << "Usage: " << argv[0] << " number" << std::endl;
        return 1;
    }
    // convert input to double
    //替换atof为 std::stodin为我们的项目添加一些 C++11 功能
    const double inputValue = std::stod(argv[1]);
#ifdef USE_MYMATH
    // calculate square root by my function
    const double outputValue = mysqrt(inputValue);
#else
    // calculate square root
    const double outputValue = sqrt(inputValue);
#endif

    std::cout << "The square root of " << inputValue << " is " << outputValue
              << std::endl;
    return 0;
}