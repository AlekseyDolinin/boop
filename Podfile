# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'boop' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for boop
  
pod 'SwiftyJSON', '~> 4.0'
pod 'Alamofire', '~> 4.0'
pod 'Google-Mobile-Ads-SDK', '~> 7.64.0'
pod 'SwiftLinkPreview', '~> 3.4.0'
pod 'Kingfisher', '~> 4.0'
pod 'FaviconFinder'
pod 'SwiftLinkPreview', '~> 3.4.0'

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end