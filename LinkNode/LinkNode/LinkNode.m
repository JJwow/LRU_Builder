//
//  LinkNode.m
//  LinkNode
//
//  Created by fly on 2020/4/6.
//  Copyright © 2020 JJWOW. All rights reserved.
//

#import "LinkNode.h"

@implementation LinkNode

@end

@interface LinkList ()
{
    dispatch_semaphore_t semaphore;
}
@property (nonatomic, strong) LinkNode *head;
@property (nonatomic, strong) LinkNode *guard;
@property (nonatomic, strong) NSMutableDictionary *dic;
@end

@implementation LinkList

//初始化
- (instancetype)initWithCapacity:(NSUInteger)capacity
{
    if (self = [super init]) {
        // TODO:
        _capacity = capacity;
        _dic = [NSMutableDictionary new];
        semaphore = dispatch_semaphore_create(1);
    }
    return self;
}

//通过字典的形式获取数据
-(nullable NSString *)objectForKeyedSubscript:(NSNumber *)key{
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    LinkNode *node = [_dic objectForKey:key];
    if ([_dic objectForKey:key]) {//已经存在
        node = [_dic objectForKey:key];//找到对应的node
        if ([_dic objectForKey:key] == _head) {//是不是对头节点进行操作
            node.childNext.parentNext = nil;
            _head = node.childNext;
        }
        else{
            node.parentNext.childNext = node.childNext;
            node.childNext.parentNext = node.parentNext;
        }
        node.childNext = nil;
        node.parentNext = _guard;
        _guard.childNext = node;//将哨兵节点指向新的节点
        _guard = node;//新节点成为哨兵节点
    }
    dispatch_semaphore_signal(semaphore);
    return node.data;
}

//通过字典的形式添加数据
-(void)setObject:(NSString *)obj forKeyedSubscript:(NSNumber *)key{
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    LinkNode *node;
    if (!_head && _capacity > 0) {//头节点不存在,生成第一个节点
        node = [LinkNode new];
        node.data = obj;
        node.key = key;
        _head = node;
        _guard = _head;//第一个头节点也是哨兵节点
    }
    else {
        node = [_dic objectForKey:key];
        if (node) {//已经存在
            if ([_dic objectForKey:key] == _head) {//是不是对头节点进行操作
                node.childNext.parentNext = nil;
                _head = node.childNext;
            }
            else{
                node.parentNext.childNext = node.childNext;
                node.childNext.parentNext = node.parentNext;
            }
        }
        else{
            if (_dic.allKeys.count >= _capacity) {//LRU已满，需要清除使用最小或最早的节点
                [_dic removeObjectForKey:_head.key];
                _head = _head.childNext;//第二个节点成为head
                
            }
            node = [LinkNode new];
            node.data = obj;
            node.key = key;
        }
        node.childNext = nil;
        node.parentNext = _guard;
        _guard.childNext = node;//将哨兵节点指向新的节点
        _guard = node;//新节点成为哨兵节点
    }
    _dic[key] = node;//将第一个节点放到hash表中
    dispatch_semaphore_signal(semaphore);
}

- (NSUInteger)count
{
    // TODO
    return _dic.allKeys.count;
}

-(void)setCapacity:(NSUInteger)capacity{
    if (capacity >= _dic.allKeys.count) {
        _capacity = capacity;
    }
}

@end
