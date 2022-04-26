#include <iostream>
#include <cmath>
#include "MathFunctions.h"
#include "Table.h"

using namespace std;
double mysqrt(double x)
{
    if (x <= 0)
    {
        return 0;
    }

    double result = x;

    if (x >= 1 && x < 10)
    {
        std::cout << "Use the table to help find an initial value " << std::endl;
        result = sqrtTable[static_cast<int>(x)];
        std::cout << "table value: " << result << std::endl;
    }

    for (int i = 0; i < 10; i++)
    {
        if (result <= 0)
        {
            result = 0.1;
        }
        double delta = x - (result * result);
        result = result + 0.5 * delta / result;

        std::cout << "computing sqrt og" << x << "to be" << result << std::endl;
    }
    return result;
}