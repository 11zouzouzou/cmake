#include <cmath>
#include <fstream>
#include <iostream>

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        return 1;
    }
    //以文本形式打开一个文件
    std::ofstream fout(argv[1], std::ios_base::out);
    const bool fileOpen = fout.is_open(); //判断是否打开了该文件
    if (fileOpen)
    {
        fout << "double sqrtTable[] = {" << std::endl;
        for (int i = 0; i < 10; ++i)
        {
            fout << sqrt(static_cast<double>(i)) << "," << std::endl;
        }
        // close the table with a zero
        fout << "0};" << std::endl;
        fout.close();
    }
    return fileOpen ? 0 : 1; // return 0 if wrote the file
}