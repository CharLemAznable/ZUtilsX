# zutilsX

收集日常开发中积累的工具代码.

        pod "ZUtilsX", "~> 0.0.5"

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

* 激活zutilsX内的所有Category, 省略添加Other Linker Flags: "-all_load -ObjC".

        ZUX_ENABLE_ALL_CATEGORIES

#####Category (Foundation)

* NSObject+ZUX

        // 封装Selector替换方法.
        +swizzleInstanceOriSelector:withNewSelector:
        +swizzleClassOriSelector:withNewSelector:

        // 多键添加/移除KVO方法.
        -addObserver:forKeyPaths:options:context:
        -removeObserver:forKeyPaths:context:
        -removeObserver:forKeyPaths:

        // 关联对象方法, 添加实例变量, 内存管理策略OBJC_ASSOCIATION_RETAIN_NONATOMIC.
        -propertyForAssociateKey:
        -setProperty:forAssociateKey:

* NSObject+ZUXJson

        // 添加json化工具方法.
        +zuxJsonPropertyNames
        -zuxJsonObject
        -zuxJsonData
        -zuxJsonString

        // 添加反json化工具方法
        -initWithJsonObject:

        // +zuxJsonPropertyNames方法指定当前类需要加入json转化的属性名称, 默认为空数组.
        // 如果指定的属性为弱引用/结构体, 则json化时默认忽略.
        // 如果指定的属性为弱引用/只读/结构体, 则反json化时默认忽略.

* NSNull+ZUX

        //封装判断空对象方法.
        +isNull:
        +isNotNull:

* NSNumber+ZUX

        // 添加NSNumber与CGFloat兼容方法.
        +numberWithCGFloat:
        -initWithCGFloat:
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

        // 读写应用程序目录中的文件.
        -writeToUserFile:
        +arrayWithContentsOfUserFile:
        -writeToUserFile:inDirectory:
        +arrayWithContentsOfUserFile:inDirectory:

* NSDictionary+ZUX

        // 深拷贝字典.
        -deepCopy

        // 可变深拷贝字典.
        -deepMutableCopy

        // 取字典元素值方法, 可指定默认返回值.
        -objectForKey:defaultValue:

        // 根据Key数组取子字典方法. (区别于-dictionaryWithValuesForKeys:方法, 字典中不包含的Key不会放入子字典.)
        -subDictionaryForKeys:

        // 读写应用程序目录中的文件.
        -writeToUserFile:
        +dictionaryWithContentsOfUserFile:
        -writeToUserFile:inDirectory:
        +dictionaryWithContentsOfUserFile:inDirectory:

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

#####Category (UIKit)

- UIDevice+ZUX

        // 添加读取设备型号方法.
        -fullModel          // 如: iPhone7,1
        -purifiedFullModel  // 如: iPhone 6Plus

- UIView+ZUX

        // 添加属性: (Layer)
        maskToBounds
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

- UIControl+ZUX

        // 添加-set(SomeAttribute):forState:方法
        -setBorderWidth:forState:
        -setBorderColor:forState:
        -setShadowColor:forState:
        -setShadowOpacity:forState:
        -setShadowOffset:forState:
        -setShadowSize:forState:

        // 添加-(someAttribute)ForState:方法
        -borderWidthForState:
        -borderColorForState:
        -shadowColorForState:
        -shadowOpacityForState:
        -shadowOffsetForState:
        -shadowSizeForState:

- UILabel+ZUX

        // 计算Label合适的尺寸.
        -sizeThatConstraintToSize:

- UIImage+ZUX

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

        // 读写应用程序目录中的文件.
        -writeToUserFile:
        +imageWithContentsOfUserFile:
        -writeToUserFile:inDirectory:
        +imageWithContentsOfUserFile:inDirectory:

- UITextField+ZUX

        // 限制输入文本内容及长度.
        -shouldChangeCharactersInRange:replacementString:limitWithLength:

- UITextView+ZUX

        // 限制输入文本内容及长度.
        -shouldChangeCharactersInRange:replacementString:limitWithLength:

- UITabBarItem+ZUX

        // 实例化方法(适配IOS7以下的系统)
        +tabBarItemWithTitle:image:selectedImage:

- UIColor+ZUX

        // 根据255格式颜色生成UIColor.
        +colorWithIntegerRed:green:blue:
        +colorWithIntegerRed:green:blue:alpha:

        // 根据十六进制字符串格式颜色生成UIColor.
        +colorWithRGBHexString:
        +colorWithRGBAHexString:

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

#####Utils

- ZUXCategory

    添加Category工具宏, 用于在需要使用Category方法时, 动态加载Category文件.

        ZUX_ENABLE_CATEGORY(ZUX_XXX)

- ZUXSingleton

    添加单例工具宏.

        // 添加于.h文件, @interface中
        ZUX_SINGLETON_H

        // 添加于.m文件, @implementation中
        ZUX_SINGLETOM_M

- ZUXGeometry

    添加二维坐标工具方法.

        CGRect ZUX_CGRectMake(CGPoint, CGSize);

- ZUXRuntime

    添加运行时工具方法.

        // 运行时获取类属性的声明类型名称(类名/结构体名/基本类型名), 没有该名称属性/属性声明为id类型时, 返回nil.
        NSString * ZUX_GetPropertyClassName(Class, NSString*);

- ZUXJson

    添加JSON工具方法.

        // 当IOS版本在5.0之前时, 默认使用JSONKit, 否则默认使用NSJSONSerialization.
        // 预定义ZUX_USE_JSONKIT后, 使用JSONKit.
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
        +createDirectory:
        +deleteAllFiles

        // 指定使用其他目录, 如Library/Caches或tmp目录.
        // 使用枚举ZUXDirectoryType指定目录类型.
        +fullFilePath:inDirectory:
        +fileExists:inDirectory:
        +createDirectory:inDirectory:
        +deleteAllFilesInDirectory:

        // 应用根目录.
        // 使用枚举ZUXDirectoryType指定目录类型.
        +documentDirectoryRoot
        +cachesDirectoryRoot
        +temporaryDirectoryRoot
        +directoryRoot:

- ZUXBundle

    资源bundle工具.

        // 读入bundle中的图片对象.
        +imageWithName:bundle:
        +imageForCurrentDeviceWithName:bundle:

        // 获取bundle中plist文件的完整路径.
        +plistPathWithName:bundle:

        // 获取bundle中音频文件URL.
        // 用于AudioServicesCreateSystemSoundID(CFURLRef, SystemSoundID*)
        +audioURLWithName:type:bundle:
