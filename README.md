# DSLViewMessage
用法：
#import "UIView+DSLMessage.h"
```
/**
 *  信息显示方法，不需要的部分传nil/0
 *
 *  @param message    文本
 *  @param subMessage 子文本
 *  @param image      图片
 *  @param buttonText 按钮文字
 *  @param block      按钮点击block
 *  @param yOffset    在y轴上的偏移，默认0
 */
- (void)dsl_showMessage:(NSString *)message
             subMessage:(NSString *)subMessage
                  image:(UIImage *)image
             buttonText:(NSString *)buttonText
       buttonClickBlock:(ButtonClickBlock)block
                yOffset:(CGFloat)yOffset;
                
/**
 *  去除信息显示
 */
- (void)dsl_removeMessage;

/**
 *  指示器显示方法，不需要的部分传nil/0
 *
 *  @param style   指示器风格
 *  @param message 文本
 *  @param isLimit 是否限制交互，默认否
 *  @param yOffset y轴上的偏移，默认0
 */
- (void)dsl_showIndicatorWithStyle:(DSLIndicatorStyle)style
                          message:(NSString *)message
                            limit:(BOOL)isLimit
                          yOffset:(CGFloat)yOffset;
                          
/**
 *  去除指示器
 */
- (void)dsl_removeIndicator;
```
##效果图：

![](https://github.com/dengshunlai/DSLViewMessage/raw/master/showMessage.png)
![](https://github.com/dengshunlai/DSLViewMessage/raw/master/activityIndicator.png)
