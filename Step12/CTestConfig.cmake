set(CTEST_PROJECT_NAME "CMakeTutorial")#测试项目名称
set(CTEST_NIGHTLY_START_TIME "00:00:00 EST")#执行时间
#发送地址，提交的生成文档将被发送到的 Cdash 实例的 URL
set(CTEST_DROP_METHOD "http")
set(CTEST_DROP_SITE "my.cdash.org")
set(CTEST_DROP_LOCATION "/submit.php?project=CMakeTutorial")
set(CTEST_DROP_SITE_CDASH TRUE)