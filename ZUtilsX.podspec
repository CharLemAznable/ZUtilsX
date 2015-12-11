Pod::Spec.new do |s|
  s.name          = "ZUtilsX"
  s.version       = "0.0.7"
  s.summary       = "Utils Code."
  s.description   = <<-DESC
                    工具代码集. 包含宏定义, 工具类, 向Foundation/UIKit添加的分类, 自定义工具视图, JSON工具类, MBProgressHUD工具类.
                    DESC
  s.homepage      = "https://github.com/CharLemAznable/ZUtilsX"
  s.license       = "MIT"
  s.author        = "CharLemAznable"
  s.platform      = :ios, '5.0'
  s.requires_arc  = false
  s.source        = { :git => "https://github.com/CharLemAznable/ZUtilsX.git", :tag => s.version.to_s }
  s.source_files  = "ZUtilsX/**/*.{h,m}"
  s.exclude_files = "ZUtilsX/Privates/**/*.{h,m}"
  s.frameworks    = 'Foundation', 'CoreGraphics', 'UIKit'
end
