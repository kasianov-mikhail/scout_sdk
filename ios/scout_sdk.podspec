Pod::Spec.new do |s|
  s.name             = 'scout_sdk'
  s.version          = '0.1.0'
  s.summary          = 'Flutter wrapper for Scout analytics framework'
  s.description      = <<-DESC
Flutter plugin providing a Dart API for the Scout iOS analytics framework.
Scout offers logging, metrics, crash reporting, and session tracking backed by CloudKit.
                       DESC
  s.homepage         = 'https://github.com/kasianov-mikhail/scout_sdk'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mikhail Kasianov' => '' }
  s.source           = { :path => '.' }
  s.source_files     = 'scout_sdk/Sources/scout_sdk/**/*'
  s.dependency 'Flutter'
  s.platform         = :ios, '16.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version    = '5.9'
end
