# silkconv
This is a simple DockerFile to convert silk audio to other format: amr or the others.

[中文文档](./README_cn.md)

# Usage

1. Build image
```
docker build -t silkconv:1.0.0 .

```
2. Run as a commandline

```
docker run --rm -v $PWD:/working silkconv:1.0.0  /working/demo.silk amr
```

The last input param is the target format.

# Todos
* as a http server

# Reference
[silk-v3-decoder](https://github.com/kn007/silk-v3-decoder)