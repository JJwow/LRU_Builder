//
//  main.m
//  LinkNode
//
//  Created by fly on 2020/4/6.
//  Copyright © 2020 JJWOW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkNode.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        LinkList *cache = [[LinkList alloc] initWithCapacity:2];
        cache[@1] = @"a";
        cache[@2] = @"b";
        cache[@3] = @"c";                   // 设置缓存后，移除了 "a"
        NSLog(@"%@", cache[@1]);            // 输出 (null)
        NSLog(@"%@", cache[@2]);            // 输出 "b"
        cache[@4] = @"d";                   // 设置缓存后，移除了 "c"
        NSLog(@"%@", cache[@3]);            // 输出 (null)
        NSLog(@"%@", cache[@4]);            // 输出 "d"
        cache.capacity = 1;                 // 缩容失败
        NSLog(@"%@", @(cache.capacity));    // 输出 2
        cache.capacity = 3;                 // 扩容成功
        cache[@5] = @"e";
        NSLog(@"%@", @(cache.count));       // 输出 3
        NSLog(@"%@", cache[@2]);            // 输出 "b"
        cache[@6] = @"f";                   // 设置缓存后，移除了 "e"
        NSLog(@"%@", cache[@4]);            // 输出 "d"
    }
    return 0;
}
