# silkconv
本项目旨在提供一个快速实现微信小程序语音 silk 文件格式转码的镜像，可以转换成 amr 等格式。

# Usage

1. 构造镜像
```
docker build -t silkconv:1.0.0 .

```
2. 运行命令

```
docker run --rm -v $PWD:/working silkconv:1.0.0  /working/demo.silk amr
```

最后一个参数是目标格式。

# Todos
* as a http server