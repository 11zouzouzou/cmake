# 添加包包名+文件
add_library(MathFunctions mysqrt.cxx)
# 指定了使用要求后，我们可以安全地从顶层移除我们对变量的使用，
#即可移除Step3中
# list(APPEND EXTRA_INCLUDES "${PROJECT_SOURCE_DIR}/MathFunction") 
target_include_directories(MathFunctions INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})