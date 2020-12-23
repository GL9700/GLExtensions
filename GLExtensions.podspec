#
# Be sure to run `pod lib lint GLExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GLExtensions'
  s.version          = '1.0.8'
  s.summary          = 'the GLExtensions.'
  s.description      = <<-DESC
    GLExtensions For App quick Method, and Extensions
                       DESC
  s.homepage         = 'https://github.com/GL9700/GLExtensions'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liguoliang' => '36617161@qq.com' }
  s.source           = { :git => 'https://github.com/GL9700/GLExtensions.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'GLExtensions/Classes/**/*'
end
