# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'FurnitureAR' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FurnitureAR
  pod 'TPKeyboardAvoiding'
      pod 'ObjectMapper'
      pod 'RealmSwift', '~> 10.15.0'
      pod 'SwiftyGif'

  target 'FurnitureARTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FurnitureARUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
