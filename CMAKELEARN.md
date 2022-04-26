# cmake 学习

## 入门

> [官网教程指南](https://cmake.org/cmake/help/latest/guide/tutorial/index.html#guide:CMake%20Tutorial)

## 笔记

### Step1~X 运行编译

1. 终端目录移到 StepX/build 下
2. 执行

```bash
  cmake ../
```

> 执行完后会存在 cmakeCache 与 Makefile 3. 编译

```bash
 cmake --build .
```

## Step1

> 基础编译

1. 测试

> 执行后得到可执行文件 Tutorial 4. 测试

```bash
 ./Tutorial 16
```

> 执行后结果应该为

```
now The square root of 16 is 4
```

## Step2

> 编译注入版本号，使用特定版本 c++

1. 测试

> 执行后得到可执行文件 Tutorial 4. 测试

```bash
 ./Tutorial
```

> 执行后结果应该为

```
./Tutorial Version 1.0
Usage: ./Tutorial number
```

## Step3

> 添加自定义 c++库需要进行的配置

1. 测试

> 执行后得到可执行文件 Tutorial 4. 测试

```bash
 ./Tutorial 16
```

> 执行后结果应该为

1.

```
computing sqrt og16to be8.5
computing sqrt og16to be5.19118
computing sqrt og16to be4.13666
computing sqrt og16to be4.00226
computing sqrt og16to be4
computing sqrt og16to be4
computing sqrt og16to be4
computing sqrt og16to be4
computing sqrt og16to be4
computing sqrt og16to be4
The square root of 16 is 4
```

2. 若编译是后加-DUSE_MYMATH=OFF

```
The square root of 16 is 4
```

## Step4

> 基于 Step3 做了 usage requirements 优化编译指令

1. 测试
   结果同 Step3

## Step5

> 基于 Step4 增加安装规则与测试

1. 测试

> 执行后得到可执行文件 Tutorial 4. 测试，

### test

> 此时会比 Step4 中的 cmake build 出的文件中会多出 CTestTestFfile.cmake,意味着可以执行在 cmakelists 中写的测试

```bash
ctest
```

> 结果
> build 文件夹中出现 Testing 文件夹
> 控制台输出对应结果

### install

````
```bash
cmake --install . --prefix "install"
````

> 结果
> 会在平级的 install 文件中出现需要安装的文件

## Step6

> 基于 Step5 增加 CheckSymbolExists， 检查当前系统是否支持的函数，并且在程序代码中使用宏判断，主要修改在 MathFunction 中

1. 测试

```bash
./Tutorial 16
```

> 结果
> 不同平台可能有不同结果
支持的`Computing sqrt of 16 to be 4 using log and exp The square root of 16 is 4`
不支持的`Computing sqrt of 16 to be 4  The square root of 16 is 4`

## Step7

> 基于Step6 ,添加自定义命令,生成Table.h文件, mysqrt绑定Table.h,生成的最终Tutorial可在mysqrt中查询1~10的

1. 测试

```bash
./Tutorial 3
```

> 结果

```bash
Use the table to help find an initial value 
table value: 1.73205
computing sqrt og3to be1.73205
computing sqrt og3to be1.73205
computing sqrt og3to be1.73205
computing sqrt og3to be1.73205
computing sqrt og3to be1.73205
computing sqrt og3to be1.73205
computing sqrt og3to be1.73205
computing sqrt og3to be1.73205
computing sqrt og3to be1.73205
computing sqrt og3to be1.73205
```
## Step8

> 基于Step7,打包安装程序

1. 打包

> 执行完build后，执行 cpack :打包安装程序or cpack --config CPackSourceConfig.cmake :打包源码 cpack -G ZIP:使用zip压缩

2. 结果

> 在build导出了压缩包，cmake多了cpack

## Step9

> 基于Step8,添加对测试仪表板的支持,增加CTestConfig.cmake

1. 测试

```bash
ctest [-VV] -D Experimental 
# 对于多配置生成器（例如 Visual Studio），必须指定配置类型
or ctest [-VV] -C Debug -D Experimental 
```

> 结果

```bash
...
100% tests passed, 0 tests failed out of 9

Total Test time (real) =   0.14 sec
Performing coverage
 Cannot find any coverage files. Ignoring Coverage request.
Submit files
   SubmitURL: http://my.cdash.org/submit.php?project=CMakeTutorial
   Uploaded: /Users/zou/Downloads/github/cmake/cmake/Step9/build/Testing/20220426-1244/Configure.xml
   Uploaded: /Users/zou/Downloads/github/cmake/cmake/Step9/build/Testing/20220426-1244/Build.xml
   Uploaded: /Users/zou/Downloads/github/cmake/cmake/Step9/build/Testing/20220426-1244/Test.xml
   Uploaded: /Users/zou/Downloads/github/cmake/cmake/Step9/build/Testing/20220426-1244/Done.xml
   Submission successful
```

