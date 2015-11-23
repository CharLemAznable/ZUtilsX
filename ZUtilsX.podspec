Pod::Spec.new do |s|
  s.name          = "ZUtilsX"
  s.version       = "0.0.1"
  s.summary       = "Utils Code."
  s.description   = <<-DESC
                    收集日常开发中积累的工具代码.
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
