# DSLViewMessage
用法：
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
```
![](https://github.com/dengshunlai/DSLViewMessage/raw/master/showMessage.png)
