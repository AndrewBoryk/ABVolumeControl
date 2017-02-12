#
# Be sure to run `pod lib lint ABVolumeControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ABVolumeControl'
  s.version          = '0.1.0'
  s.summary          = 'A custom volume control that replaces MPVolumeView, with multiple styles available, and a delegate to implement one's own custom volume view'


  s.description      = <<-DESC
ABVolumeControl is a MPVolumeView replacement which offers multiple styles, customizable appearance, and makes for easy implementation of one's own custom volume view with delegate methods.
                       DESC

  s.homepage         = 'https://github.com/andrewboryk/ABVolumeControl'
  s.screenshots      = 'https://raw.githubusercontent.com/AndrewBoryk/ABVolumeControl/master/ABVolumeControlScreenshot.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'andrewboryk' => 'andrewcboryk@gmail.com' }
  s.source           = { :git => 'https://github.com/andrewboryk/ABVolumeControl.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/trepislife'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ABVolumeControl/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ABVolumeControl' => ['ABVolumeControl/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
