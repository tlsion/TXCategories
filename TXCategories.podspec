
Pod::Spec.new do |s|

s.name         = "TXCategories"
s.version      = “1.1.3”
s.summary      = "a collection of useful Objective-C Categories extending iOS Frameworks as Foundation and UIKit."
s.homepage     = "https://github.com/tlsion/TXCategories"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "Tlsion" => "249190182@qq.com" }
s.source       = { :git => "https://github.com/tlsion/TXCategories.git", :tag => s.version }
s.platform     = :ios, "7.0"
s.source_files = "TXCategories", "TXCategories/*.{h}","TXCategories/**/*.{h,m}"
s.frameworks = "UIKit", "Foundation"
s.requires_arc = true

end
