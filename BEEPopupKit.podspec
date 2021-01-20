Pod::Spec.new do |s|
  s.name             = 'BEEPopupKit'
  s.version          = '1.0.1'
  s.summary          = '一个可自定义的弹框组件'
  s.homepage         = 'https://github.com/liuxc123/BEEPopupKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/BEEPopupKit.git', :tag => s.version.to_s }
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  s.requires_arc = true

  s.source_files = 'BEEPopupKit/Classes/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'QuickLayout'
end
