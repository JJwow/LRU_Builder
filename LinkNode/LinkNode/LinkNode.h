//
//  LinkNode.h
//  LinkNode
//
//  Created by fly on 2020/4/6.
//  Copyright © 2020 JJWOW. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinkNode : NSObject

@property (nonatomic, strong) NSNumber *key;

@property (nonatomic, copy) NSString *data;

@property (nonatomic, strong, nullable) LinkNode *parentNext;//父节点

@property (nonatomic, strong, nullable) LinkNode *childNext;//子节点

@end

@interface LinkList : NSObject

@property (nonatomic, assign) NSUInteger capacity;

@property (nonatomic, assign, readonly) NSUInteger count;

//初始化
- (nullable instancetype)initWithCapacity:(NSUInteger)capacity;
//取值
- (nullable NSString *)objectForKeyedSubscript:(NSNumber *)key;
//赋值
- (void)setObject:(NSString *)obj forKeyedSubscript:(NSNumber *)key;
@end

NS_ASSUME_NONNULL_END
