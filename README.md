# LRU_Builder
实现一个LRU（Least Recently Used）缓存数据结构，它应该支持以下操作 

1、支持初始化容量 

2、支持缓存的设置与查询（KV形式），支持下标形式 

3、查询不到的缓存返回nil 

4、设置新缓存时，如果容量已经达上限，需要清除之前使用频率最小或者最早设置的缓存， 

5、容量支持手动扩容，容量未满时可以缩容 

6、线程安全

设计思路：
使用双向链表的结构+hashMap进行实现，时间复杂度为O(1)
