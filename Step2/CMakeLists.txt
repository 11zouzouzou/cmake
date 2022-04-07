cmake_minimum_required(VERSION 3.10)

# set the project name and version
project(Tutorial VERSION 1.0)

# specify the C++ standard 使用c++ 11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# configure a header file to pass some of the CMake settings
# to the source code
# 配置一个头文件将版本号传递给源代码： @Tutorial_VERSION_MAJOR@和的值@Tutorial_VERSION_MINOR@将被替换。
configure_file(TutorialConfig.h.in TutorialConfig.h)

# add the executable
add_executable(Tutorial tutorial.cxx)

# add the binary tree to the search path for include files
# so that we will find TutorialConfig.h
# 由于配置的文件将被写入二叉树，我们必须将该目录添加到路径列表中以搜索包含文件。
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )