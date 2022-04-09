# 添加包包名+文件
add_library(MathFunctions mysqrt.cxx)
# 指定了使用要求后，我们可以安全地从顶层移除我们对变量的使用，
#即可移除Step3中
# list(APPEND EXTRA_INCLUDES "${PROJECT_SOURCE_DIR}/MathFunction") 
target_include_directories(MathFunctions INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

# 检查是否存在log and exp 并且赋予HAVE_LOG and HAVE_EXP 为缓存变量
include(CheckSymbolExists)
check_symbol_exists(log "math.h" HAVE_LOG)
check_symbol_exists(exp "math.h" HAVE_EXP)
if(NOT (HAVE_LOG AND HAVE_EXP))
 # 清空变量
  unset(HAVE_LOG CACHE)
  unset(HAVE_EXP CACHE)
  # 设置CMAKE_REQUIRED_LIBRARIES 变量 vaule为 "m"
  set(CMAKE_REQUIRED_LIBRARIES "m")
  check_symbol_exists(log "math.h" HAVE_LOG)
  check_symbol_exists(exp "math.h" HAVE_EXP)
  if(HAVE_LOG AND HAVE_EXP)
  # 再次请求时存在则链接 ，一般走不到
    target_link_libraries(MathFunctions PRIVATE m)
  endif()
endif()

# 往代码中注入宏
if(HAVE_LOG AND HAVE_EXP)
  target_compile_definitions(MathFunctions
                             PRIVATE "HAVE_LOG" "HAVE_EXP")
endif()



# 安装规则
install(TARGETS MathFunctions DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)