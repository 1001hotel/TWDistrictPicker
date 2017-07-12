#
#  Be sure to run `pod spec lint TWCameraPicker.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
s.name         = "TWDistrictPicker"

  s.version      = "1.0.1"

  s.summary      = "A district picker used on iOS."

  s.description  = <<-DESC
                   It is a district picker used on iOS, which implement by Objective-C.
                   DESC

  s.homepage     = "https://github.com/1001hotel/TWDistrictPicker"

  s.license      = "MIT"

  s.author             = { "xurenyan" => "812610313@qq.com" }

  s.platform     = :ios, "8.0"

  s.requires_arc = true

  s.source       = { :git => "https://github.com/1001hotel/TWDistrictPicker.git", :tag => s.version.to_s }

  s.source_files  = "TWDistrictPicker/*.{h,m}"
  s.resources = "TWDistrictPicker/*.plist", "TWDistrictPicker/*.xib"

  s.frameworks = "Foundation", "UIKit" 

 #s.libraries = "z", "c++"

end
