#最低版本要求
cmake_minimum_required(VERSION 3.10)

# 项目名与版本
project(Tutorial VERSION 1.0)
#c++特定版本
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# 往代码中注入 USE_MYMATH，.h.in中需使用cmakedefine,
# 此处配置后，终端编译前准备就可使用-DUSE_MYMATH=OFF进行关闭：cmake ../ -DUSE_MYMATH=OFF
option(USE_MYMATH "Use tutorial provided math implementation" ON)
#需要替换的文件
configure_file(TutorialConfig.h.in TutorialConfig.h)

if(USE_MYMATH)
   #主编译中 增加 自定义数学库子目录
    add_subdirectory(MathFunction)
    # 额外的列表命令来存储链接到库所需的信息
    list(APPEND EXTRA_LIBS MathFunctions)
    # 不再添加在子包中已做 usage reauirements
    # list(APPEND EXTRA_INCLUDES "${PROJECT_SOURCE_DIR}/MathFunction") 
endif()

#执行程序
add_executable(Tutorial tutorial.cxx)

#主编译中 链接外部的库
# 使用该变量EXTRA_LIBS来收集任何可选库，以便稍后链接到可执行文件中。该变量 EXTRA_INCLUDES类似地用于可选头文件。
target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS})

# 不再添加 ${EXTRA_INCLUDES} 在子包中已做usage reauirements
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                        #    ${EXTRA_INCLUDES}
                           )

