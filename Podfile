source 'https://github.com/raphaeloc'

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def pods
 pod 'Alamofire'
  pod 'LoadingView/Binary', :git => 'https://github.com/raphaeloc/loadingView', :tag => '1.1'
end

target 'bankApp' do
  use_frameworks!
  pods
  
  target 'bankAppTests' do
    inherit! :search_paths
  end
end
