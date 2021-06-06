#
# Be sure to run `pod lib lint FriendList.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FriendList'
  s.version          = '0.1.0'
  s.summary          = 'A short description of FriendList.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Huy Nguyen/FriendList'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Huy Nguyen' => 'huy.n.pyco@aux.go-jek.com' }
  s.source           = { :git => 'https://github.com/Huy Nguyen/FriendList.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.4'

  s.source_files = 'FriendList/Module/**/*.{swift}'

  s.resources = 'FriendList/Module/**/*.{xcassets,json,storyboard,xib,xcdatamodeld}'
  
  s.dependency 'Networking'
  
  # s.resource_bundles = {
  #   'FriendList' => ['FriendList/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
end
