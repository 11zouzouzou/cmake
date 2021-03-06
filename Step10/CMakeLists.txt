cmake_minimum_required(VERSION 3.10)

# set the project name and version
project(Tutorial VERSION 1.0)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# todo mac
# control where the static and shared libraries are built so that on windows
# we don't need to tinker with the path to run the executable
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")

option(BUILD_SHARED_LIBS "Build using shared libraries" ON)

# configure a header file to pass the version number only
configure_file(TutorialConfig.h.in TutorialConfig.h)

# add the MathFunction dir
add_subdirectory(MathFunction)

# add the executable
add_executable(Tutorial tutorial.cxx)

#主编译中 链接外部的库
# 使用该变量EXTRA_LIBS来收集任何可选库，以便稍后链接到可执行文件中
# target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS})
target_link_libraries(Tutorial PUBLIC MathFunctions)

# 不再添加 ${EXTRA_INCLUDES} 在子包中已做usage reauirements
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                        #    ${EXTRA_INCLUDES}
                           )


install(TARGETS Tutorial DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h"
DESTINATION include
)

# 启用测试
# enable_testing()
# enable dashboard scripting
include(CTest)
# does the application run
# 只是验证应用程序是否运行，没有段错误或以其他方式崩溃，并且返回值为零。
add_test(NAME Runs COMMAND Tutorial 25)
# does the usage message work?
# 使用PASS_REGULAR_EXPRESSIONtest 属性来验证测试的输出是否包含某些字符串。在这种情况下，验证在提供不正确数量的参数时是否打印了使用消息。
add_test(NAME Usage COMMAND Tutorial)
set_tests_properties(Usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number"
  )

# define a function to simplify adding tests
#有一个调用函数do_test来运行应用程序并验证计算的平方根对于给定的输入是否正确。对于 的每次调用do_test，都会将另一个测试添加到项目中，其中包含名称、输入和基于传递的参数的预期结果。
function(do_test target arg result)
  add_test(NAME Comp${arg} COMMAND ${target} ${arg})
  set_tests_properties(Comp${arg}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result}
    )
endfunction()

# do a bunch of result based tests
do_test(Tutorial 4 "4 is 2")
do_test(Tutorial 9 "9 is 3")
do_test(Tutorial 5 "5 is 2.236")
do_test(Tutorial 7 "7 is 2.645")
do_test(Tutorial 25 "25 is 5")
do_test(Tutorial -25 "-25 is (-nan|nan|0)")
do_test(Tutorial 0.0001 "0.0001 is 0.01")

# setup installer
include(InstallRequiredSystemLibraries)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${Tutorial_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${Tutorial_VERSION_MINOR}")
set(CPACK_SOURCE_GENERATOR "TGZ")#选择源包的文件格式
include(CPack)