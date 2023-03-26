require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

Pod::Spec.new do |s|
  s.name = "react-native-custom-keyboard"
  s.version = package["version"]
  s.summary = package["description"]
  s.homepage = package["homepage"]
  s.license = package["license"]
  s.authors = package["author"]

  s.platforms = { :ios => "14.0" }
  s.source = {
    :git => "https://github.com/trungnhm1998/react-native-custom-keyboard.git",
    :tag => "#{s.version}", :submodules => true
  }

  s.ios.deployment_target = '14.0'
  s.macos.deployment_target = '11.0'
  s.tvos.deployment_target = '14.0'

  s.source_files = "ios/CustomKeyboard/**/*.{h,m,mm,swift}", "ios/KeyboardKit/Sources/KeyboardKit/**/*.{swift}"
  s.preserve_path = "${POD_ROOT}/CustomKeyboard/CustomKeyboard-Bridging-Header.h"
  s.xcconfig = { 'SWIFT_OBJC_BRIDGING_HEADER' => '${POD_ROOT}//Users/trungnhm1998/Projects/apps/react-native-custom-keyboard/ios/CustomKeyboard/CustomKeyboard-Bridging-Header.h' }
  s.dependency "React-Core"

  # Don't install the dependencies when we run `pod install` in the old architecture.
  if ENV['RCT_NEW_ARCH_ENABLED'] == '1' then
    s.compiler_flags = folly_compiler_flags + " -DRCT_NEW_ARCH_ENABLED=1"
    s.pod_target_xcconfig    = {
        "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\"",
        "OTHER_CPLUSPLUSFLAGS" => "-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1",
        "CLANG_CXX_LANGUAGE_STANDARD" => "c++17"
    }
    s.dependency "React-Codegen"
    s.dependency "RCT-Folly"
    s.dependency "RCTRequired"
    s.dependency "RCTTypeSafety"
    s.dependency "ReactCommon/turbomodule/core"
  end
end
