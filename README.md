### 多线程访问同一资源的安全问题

解决方案很多，比如synchronization block、NSLock。资料上表示这两种方式效率都不是很高。拿同步块来说，比如一个类里有100个属性，每个都加了 `synchronized(self) `。好了，每一个属性的访问的时候，都要确保另外99个访问完毕才能执行。

```

-(NSString *)readValue{
    @synchronized (self) {
        return _value;
    }
}

-(void)setValue:(NSString *)value{
    @synchronized (self) {
        _value  = value;
    }
}
```

所以，用GCD的方式最好了。利用 `dispath_barrier_async `，在一个并发的队列中竖立一个有效的栅栏。具体的解释就不说了，代码的注释有描述。还可以看下 `SDWebImageDownloader `的源代码，里面就是用的这种方式。

