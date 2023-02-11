#
# Be sure to run `pod lib lint SBExpandableLabel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SBExpandableLabel'
  s.version          = '0.1.0'
  s.summary          = 'SBExpandableLabel is a UILabel subclass that adds "read more" capability.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'simply make your label of type SBExpandableLabel to enable the "read more" capability.'

  s.homepage         = 'https://github.com/sanadbarjawi/SBExpandableLabel'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sanadbarjawi' => 'sanadbarj@gmail.com' }
  s.source           = { :git => 'https://github.com/sanadbarjawi/SBExpandableLabel.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_versions = "5"
  s.ios.deployment_target = '14'

  s.source_files = 'SBExpandableLabel/SBExpandableLabel/Source/**/*.swift'
  
  # s.resource_bundles = {
  #   'SBExpandableLabel' => ['SBExpandableLabel/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
