Pod::Spec.new do |s|
  s.name         = 'MOLXPCConnection'
  s.version      = '1.1'
  s.platform     = :osx
  s.license      = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.homepage     = 'https://github.com/google/macops-molxpcconnection'
  s.authors      = { 'Google Macops' => 'macops-external@google.com' }
  s.summary      = 'A macOS XPC connection class'
  s.source       = { :git => 'https://github.com/google/macops-molxpcconnection.git',
                     :tag => "v#{s.version}" }
  s.source_files = 'Source/MOLXPCConnection/*.{h,m}'
  s.dependency 'MOLCodesignChecker'
end
