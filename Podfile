# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'

target 'TheForkTest' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TheForkTest

  pod 'SwiftyJSON'
  pod 'SnapKit', '~> 3.0'

  target 'TheForkTestTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TheForkTestUITests' do
    inherit! :search_paths
    # Pods for testing
  end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['SWIFT_VERSION'] = '3.0'
end
end
end

end
