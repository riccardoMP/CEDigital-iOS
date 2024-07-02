
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'
use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end

target 'CEDigital' do
  
  pod 'Alamofire', '~> 5.5'
  pod 'FirebaseFirestoreSwift'
  pod 'ReachabilitySwift'
  pod 'IQKeyboardManagerSwift'
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
  pod 'GoogleIDFASupport'
  
  pod 'ActiveLabel'
  pod 'SwiftyRSA'
  
  pod 'lottie-ios'
  
  pod 'MaterialComponents/TextControls+FilledTextFields'
  pod 'MaterialComponents/TextControls+FilledTextFieldsTheming'
  
end
