# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
inhibit_all_warnings!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

target 'intimatica' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for intimatica
  pod 'XCoordinator', '2.0.7'
  
  # Network
  pod "Apollo", '0.45.0'
  
  # Persistance
  pod 'KeychainSwift', '19.0.0'
  
  # Utils
  pod 'SwiftLint', '0.43.1'
  pod 'Firebase/Crashlytics', '8.7.0'
  pod 'Firebase/Analytics', '8.7.0'
  pod 'Firebase/RemoteConfig', '8.7.0'
  
  # UI helpers
  pod 'Kingfisher', '6.3.0'
  pod 'MarkdownView', '1.7.1'
  #pod "PlayerKit"
  pod "youtube-ios-player-helper", "1.0.3"
  pod 'YouTubePlayer', '0.7.2'
  
  pod "AlignedCollectionViewFlowLayout", '1.1.2'
  pod 'SnapKit', '5.0.1'
  pod 'IQKeyboardManagerSwift', '6.5.6'
  pod 'SideMenu', '6.5.0'
  pod 'LocalizedTimeAgo', '1.3.0'

  pod 'Amplitude', '8.7.1'
  pod 'FBSDKCoreKit', '12.2.1'
end
