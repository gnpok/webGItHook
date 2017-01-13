## webGItHook
#### 简介
>  假设我们的代码是通过git或coding部署在线上，我们修改本地代码，希望线上也能自动更新，此时web hook就发挥它的作用。

### 常用方法
> 首先我们要配置服务器[ssh免密码登陆](http://chenlb.iteye.com/blog/211809),然后将[key配置到coding或git](https://laravel-china.org/topics/2192)

- >我们使用php运行用户如www,并将它pub_key复制到git上面去，配置相应程序就可以
- >若是root用户，但是php不允许root用户,此时该方法就用的上
-

#### 运行原理
> 利用php -S 开个端口运行php服务【可以直接访问或通过nginx反向代理],此时php运行用户就是root话以免被攻击，为了安全建使用www用户来clone代码