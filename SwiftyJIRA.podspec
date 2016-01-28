Pod::Spec.new do |s|
  s.name         = "SwiftyJIRA"
  s.version      = "0.1.0"
  s.summary      = "SwiftyJIRA is a JIRA SDK for iOS and OS X"
  s.homepage     = "https://github.com/hathway/SwiftyJIRA"
  s.license      = "MIT"
  s.author       = { "Eneko Alonso" => "eneko.alonso@gmail.com" }
  s.source       = { :git => "https://github.com/hathway/SwiftyJIRA.git", :tag => s.version }
  s.source_files  = "Sources/**/*.swift"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = "9.0"

  s.dependency "SwiftyJSON"
  s.dependency "JSONRequest"
end
