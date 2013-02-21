//
//  Task+Control.h
//  BasicIOSProjectWithCoreData
//
//  Created by MATSUKI Hidenori on 2/19/13.
//  Copyright (c) 2013 Matsuki Hidenori. All rights reserved.
//

#import "TaskEntity.h"

@interface TaskEntity (Control)
/*!
 @method
 @abstract 全件取得する
 @result タスクの配列
 */
+ (NSArray *)all;
/*!
 @method
 @abstract 全件取得する(テンプレートを使用)
 @result タスクの配列
 */
+ (NSArray *)allWithTemplate;
/*!
 @method
 @abstract タイトルに特定の文字列が含まれるタスクを取得する
 @param variable タイトルに含まれる文字列
 @result タスクの配列
 */
+ (NSArray *)fetchTasksWhereTitleLike:(NSString *)variable;
/*!
 @method
 @abstract タイトルに特定の文字列が含まれるタスクを取得する(テンプレートを使用)
 @param variable タイトルに含まれる文字列
 @result タスクの配列
 */
+ (NSArray *)fetchTasksWithTemplateWhereTitleLike:(NSString *)variable;
/*!
 @method
 @abstract テンプレートの設定を行う
 */
+ (void)setupTemplates;
@end
