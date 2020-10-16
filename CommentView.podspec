#
# Be sure to run `pod lib lint CommentView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CommentView'
  s.version          = '0.0.1'
  s.summary          = 'CommentView is design library pod'
  s.description      = "CommentView is a simple view, which the user can comment on inside view. It also set a limit entirety of characters, which was typed by users"
  s.homepage         = 'https://github.com/nguyenhoangit57'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hoang Nguyen' => 'hoangnguyen4005@gmail.com' }
  s.source           = { :git => 'https://github.com/nguyenhoangit57/CommentView', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.source_files = 'CommentView/Classes/**/*'
end
