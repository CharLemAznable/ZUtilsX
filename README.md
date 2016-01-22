# zutilsX

收集日常开发中积累的工具代码.

        pod "ZUtilsX", "~> 0.1.1"

[压缩包下载](https://raw.githubusercontent.com/CharLemAznable/ZUtilsX/master/ZUtilsX.tar.gz)

#####Constant

* 判断当前设备类型.

        IS_IPHONEX

* 根据设备类型获取视口变化比例.

        DeviceScale

* 判断当前系统版本.

        IOSX_OR_LATER

* IOS7及其后, 状态栏透明, 顶级视图需在顶部增加20个Point高度的空白.

        statusBarHeight

* IOS7之前, 状态栏不透明, 全屏视图需上移20个Point, 隐藏在状态栏后.

        statusBarFix

* 当前应用的BundleID和Version字符串.

        appIdentifier
        appVersion

* 调试输出宏

        ZLog(fmt, ...)

#####Category (Foundation)

* NSObject+ZUX

        // 封装Selector替换方法.
        +swizzleInstanceOriSelector:withNewSelector:
        +swizzleInstanceOriSelector:withNewSelector:fromClass:
        +swizzleClassOriSelector:withNewSelector:
        +swizzleClassOriSelector:withNewSelector:fromClass:

        // 多键添加/移除KVO方法.
        -addObserver:forKeyPaths:options:context:
        -removeObserver:forKeyPaths:context:
        -removeObserver:forKeyPaths:

        // 关联对象方法, 添加实例变量, 内存管理策略OBJC_ASSOCIATION_RETAIN_NONATOMIC.
        -propertyForAssociateKey:
        -setProperty:forAssociateKey:

        // 运行时工具方法.
        +zuxProtocols
        +enumerateZUXProtocolsWithBlock:
        -enumerateZUXProtocolsWithBlock:

        +zuxIvars
        +zuxIvarForName:
        +enumerateZUXIvarsWithBlock:
        -enumerateZUXIvarsWithBlock:

        +zuxProperties
        +zuxPropertyForName:
        +enumerateZUXPropertiesWithBlock:
        -enumerateZUXPropertiesWithBlock:

        +zuxMethods
        +zuxInstanceMethodForName:
        +zuxClassMethodForName:
        +enumerateZUXMethodsWithBlock:
        -enumerateZUXMethodsWithBlock:

* NSObject+ZUXJson

        // 添加json化工具方法.
        -zuxJsonObject
        -zuxJsonData
        -zuxJsonString

        // 添加反json化工具方法
        -initWithJsonObject:
        +valueWithJsonObject: // 仅NSValue类

        // 遍历对象属性列表, 生成JSON字符串.
        // 如果属性由NSObject定义, 则忽略.
        // 如果指定的属性为弱引用, 则json化时默认忽略.
        // 如果指定的属性为弱引用/只读, 则反json化时默认忽略.

* NSNull+ZUX

        //封装判断空对象方法.
        +isNull:
        +isNotNull:

* NSNumber+ZUX

        // 添加NSNumber与CGFloat兼容方法.
        +numberWithCGFloat:
        -initWithCGFloat:
        -cgfloatValue

        // 添加字符串数字化方法. (NSString)
        -cgfloatValue

* NSCoder+ZUX

        // 添加NSCoder与CGFloat兼容方法.
        -encodeCGFloat:forKey:
        -decodeCGFloatForKey:

* NSArray+ZUX

        // 深拷贝数组.
        -deepCopy

        // 可变深拷贝数组.
        -deepMutableCopy

        // 取数组元素值方法, 可指定默认返回值.
        -objectAtIndex:defaultValue:

        // 在SDK < 6.0时, 添加下标读写方法.
        // (NSArray)
        -objectAtIndexedSubscript:
        // (NSMutableArray)
        -setObject:atIndexedSubscript:

        // 读取应用程序沙盒/Bundle中的文件.
        -initWithContentsOfUserFile:
        -initWithContentsOfUserFile:subpath:
        -initWithContentsOfUserFile:inDirectory:
        -initWithContentsOfUserFile:inDirectory:subpath:
        -initWithContentsOfUserFile:bundle:
        -initWithContentsOfUserFile:bundle:subpath:

        +arrayWithContentsOfUserFile:
        +arrayWithContentsOfUserFile:subpath:
        +arrayWithContentsOfUserFile:inDirectory:
        +arrayWithContentsOfUserFile:inDirectory:subpath:
        +arrayWithContentsOfUserFile:bundle:
        +arrayWithContentsOfUserFile:bundle:subpath:

        // 写入应用程序沙盒中的文件.
        -writeToUserFile:
        -writeToUserFile:inDirectory:
        -writeToUserFile:inDirectory:subpath:

* NSDictionary+ZUX

        // 深拷贝字典.
        -deepCopy

        // 可变深拷贝字典.
        -deepMutableCopy

        // 取字典元素值方法, 可指定默认返回值.
        -objectForKey:defaultValue:

        // 根据Key数组取子字典方法. (区别于-dictionaryWithValuesForKeys:方法, 字典中不包含的Key不会放入子字典.)
        -subDictionaryForKeys:

        // 在SDK < 6.0时, 添加下标读写方法.
        // (NSDictionary)
        -objectForKeyedSubscript:
        // (NSMutableDictionary)
        -setObject:forKeyedSubscript:

        // 读取应用程序沙盒/Bundle中的文件.
        -initWithContentsOfUserFile:
        -initWithContentsOfUserFile:subpath:
        -initWithContentsOfUserFile:inDirectory:
        -initWithContentsOfUserFile:inDirectory:subpath:
        -initWithContentsOfUserFile:bundle:
        -initWithContentsOfUserFile:bundle:subpath:

        +dictionaryWithContentsOfUserFile:
        +dictionaryWithContentsOfUserFile:subpath:
        +dictionaryWithContentsOfUserFile:inDirectory:
        +dictionaryWithContentsOfUserFile:inDirectory:subpath:
        +dictionaryWithContentsOfUserFile:bundle:
        +dictionaryWithContentsOfUserFile:bundle:subpath:

        // 写入应用程序沙盒中的文件.
        -writeToUserFile:
        -writeToUserFile:inDirectory:
        -writeToUserFile:inDirectory:subpath:

- NSData+ZUX

        // Base64转码方法.
        -base64EncodedString
        +dataWithBase64String:

- NSString+ZUX

        // 判断空字符串.
        -isEmpty
        -isNotEmpty

        // 裁剪空白字符串.
        -trim
        -trimToNil

        // 首字母大写, 其它字母不变. (-capitalizedString方法有此bug)
        -capitalized

        //  判断字符串相等(忽略大小写).
        -isCaseInsensitiveEqual:
        -isCaseInsensitiveEqualToString:

        //  版本号字符串比较方法.
        -compareToVersionString:

        // 定位子字符串.
        -indexOfString:
        -indexCaseInsensitiveOfString:
        -indexOfString:fromIndex:
        -indexCaseInsensitiveOfString:fromIndex:

        // 判断是否包含子字符串.
        -containsString:
        -containsCaseInsensitiveString:
        -containsAnyOfStringInArray:
        -containsAnyOfCaseInsensitiveStringInArray:
        -containsAllOfStringInArray:
        -containsAllOfCaseInsensitiveStringInArray:

        // 切割字符串为数组.
        -arraySplitedByString:
        -arraySplitedByCharactersInSet:
        -arraySplitedByString:filterEmptyItem:
        -arraySplitedByCharactersInSet:filterEmptyItem:

        // 类构造方法, 根据NSArray构造字符串.
        +stringWithArray:
        +stringWithArray:separator:

        // 追加对象到字符串末尾.
        -appendWithObjects:

        // 替换字符串.
        -stringByReplacingString:withString:
        -stringByCaseInsensitiveReplacingString:withString:
        -stringByReplacingCharactersInSet:withString:
        -stringByReplacingCharactersInSet:withString:mergeContinuous:

        // URL字符串转义方法.
        -stringByEscapingForURLQuery
        -stringByUnescapingFromURLQuery

        // 计算MD5.
        -MD5Sum

        // 计算SHA1.
        -SHA1Sum

        // Base64转码方法.
        -base64EncodedString
        +stringWithBase64String:

        // Unicode/UTF8互转方法.
        +replaceUnicodeToUTF8:
        +replaceUTF8ToUnicode:

        // 参数化字符串方法, 替换字符串中的"${key}"为[object valueForKey:@"key"].
        -parametricStringWithObject:

        // 计算字符串占据的尺寸(适配IOS7及以上的系统)
        -zuxSizeWithFont:constrainedToSize:

- NSValue+ZUX

        // 增加NSValue对结构类型的KVC处理.
        -valueForKey:
        -valueForKeyPath:

        // 增加自定义结构体boxed分类定义/实现宏.
        struct_boxed_interface(structType)
        struct_boxed_implementation(structType)

        // 自定义结构体boxed示例
        typedef struct {
          ...
        } CustomStruct;
        @struct_boxed_interface(CustomStruct)
        @struct_boxed_implementation(CustomStruct)

        // 调用示例
        CustomStruct customStruct = { ... };
        NSValue * structValue = [NSValue valueWithCustomStruct:customStruct];
        CustomStruct customStruct2 = [structValue CustomStructValue];

- NSExpression+ZUX

        // NSExpression保留字列表.
        +keywordsArrayInExpressionFormat

        // NSExpression格式化参数构造方法, 替换${keyPath}为%K, 并添加绑定参数keyPath.
        +expressionWithParametricFormat:

- NSDate+ZUX

        // 获得毫秒单位时间间隔.
        -timeIntervalMillsSinceDate:

        // 添加只读属性.
        timeIntervalMillsSinceNow
        timeIntervalMillsSince1970

        // 添加只读属性.
        era
        year
        month
        day
        hour
        minute
        second
        weekday

        // 时间格式化工具方法.
        -stringWithDateFormat:

        // 字符串格式时间工具方法. (NSString)
        -dateWithDateFormat:

        // 添加毫秒数据类型:
        ZUXTimeIntervalMills

        // 添加毫秒数据类型box/unbox方法. (NSNumber)
        +numberWithMills:
        -initWithMills:
        -millsValue

        // 添加字符串数字化方法. (NSString)
        -millsValue

#####Category (UIKit)

- UIDevice+ZUX

        // 添加读取设备型号方法.
        -fullModel          // 如: iPhone7,1
        -purifiedFullModel  // 如: iPhone 6Plus

- UIApplication+ZUX

        // 远程通知注册与检测方法.
        +registerUserNotificationTypes:
        -registerUserNotificationTypes:
        +registerUserNotificationTypes:categories:
        -registerUserNotificationTypes:categories:
        +notificationTypeRegisted:
        -notificationTypeRegisted:
        +noneNotificationTypeRegisted
        -noneNotificationTypeRegisted

- UIView+ZUX

        // 添加属性: (Layer)
        masksToBounds
        cornerRadius
        borderWidth
        borderColor
        shadowColor
        shadowOpacity
        shadowOffset
        shadowSize.

        // 添加截图方法.
        -imageRepresentation

        // 添加属性: (Layout, animatable)
        zTransform
        zLeft
        zRight
        zTop
        zBottom
        zWidth
        zHeight
        zCenterX
        zCenterY
        zView

        // 构造自适应UIView
        // 依据superview.bounds自适应frame
        // transform中可设置:
        //   1. left
        //   2. right
        //   3. top
        //   4. bottom
        //   5. width
        //   6. height
        //   7. centerX
        //   8. centerY
        //   9. view
        // 适应方式为:
        //   1. margin默认为0
        //   2. width/height默认为view的width/height减去同坐标轴上的margin
        //   3. 根据leftMargin&width&rightMargin计算frame.origin.x & frame.size.width
        //   4. 根据topMargin&height&bottomMargin计算frame.origin.y & frame.size.height
        //   5. 当设置center值时, 使用设置的center值替代上述计算中的中间值center
        //   6. 当同坐标轴上的尺寸和留白都设置时, width&height保持原始设置值, 等量增减双向的margin进行缩放以适应view.bounds
        // 算式见ZUXTransform.m - constraintOriginAndSize(UIView*, CGFloat, id, id, id, id, CGFloat*, CGFloat*)
        -initWithTransform:

        PS: transform中可用于定义变换式的类型有:
        - NSNumber及其子类(转换为CGFloat类型)
        - ZUXConstraint及其子类(取出block传入view计算结果)
        - NSExpression及其子类(expressionValueWithObject:view, 获得结果的CGFloat值)
        - NSString及其子类([NSExpression expressionWithParametricFormat:transform]获得NSExpression对象, 按NSExpression及其子类进行计算)

        // 自定义动画
        -zuxAnimate:
        -zuxAnimate:completion:

        // 自定义动画相关枚举与结构体
        (NS_OPTIONS)    ZUXAnimateType // 指定动画类型, 如平移/透明/翻页/缩放等
        (NS_OPTIONS)    ZUXAnimateDirection // NS_OPTIONS, 指定平移/翻页动画方向

        (struct)        ZUXAnimation // 定义动画类型/方向/持续时间/延迟时间

        // 通用badge
        -showBadge
        -showBadgeWithValue:
        -hideBadge

        // 通用badge相关属性
        badgeTextFont
        badgeTextColor
        badgeColor
        badgeOffset
        badgeSize

        // 自定义样式方法
        +borderWidth
        +setBorderWidth:
        +borderColor
        +setBorderColor:
        +shadowColor
        +setShadowColor:
        +shadowOpacity
        +setShadowOpacity:
        +shadowOffset
        +setShadowOffset:
        +shadowSize
        +setShadowSize:

        +badgeTextFont
        +setBadgeTextFont:
        +badgeTextColor
        +setBadgeTextColor:
        +badgeColor
        +setBadgeColor:
        +badgeOffset
        +setBadgeOffset:
        +badgeSize
        +setBadgeSize:

- UIControl+ZUX

        // 添加-(someAttribute)ForState:方法
        -borderWidthForState:
        -borderColorForState:
        -shadowColorForState:
        -shadowOpacityForState:
        -shadowOffsetForState:
        -shadowSizeForState:

        // 添加-set(SomeAttribute):forState:方法
        -setBorderWidth:forState:
        -setBorderColor:forState:
        -setShadowColor:forState:
        -setShadowOpacity:forState:
        -setShadowOffset:forState:
        -setShadowSize:forState:

        // 自定义样式方法
        +borderWidthForState:
        +setBorderWidth:forState:
        +borderColorForState:
        +setBorderColor:forState:
        +shadowColorForState:
        +setShadowColor:forState:
        +shadowOpacityForState:
        +setShadowOpacity:forState:
        +shadowOffsetForState:
        +setShadowOffset:forState:
        +shadowSizeForState:
        +setShadowSize:forState:

- UILabel+ZUX

        // 计算Label合适的尺寸.
        -sizeThatConstraintToSize:

- UIImage+ZUX

        // 生成点图像并指定颜色.
        +imagePointWithColor:

        // 生成矩形图像并指定颜色.
        +imageRectWithColor:size:

        // 生成渐变矩形图像.
        +imageGradientRectWithStartColor:endColor:direction:size:
        +imageGradientRectWithColors:locations:direction:size:

        // 生成椭圆形图像并指定颜色.
        +imageEllipseWithColor:size:

        // 获取对应当前设备尺寸的图片名称或图片对象.
        // 依据不同尺寸图片命名后缀规则:
        //   - 6P: -800-Portrait-736h
        //   - 6: -800-667h
        //   - 5: -700-568h
        //   - 其他: @2x或无后缀
        +imageForCurrentDeviceNamed:
        +imageNameForCurrentDeviceNamed:

        // 获取图片主色调.
        -dominantColor

        // 读取应用程序沙盒/Bundle中的文件.
        +imageWithContentsOfUserFile:
        +imageWithContentsOfUserFile:subpath:
        +imageWithContentsOfUserFile:inDirectory:
        +imageWithContentsOfUserFile:inDirectory:subpath:
        +imageWithContentsOfUserFile:bundle:
        +imageWithContentsOfUserFile:bundle:subpath:

        // 写入应用程序沙盒中的文件.
        -writeToUserFile:
        -writeToUserFile:inDirectory:
        -writeToUserFile:inDirectory:subpath:

- UITextField+ZUX

        // 限制输入文本内容及长度.
        -shouldChangeCharactersInRange:replacementString:limitWithLength:

- UITextView+ZUX

        // 限制输入文本内容及长度.
        -shouldChangeCharactersInRange:replacementString:limitWithLength:

- UIColor+ZUX

        // 根据255格式颜色生成UIColor.
        +colorWithIntegerRed:green:blue:
        +colorWithIntegerRed:green:blue:alpha:

        // 根据十六进制字符串格式颜色生成UIColor.
        +colorWithRGBHexString:
        +colorWithRGBAHexString:

        // 获取RGBA ColorSpace的CGColorRef.
        -rgbaCGColorRef

        // 判断颜色是否相同, 使用rgbaCGColorRef实现比较.
        -isEqualToColor:

- UIViewController+ZUX

        // 添加属性.
        statusBarStyle

        // 添加方法.
        -setStatusBarStyle:animated:

        // 激活此Category后, UIViewController的子类将自动按照其覆盖声明的主view属性类型, 创建UIView子类的对象, 并自动注入控制器的主view属性.
        @interface XView : UIView
        @end
        @implementation XView
        @end

        @interface XViewController : UIViewController
        @property (nonatomic, strong) XView* view;
        @end
        @implementation XViewController
        - (void)viewDidLoad {
            [super viewDidLoad];
            NSLog(@"%@", self.view.class); // OUTPUT: XView
        }
        @end

- UINavigationController+ZUX

        // 添加导航控制方法, 支持导航起始/结束时回调代码块.
        -pushViewController:animated:initialWithBlock:completionWithBlock:
        -popViewControllerAnimated:cleanupWithBlock:completionWithBlock:

    添加分类: UIViewController (ZUXNavigation)

        // 添加属性.
        navigationBar

        // 添加导航控制方法.
        -pushViewController:animated:
        -popViewControllerAnimated:
        -popToViewController:animated:
        -popToRootViewControllerAnimated:
        -pushViewController:animated:initialWithBlock:completionWithBlock:
        -popViewControllerAnimated:cleanupWithBlock:completionWithBlock:

        // 添加导航控制中回调方法.
        -willNavigatePush:
        -didNavigatePush:
        -willNavigatePop:
        -didNavigatePop:

- UINavigationBar+ZUX

        // 添加自定义样式方法, 可自定义透明模式, tint颜色, barTint颜色, 背景颜色/图片, 字体, 字色, 文字阴影.
        +isTranslucent
        +setTranslucent:

        +tintColor
        +setTintColor:

        +barTintColor
        +setBarTintColor:

        -defaultBackgroundImage
        -setDefaultBackgroundImage:
        +defaultBackgroundImage
        +setDefaultBackgroundImage:

        +backgroundImageForBarMetrics:
        +setBackgroundImage:forBarMetrics:

        -defaultBackgroundColor
        -setDefaultBackgroundColor:
        +defaultBackgroundColor
        +setDefaultBackgroundColor:

        -backgroundColorForBarMetrics:
        -setBackgroundColor:forBarMetrics:
        +backgroundColorForBarMetrics:
        +setBackgroundColor:forBarMetrics:

        -textFont
        -setTextFont:
        +textFont
        +setTextFont:

        -textColor
        -setTextColor:
        +textColor
        +setTextColor:

        -textShadowColor
        -setTextShadowColor:
        +textShadowColor
        +setTextShadowColor:

        -textShadowOffset
        -setTextShadowOffset:
        +textShadowOffset
        +setTextShadowOffset:

        -textShadowSize
        -setTextShadowSize:
        +textShadowSize
        +setTextShadowSize:

- UITabBar+ZUX

        // 添加只读属性, 获取TabBar的TabBarButton集合.
        barButtons

        // 添加自定义样式方法, 可自定义透明模式, 背景图片, 选中项背景图片, 选中项tint颜色, barTint颜色.
        +isTranslucent
        +setTranslucent:

        +tintColor
        +setTintColor:

        +barTintColor
        +setBarTintColor:

        +backgroundImage
        +setBackgroundImage:

        +backgroundColor
        +setBackgroundColor:

        +selectionIndicatorImage
        +setSelectionIndicatorImage:

        -selectionIndicatorColor
        -setSelectionIndicatorColor:
        +selectionIndicatorColor
        +setSelectionIndicatorColor:

        +selectedImageTintColor
        +setSelectedImageTintColor:

- UIBarItem+ZUX

        // 添加自定义样式方法, 可自定义字体, 字色, 文字阴影.
        -textFontForState:
        -setTextFont:forState:
        +textFontForState:
        +setTextFont:forState:

        -textColorForState:
        -setTextColor:forState:
        +textColorForState:
        +setTextColor:forState:

        -textShadowColorForState:
        -setTextShadowColor:forState:
        +textShadowColorForState:
        +setTextShadowColor:forState:

        -textShadowOffsetForState:
        -setTextShadowOffset:forState:
        +textShadowOffsetForState:
        +setTextShadowOffset:forState:

        -textShadowSizeForState:
        -setTextShadowSize:forState:
        +textShadowSizeForState:
        +setTextShadowSize:forState:

- UITabBarItem+ZUX

        // 实例化方法(适配IOS7以下的系统)
        +tabBarItemWithTitle:image:selectedImage:

        // 添加自定义样式方法, 可自定义文字位置偏移.
        +titlePositionAdjustment
        +setTitlePositionAdjustment:

- UIBarButtonItem+ZUX

        // 添加自定义样式方法.
        // tint颜色
        +tintColor
        +setTintColor:
        +tintColorWhenContainedIn:
        +setTintColor:whenContainedIn:

        // 背景图片/颜色
        -defaultBackgroundImage
        -setDefaultBackgroundImage:

        +defaultBackgroundImage
        +setDefaultBackgroundImage:
        +backgroundImageForState:barMetrics:
        +setBackgroundImage:forState:barMetrics:

        +defaultBackgroundImageWhenContainedIn:
        +setDefaultBackgroundImage:whenContainedIn:
        +backgroundImageForState:barMetrics:whenContainedIn:
        +setBackgroundImage:forState:barMetrics:whenContainedIn:

        -defaultBackgroundColor
        -setDefaultBackgroundColor:
        -backgroundColorForState:barMetrics:
        -setBackgroundColor:forState:barMetrics:

        +defaultBackgroundColor
        +setDefaultBackgroundColor:
        +backgroundColorForState:barMetrics:
        +setBackgroundColor:forState:barMetrics:

        +defaultBackgroundColorWhenContainedIn:
        +setDefaultBackgroundColor:whenContainedIn:
        +backgroundColorForState:barMetrics:whenContainedIn:
        +setBackgroundColor:forState:barMetrics:whenContainedIn:

        -defaultBackgroundImageForStyle:
        -setDefaultBackgroundImage:forStyle:

        +defaultBackgroundImageForStyle:
        +setDefaultBackgroundImage:forStyle:
        +backgroundImageForState:style:barMetrics:
        +setBackgroundImage:forState:style:barMetrics:

        +defaultBackgroundImageForStyle:whenContainedIn:
        +setDefaultBackgroundImage:forStyle:whenContainedIn:
        +backgroundImageForState:style:barMetrics:whenContainedIn:
        +setBackgroundImage:forState:style:barMetrics:whenContainedIn:

        -defaultBackgroundColorForStyle:
        -setDefaultBackgroundColor:forStyle:
        -backgroundColorForState:style:barMetrics:
        -setBackgroundColor:forState:style:barMetrics:

        +defaultBackgroundColorForStyle:
        +setDefaultBackgroundColor:forStyle:
        +backgroundColorForState:style:barMetrics:
        +setBackgroundColor:forState:style:barMetrics:

        +defaultBackgroundColorForStyle:whenContainedIn:
        +setDefaultBackgroundColor:forStyle:whenContainedIn:
        +backgroundColorForState:style:barMetrics:whenContainedIn:
        +setBackgroundColor:forState:style:barMetrics:whenContainedIn:

        // 背景位置偏移
        -defaultBackgroundVerticalPositionAdjustment
        -setDefaultBackgroundVerticalPositionAdjustment:

        +defaultBackgroundVerticalPositionAdjustment
        +setDefaultBackgroundVerticalPositionAdjustment:
        +backgroundVerticalPositionAdjustmentForBarMetrics:
        +setBackgroundVerticalPositionAdjustment:forBarMetrics:

        +defaultBackgroundVerticalPositionAdjustmentWhenContainedIn:
        +setDefaultBackgroundVerticalPositionAdjustment:whenContainedIn:
        +backgroundVerticalPositionAdjustmentForBarMetrics:whenContainedIn:
        +setBackgroundVerticalPositionAdjustment:forBarMetrics:whenContainedIn:

        // 文字位置偏移
        -defaultTitlePositionAdjustment
        -setDefaultTitlePositionAdjustment:

        +defaultTitlePositionAdjustment
        +setDefaultTitlePositionAdjustment:
        +titlePositionAdjustmentForBarMetrics:
        +setTitlePositionAdjustment:forBarMetrics:

        +defaultTitlePositionAdjustmentWhenContainedIn:
        +setDefaultTitlePositionAdjustment:whenContainedIn:
        +titlePositionAdjustmentForBarMetrics:whenContainedIn:
        +setTitlePositionAdjustment:forBarMetrics:whenContainedIn:

        // 返回按钮背景图片/颜色
        -defaultBackButtonBackgroundImage
        -setDefaultBackButtonBackgroundImage:

        +defaultBackButtonBackgroundImage
        +setDefaultBackButtonBackgroundImage:
        +backButtonBackgroundImageForState:barMetrics:
        +setBackButtonBackgroundImage:forState:barMetrics:

        +defaultBackButtonBackgroundImageWhenContainedIn:
        +setDefaultBackButtonBackgroundImage:whenContainedIn:
        +backButtonBackgroundImageForState:barMetrics:whenContainedIn:
        +setBackButtonBackgroundImage:forState:barMetrics:whenContainedIn:

        -defaultBackButtonBackgroundColor
        -setDefaultBackButtonBackgroundColor:
        -backButtonBackgroundColorForState:barMetrics:
        -setBackButtonBackgroundColor:forState:barMetrics:

        +defaultBackButtonBackgroundColor
        +setDefaultBackButtonBackgroundColor:
        +backButtonBackgroundColorForState:barMetrics:
        +setBackButtonBackgroundColor:forState:barMetrics:

        +defaultBackButtonBackgroundColorWhenContainedIn:
        +setDefaultBackButtonBackgroundColor:whenContainedIn:
        +backButtonBackgroundColorForState:barMetrics:whenContainedIn:
        +setBackButtonBackgroundColor:forState:barMetrics:whenContainedIn:

        // 返回按钮背景位置偏移
        -defaultBackButtonBackgroundVerticalPositionAdjustment
        -setDefaultBackButtonBackgroundVerticalPositionAdjustment:

        +defaultBackButtonBackgroundVerticalPositionAdjustment
        +setDefaultBackButtonBackgroundVerticalPositionAdjustment:
        +backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:
        +setBackButtonBackgroundVerticalPositionAdjustment:forBarMetrics:

        +defaultBackButtonBackgroundVerticalPositionAdjustmentWhenContainedIn:
        +setDefaultBackButtonBackgroundVerticalPositionAdjustment:whenContainedIn:
        +backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:whenContainedIn:
        +setBackButtonBackgroundVerticalPositionAdjustment:forBarMetrics:whenContainedIn:

        // 返回按钮文字位置偏移
        -defaultBackButtonTitlePositionAdjustment
        -setDefaultBackButtonTitlePositionAdjustment:

        +defaultBackButtonTitlePositionAdjustment
        +setDefaultBackButtonTitlePositionAdjustment:
        +backButtonTitlePositionAdjustmentForBarMetrics:
        +setBackButtonTitlePositionAdjustment:forBarMetrics:

        +defaultBackButtonTitlePositionAdjustmentWhenContainedIn:
        +setDefaultBackButtonTitlePositionAdjustment:whenContainedIn:
        +backButtonTitlePositionAdjustmentForBarMetrics:whenContainedIn:
        +setBackButtonTitlePositionAdjustment:forBarMetrics:whenContainedIn:

        // 字体, 字色, 文字阴影
        +textFontForState:whenContainedIn:
        +setTextFont:forState:whenContainedIn:

        +textColorForState:whenContainedIn:
        +setTextColor:forState:whenContainedIn:

        +textShadowColorForState:whenContainedIn:
        +setTextShadowColor:forState:whenContainedIn:

        +textShadowOffsetForState:whenContainedIn:
        +setTextShadowOffset:forState:whenContainedIn:

        +textShadowSizeForState:whenContainedIn:
        +setTextShadowSize:forState:whenContainedIn:

#####View

- ZUXView

  扩展UIView.

        // 添加属性
        backgroundImage

        // 统一初始化接口.
        -zuxInitial

- ZUXControl

  扩展UIControl.

        // 添加属性
        backgroundImage

        // 统一初始化接口.
        -zuxInitial

        // 添加变量, 指定最小点击间隔时间, 避免快速重复点击.
        extern float ZUXMinOperationInterval;

- ZUXLabel

  扩展UILabel, 可复制文本内容.

        // 统一默认设置
        self.backgroundColor = [UIColor clearColor];

        // 添加长按手势弹出菜单.

        // 添加属性
        canCopy // 是否长按弹出复制菜单

        // 添加属性
        backgroundImage
        linesSpacing // 文本行距

        // 弹出菜单数据源
        id<ZUXLabelDataSource> dataSource

        ZUXLabelDataSource
        -menuTitleOfCopyInLabel:
        -menuLocationInLabel:

- ZUXImageView

  扩展UIImageView, 可复制/保存图片.

        // 添加长按手势弹出菜单.

        // 添加属性
        canCopy // 是否长按弹出复制菜单
        canSave // 是否长按弹出保存菜单

        // 弹出菜单数据源
        id<ZUXImageViewDataSource> dataSource

        ZUXImageViewDataSource
        -menuTitleOfCopyInImageView:
        -menuTitleOfSaveInImageView:
        -menuLocationInImageView:

        // 弹出菜单功能托管
        id<ZUXImageViewDelegate> delegate

        ZUXImageViewDelegate
        -saveImageSuccessInImageView:
        -saveImageFailedInImageView:withError:

- ZUXRefreshView

  滚动刷新工具视图.

        // 属性
        direction // 滚动刷新方向
        defaultPadding // 初始边界距离
        pullingMargin // 刷新边界距离
        loadingMargin // 刷新中边界距离

        // 可重写方法
        -didScrollView:
        -didEndDragging:
        -didFinishedLoading:
        -setRefreshState:

        // 托管方法
        -refreshViewIsLoading: // 返回当前刷新状态
        -refreshViewStartLoad: // 开始刷新回调

- ZUXPageControl

  分页指示器.

        // 添加属性
        pageIndicatorColor // 默认指示色
        currentPageIndicatorColor // 当前页指示色

- ZUXSearchBar

  搜索栏组件.

#####MBProgressHUD

- MBProgressHUD

  Created by Matej Bukovinski, Version 0.9.1.

- UIView+MBProgressHUD

  扩展MBProgressHUD, 增加UIView类别方法, 用于显隐MBProgressHUD视图.

        // 在当前视图内显隐HUD的简易方法:
        -mbProgressHUD
        -showIndeterminateHUDWithText:
        -showTextHUDWithText:hideAfterDelay:
        -showTextHUDWithText:detailText:hideAfterDelay:
        -hideHUD:

        // 在当前视图及其子视图内显隐HUD的简易方法:
        -recursiveMBProgressHUD
        -showIndeterminateRecursiveHUDWithText:
        -showTextRecursiveHUDWithText:hideAfterDelay:
        -showTextRecursiveHUDWithText:detailText:hideAfterDelay:
        -hideRecursiveHUD:

#####Entities

- ZUXConstraint

  变换函数类, 用于自适应UIView的某一维度的变换式定义.

- ZUXTransform

  视图变换类, 用于自适应UIView的所有变换式定义.

- ZUXColorDictionary

  颜色字典类, 用于加载配置文件中的颜色表.

#####Utils

- ZUXCategory

    添加Category工具宏, 用于定义Category并自动加载.

        // 定义Category
        @category_interface(className, categoryName)
        // 定义包含泛型的Category
        @category_interface_generic(className, genericParam, categoryName)

        // 实现Category
        @category_implementation(className, categoryName)

        // 添加的分类将于__attribute__((constructor))时自动加载,
        // 所以可以省略Other Linker Flags: "-all_load -ObjC"

- ZUXSingleton

    添加单例宏.

        // 定义单例类
        @singleton_interface(className, superClassName)

        // 实现单例类
        @singleton_implementation(className)

        // 单例类定义示例
        @singleton_interface(MySingleton, NSObject)
        @end
        @singleton_implementation(MySingleton)
        @end

        // 单例使用示例
        [MySingleton shareMySingleton]

- ZUXGeometry

    添加二维坐标工具方法.

        CGRect ZUX_CGRectMake(CGPoint, CGSize);
        CGSize ZUX_CGSizeFromUIOffset(UIOffset offset);
        UIOffset ZUX_UIOffsetFromCGSize(CGSize size);

- ZUXProtocol

    运行时 - 协议对象.

        +allProtocols

        +protocolWithObjCProtocol:
        +protocolWithName:

        -initWithObjCProtocol:
        -initWithName:

        -objCProtocol
        -name
        -incorporatedProtocols
        -methodsRequired:instance:

- ZUXIvar

    运行时 - 实例变量对象.

        +ivarWithObjCIvar:
        +instanceIvarWithName:inClass:
        +classIvarWithName:inClass:
        +instanceIvarWithName:inClassNamed:
        +classIvarWithName:inClassNamed:
        +ivarWithName:typeEncoding:
        +ivarWithName:encode:

        -initWithObjCIvar:
        -initInstanceIvarWithName:inClass:
        -initClassIvarWithName:inClass:
        -initInstanceIvarWithName:inClassNamed:
        -initClassIvarWithName:inClassNamed:
        -initWithName:typeEncoding:

        -name
        -typeName
        -typeEncoding
        -offset

- ZUXProperty

    运行时 - 属性对象.

        +propertyWithObjCProperty:
        +propertyWithName:inClass:
        +propertyWithName:inClassNamed:
        +propertyWithName:attributes:

        -initWithObjCProperty:
        -initWithName:inClass:
        -initWithName:inClassNamed:
        -initWithName:attributes:

        -property
        -attributes
        -addToClass:

        -attributeEncodings
        -isReadOnly
        -isNonAtomic
        -isWeakReference
        -isEligibleForGarbageCollection
        -isDynamic
        -memoryManagementPolicy
        -getter
        -setter
        -name
        -ivarName
        -typeName
        -typeEncoding
        -objectClass

        // 属性内存策略枚举
        ZUXPropertyMemoryManagementPolicy

- ZUXMethod

    运行时 - 方法对象.

        +methodWithObjCMethod:
        +instanceMethodWithName:inClass:
        +classMethodWithName:inClass:
        +instanceMethodWithName:inClassNamed:
        +classMethodWithName:inClassNamed:
        +methodWithSelector:implementation:signature:

        -initWithObjCMethod:
        -initInstanceMethodWithName:inClass:
        -initClassMethodWithName:inClass:
        -initInstanceMethodWithName:inClassNamed:
        -initClassMethodWithName:inClassNamed:
        -initWithSelector:implementation:signature:

        -selector
        -selectorName
        -implementation
        -setImplementation:
        -signature

- ZUXJson

    添加JSON工具方法.

        // 默认使用NSJSONSerialization.
        // 设置布尔值ZUX_USE_JSONKIT为真值后, 使用JSONKit.
        // 修改JSONKit, 支持ARC.

        // 由JSON数据获取集合类型对象.
        +objectFromJsonData:
        +objectFromJsonString:

        // 由JSON数据获取指定类型对象.
        +objectFromJsonData:asClass:
        +objectFromJsonString:asClass:

        // 由对象转换为JSON数据.
        // 若对象不是合法的NSJSONSerialization类型, 将会先尝试转换为合法类型.
        // 若转换后仍不是合法类型, 则返回description或其UTF8编码后的NSData对象.
        +jsonDataFromObject:
        +jsonStringFromObject:

- ZUXDirectory

    添加应用目录工具.

        // 默认使用Documents目录.
        +fullFilePath:
        +fileExists:
        +deleteAllFiles
        +directoryExists:
        +createDirectory:

        // 指定使用其他目录, 如Library/Caches或tmp目录.
        // 使用枚举ZUXDirectoryType指定目录类型.
        +fullFilePath:inDirectory:
        +fileExists:inDirectory:
        +deleteAllFilesInDirectory:
        +directoryExists:inDirectory:
        +createDirectory:inDirectory:

        // 指定子目录.
        +fullFilePath:inDirectory:subpath:
        +fileExists:inDirectory:subpath:
        +deleteAllFilesInDirectory:subpath:
        +directoryExists:inDirectory:subpath:
        +createDirectory:inDirectory:subpath:

        // 应用根目录.
        // 使用枚举ZUXDirectoryType指定目录类型.
        +documentDirectoryRoot
        +cachesDirectoryRoot
        +temporaryDirectoryRoot
        +directoryRoot:

- ZUXBundle

    资源bundle工具.
    当不指定bundle参数或bundle参数为nil时, 在当前App Bundle中寻找资源文件; 否则在对应bundle中的子目录中寻找.
    当subpath参数为nil时, 在bundle根目录中寻找.

        // 读入bundle中的图片对象.
        +imageWithName:
        +imageWithName:bundle:
        +imageWithName:bundle:subpath:
        +imageForCurrentDeviceWithName:
        +imageForCurrentDeviceWithName:bundle:
        +imageForCurrentDeviceWithName:bundle:subpath:

        // 获取bundle中plist文件的完整路径.
        +plistPathWithName:
        +plistPathWithName:bundle:
        +plistPathWithName:bundle:subpath:

        // 获取bundle中音频文件URL.
        // 用于AudioServicesCreateSystemSoundID(CFURLRef, SystemSoundID*)
        +audioURLWithName:type:
        +audioURLWithName:type:bundle:
        +audioURLWithName:type:bundle:subpath:

- ZUXKeychain

    keychain工具, 重构自SFHFKeychainUtils, 支持ARC.

        +passwordForUsername:andService:error:
        +storePassword:forUsername:andService:updateExisting:error:
        +deletePasswordForUsername:andService:error:

- ZUXDataBox

    @interface ZUXDataBox

        // 判断App运行历史信息
        +appEverLaunched
        +appFirstLaunch

    @protocol ZUXDataBox

        // 数据同步方法
        -synchronize

        // 自定义用户数据存储在UserDefaults/Keychain中的键名
        // default  : 数据存储在UserDefaults中, 随App卸载而清除
        // keychain : 数据存储在Keychain中, 重装App后仍保留旧数据
        // restrict : 数据存储在Keychain中, 重装App后删除旧数据
        // share    : 数据可被全局访问/修改
        // users    : 数据读写与指定的关键字相关联

        +defaultShareKey
        +keychainShareKey
        +keychainShareDomain
        +restrictShareKey
        +restrictShareDomain

        +defaultUsersKey
        +keychainUsersKey
        +keychainUsersDomain
        +restrictUsersKey
        +restrictUsersDomain

    DataBox工具宏

        // 定义databox, 单例类, 遵循<ZUXDataBox>协议
        @databox_interface(className, superClassName)

        // 实现databox
        @databox_implementation(className)

        // 合成全局存储属性
        @default_share(className, property)
        @keychain_share(className, property)
        @restrict_share(className, property)

        // 合成关联关键字存储属性, userIdProperty指定关联的databox属性的关键字
        @default_users(className, property, userIdProperty)
        @keychain_users(className, property, userIdProperty)
        @restrict_users(className, property, userIdProperty)

        // databox定义示例
        // 注: 存储属性的内存管理类型要求为强引用.
        // 注: 存储属性合成时机为App的main方法执行前, 所以在main方法执行前调用属性getter/setter会报错, e. g. , +load方法.
        @databox_interface(UserDefaults, NSObject)
        @property (nonatomic, strong) NSString * userId;
        @property (nonatomic, strong) NSString * name;
        @property (nonatomic, strong) NSString * version;
        @end

        @databox_implementation(UserDefaults)
        @default_share(UserDefaults, userId)
        @keychain_users(UserDefaults, name, userId)
        @restrict_users(UserDefaults, version, userId)
        @end

        // databox调用示例
        [UserDefaults shareUserDefaults].userId = @"111";
        [UserDefaults shareUserDefaults].name = @"aaa";
        [UserDefaults shareUserDefaults].version = @"0.0.1";
        NSLog(@"%@", [UserDefaults shareUserDefaults].userId);  // output: 111
        NSLog(@"%@", [UserDefaults shareUserDefaults].name);    // output: aaa
        NSLog(@"%@", [UserDefaults shareUserDefaults].version); // output: 0.0.1
        [[UserDefaults shareUserDefaults] synchronize];

        [UserDefaults shareUserDefaults].userId = @"222";
        [UserDefaults shareUserDefaults].name = @"bbb";
        [UserDefaults shareUserDefaults].version = @"0.0.2";
        NSLog(@"%@", [UserDefaults shareUserDefaults].userId);  // output: 222
        NSLog(@"%@", [UserDefaults shareUserDefaults].name);    // output: bbb
        NSLog(@"%@", [UserDefaults shareUserDefaults].version); // output: 0.0.2
        [[UserDefaults shareUserDefaults] synchronize];

        [UserDefaults shareUserDefaults].userId = @"111";
        NSLog(@"%@", [UserDefaults shareUserDefaults].userId);  // output: 111
        NSLog(@"%@", [UserDefaults shareUserDefaults].name);    // output: aaa
        NSLog(@"%@", [UserDefaults shareUserDefaults].version); // output: 0.0.1

        [UserDefaults shareUserDefaults].userId = @"222";
        NSLog(@"%@", [UserDefaults shareUserDefaults].userId);  // output: 222
        NSLog(@"%@", [UserDefaults shareUserDefaults].name);    // output: bbb
        NSLog(@"%@", [UserDefaults shareUserDefaults].version); // output: 0.0.2
