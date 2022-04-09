#include <iostream>
#include "MathFunctions.h"

using namespace std;
double mysqrt(double x)
{
    if (x <= 0)
    {
        return 0;
    }

    double result = x;
    for (int i = 0; i < 10; i++)
    {
        if (result <= 0)
        {
            result = 0.1;
        }
        double delta = x - (result * result);
        result = result + 0.5 * delta / result;

        std::cout << "computing sqrt og" << x << "to be" << result <<std::endl;
    }
    return result;
}