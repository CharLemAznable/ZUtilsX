Pod::Spec.new do |s|
  s.name                = "ZUtilsX"
  s.version             = "0.1.6"
  s.summary             = "Personal IOS Utils Code."
  s.description         = <<-DESC
                          工具代码集. 包含宏定义, 工具类, 向Foundation/UIKit添加的分类, 自定义工具视图, JSON工具类, MBProgressHUD工具类, Keychain工具类.
                          DESC
  s.homepage            = "https://github.com/CharLemAznable/ZUtilsX"
  s.license             = "MIT"
  s.license             = { :type => 'MIT',
                            :text => <<-LICENSE
                                      Copyright (c) 2015 CharLemAznable

                                      Permission is hereby granted, free of charge, to any person obtaining a copy
                                      of this software and associated documentation files (the "Software"), to deal
                                      in the Software without restriction, including without limitation the rights
                                      to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
                                      copies of the Software, and to permit persons to whom the Software is
                                      furnished to do so, subject to the following conditions:

                                      The above copyright notice and this permission notice shall be included in all
                                      copies or substantial portions of the Software.

                                      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
                                      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
                                      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
                                      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
                                      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
                                      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
                                      SOFTWARE.
                                     LICENSE
                          }
  s.author              = "CharLemAznable"
  s.platform            = :ios, '5.0'
  s.requires_arc        = false
  s.source              = { :http => "https://raw.githubusercontent.com/CharLemAznable/ZUtilsX/master/Products/ZUtilsX.zip" }
  s.frameworks          = 'Foundation', 'CoreGraphics', 'UIKit', 'Security'
  s.vendored_frameworks = 'ZUtilsX/ZUtilsX.framework'
  s.xcconfig            = { :LIBRARY_SEARCH_PATHS => "$(PODS_ROOT)/ZUtilsX" }
end
