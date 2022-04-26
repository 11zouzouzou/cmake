#添加MakeTable可执行文件。
add_executable(MakeTable MakeTable.cxx)
#自定义 命令
# 生成Table.h 文件
# 执行可执行文件 MakeTable 传入Table.h文件
# 明确依赖MakeTable
add_custom_command(
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/Table.h
  COMMAND MakeTable ${CMAKE_CURRENT_BINARY_DIR}/Table.h
  DEPENDS MakeTable
)

# 添加包包名+文件
# 让CMake知道mysqrt.cxx依赖于生成的文件Table.h。这是通过将生成的Table.h添加到库MathFunctions的源列表来实现的。
add_library(MathFunctions mysqrt.cxx  ${CMAKE_CURRENT_BINARY_DIR}/Table.h)
# 指定了使用要求后，我们可以安全地从顶层移除我们对变量的使用，
#即可移除Step3中
# list(APPEND EXTRA_INCLUDES "${PROJECT_SOURCE_DIR}/MathFunction") 
# 我们还必须将当前二进制目录(${CMAKE_CURRENT_BINARY_DIR})添加到include目录列表中，以便mysqrt.cxx可以找到并包含Table.h。
target_include_directories(MathFunctions INTERFACE ${CMAKE_CURRENT_SOURCE_DIR} PRIVATE ${CMAKE_CURRENT_BINARY_DIR})



# 安装规则
install(TARGETS MathFunctions DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)