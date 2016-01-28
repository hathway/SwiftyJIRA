Pod::Spec.new do |s|
  s.name         = "SwiftyJIRA"
  s.version      = "0.0.1"
  s.summary      = "SwiftyJIRA is a JIRA SDK for iOS and OS X"
  s.homepage     = "https://github.com/hathway/SwiftyJIRA"
  s.license      = "MIT (example)"
  s.author       = { "Eneko Alonso" => "eneko.alonso@gmail.com" }
  s.source       = { :git => "https://github.com/hathway/SwiftyJIRA.git", :tag => s.version }
  s.source_files  = "Sources/**/*.swift"
  s.dependency "JSONRequest"
end
