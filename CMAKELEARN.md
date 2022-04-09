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
