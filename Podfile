
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end

target 'CEDigital' do
  
  pod 'FirebaseFirestoreSwift'
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'

  
  pod 'ActiveLabel'
  pod 'SwiftyRSA'
  
  pod 'lottie-ios'
  
  pod 'MaterialComponents/TextControls+FilledTextFields', '~> 116.0.1'
  pod 'MaterialComponents/TextControls+FilledTextFieldsTheming', '~> 116.0.1'
  
end
