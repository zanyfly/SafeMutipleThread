### 多线程关键词

共享资源 Sharing of Resources

互斥锁 Mutex Lock 

死锁 Dead Lock （一句话，一直在等，却盼不到结束）

资源饥饿 Starvation （本文代码中的多读取单写入方式，解决这个问题）

优先级反转 Priority Inversion

[资料](https://objccn.io/issue-2-1/#priority_inversion)

### 多线程访问同一资源的安全问题

解决方案很多，比如synchronization block、NSLock、OSSpinLock（[不安全了](http://blog.ibireme.com/2016/01/16/spinlock_is_unsafe_in_ios/)）等。资料上表示这两种方式效率都不是很高。拿同步块来说，比如一个类里有100个属性，每个都加了 `synchronized(self) `。好了，每一个属性的访问的时候，都要确保另外99个访问完毕才能执行。

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

再说说GCD的方式，利用 `dispath_barrier_async `，在一个并发的队列中竖立一个有效的栅栏。具体的解释就不说了，代码的注释有描述。还可以看下 `SDWebImageDownloader `的源代码，里面就是用的这种方式。我个人而言，比较喜欢这种方式。

有很多人测试过这几种方式的性能，可以看下这篇博客，[iOS同步对象性能对比](http://ksnowlv.github.io/blog/2014/09/07/ios-tong-bu-suo-xing-neng-dui-bi/)







