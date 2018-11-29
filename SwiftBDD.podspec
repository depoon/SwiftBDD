
Pod::Spec.new do |s|
  s.name             = "SwiftBDD"
  s.version          = "0.0.1"
  s.summary          = "Write Cucumber and BDD Tests with your iOS Project"
  s.description      = <<-DESC
Features
1. Write Cucumber BDD Tests
DESC
  s.homepage         = "https://github.com/depoon/SwiftBDD"
  s.license          = 'MIT'
  s.author           = { "depoon" => "de_poon@hotmail.com" }
  s.source           = { :git => "https://github.com/depoon/NetworkInterceptor.git", :tag => s.version.to_s }

  s.platform     = :ios, '10.0'
  s.requires_arc = true

  s.source_files = 'NetworkInterceptor/Source/**/*'
  s.dependency 'Criollo', '~> 0.4'
  s.dependency 'Cucumberish'
end
