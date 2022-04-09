# cmake 学习

## 入门

> [官网教程指南](https://cmake.org/cmake/help/latest/guide/tutorial/index.html#guide:CMake%20Tutorial)

## 笔记

### StepX 运行编译

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
> 编译注入版本号，使用特定版本c++
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
