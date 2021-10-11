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
  pod 'XCoordinator', '~> 2.0'
  
  # Network
  pod "Apollo"
  
  # Persistance
  pod 'KeychainSwift', '~> 19.0'
  
  # Utils
  pod 'SwiftLint'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
  
  # UI helpers
  pod 'Kingfisher', '~> 6.0'
  pod 'MarkdownView'
  #pod "PlayerKit"
  pod "youtube-ios-player-helper", "~> 1.0.2"
  pod 'YouTubePlayer'
  
  pod "AlignedCollectionViewFlowLayout"
  pod 'SnapKit', '~> 5.0.0'
  pod 'IQKeyboardManagerSwift'
  pod 'SideMenu', '~> 6.0'
  pod 'LocalizedTimeAgo', '~> 1.3.0'
end
