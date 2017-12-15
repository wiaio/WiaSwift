Pod::Spec.new do |s|
  s.name             = "WiaSwift"
  s.version          = "0.1.5"
  s.summary          = "Offical Wia Swift SDK to access Wia's APIs."

  s.description      = <<-DESC
                       Offical Wia Swift SDK to access Wia's APIs.
                       DESC

  s.homepage         = 'https://github.com/wiaio/WiaSwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Conall Laverty' => 'conall@wia.io' }
  s.source           = { :git => 'https://github.com/wiaio/WiaSwift', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/wiaio'

  s.requires_arc = true

  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target    = '9.0'

  s.source_files     = 'Sources/WiaSwift/**/*.swift'
  s.module_name      = 'WiaSwift'

  s.dependency 'Alamofire', '~> 4.5.0'
  s.dependency 'AlamofireObjectMapper', '~> 5.0'

end
