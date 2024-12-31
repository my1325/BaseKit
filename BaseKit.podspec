Pod::Spec.new do |s|

 s.name             = "BaseKit"
 s.version           = "0.0.1"
 s.summary         = "BaseKit for my's ioser"
 s.homepage        = "https://github.com/my1325/BaseKit.git"
 s.license            = "MIT"
 s.platform          = :ios, "13.0"
 s.authors           = { "mayong" => "1173962595@qq.com" }
 s.source             = { :git => "https://github.com/my1325/BaseKit.git", :tag => "#{s.version}" }
 s.swift_version = '5.1'
 s.source_files = 'Sources/**/*.swift'
end
