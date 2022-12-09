![logo](https://github.com/GL9700/gl9700.github.io/blob/master/GLSLogo_800.png?raw=true)
# GLExtensions

[![CI Status](https://img.shields.io/travis/36617161@qq.com/GLExtensions.svg?style=flat)](https://travis-ci.org/36617161@qq.com/GLExtensions)
[![Version](https://img.shields.io/cocoapods/v/GLExtensions.svg?style=flat)](https://cocoapods.org/pods/GLExtensions)
[![License](https://img.shields.io/cocoapods/l/GLExtensions.svg?style=flat)](https://cocoapods.org/pods/GLExtensions)
[![Platform](https://img.shields.io/cocoapods/p/GLExtensions.svg?style=flat)](https://cocoapods.org/pods/GLExtensions)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

GLExtensions is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GLExtensions'
```
## History

* 1.1.4 -- 2022.12.09
    * 简化toast的自定义化，可使用限定dict进行更灵活的自定义
* 1.1.2 -- 2022.04.30
    * 修复toast队列添加数量到最大值导致的崩溃
    * 修复toast队列位置的问题
* 1.1.1 -- 2022.04.07
    * 优化toast的设计
* 1.0.12 -- 2021.06.09
    * 增加了针对NSString的 `正则查找` 和 `正则替换` 的快捷方法
* 1.0.11 -- 2021.01.26
    * 修改 Toast 显示到最上层 （如需显示于原页面，可使用异步出现新页面的方案）
* 1.0.10 -- 2021.01.20
    * 修改控制入口和返回，使之更加合理化
* 1.0.9 -- 2020.12.28
    * 导入文件名称，采用尖括号方式，修改未规范内容
* 1.0.8 -- 2020.12.23
    * `UIViewController+GLExtensions`: 对于名称修改（原方法进行`Deprecated`标记） 
    * 增加了 `CALayer+GLExtensions`, 并在`import UIView+GLExtensions`时会一并导入
* 1.0.7 -- 2020.12.15
    * `NSString+GLExtensions`: 增加了字符验证相关内容，并进行了原方法的 deprecate 标记
## Author

liguoliang 36617161@qq.com

## License

GLExtensions is available under the MIT license. See the LICENSE file for more info.
