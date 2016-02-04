Pod::Spec.new do |s|
  s.name                = "ZUtilsX"
  s.version             = "0.1.6"
  s.summary             = "Personal IOS Utils Code."
  s.description         = <<-DESC
                          工具代码集. 包含宏定义, 工具类, 向Foundation/UIKit添加的分类, 自定义工具视图, JSON工具类, MBProgressHUD工具类, Keychain工具类.
                          DESC
  s.homepage            = "https://github.com/CharLemAznable/ZUtilsX"
  s.license             = "MIT"
  s.author              = "CharLemAznable"
  s.platform            = :ios, '5.0'
  s.requires_arc        = false
  s.source              = { :http => "https://raw.githubusercontent.com/CharLemAznable/ZUtilsX/master/Products/ZUtilsX.zip" }
  s.frameworks          = 'Foundation', 'CoreGraphics', 'UIKit', 'Security'
  s.vendored_frameworks = [ "ZUtilsX.framework" ]
  s.xcconfig            = { :LIBRARY_SEARCH_PATHS => "$(PODS_ROOT)/ZUtilsX" }
end
