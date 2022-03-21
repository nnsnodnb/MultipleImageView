Pod::Spec.new do |spec|
  spec.name                  = "MultipleImageView"
  spec.version               = "0.1.3"
  spec.summary               = "Displaying multiple images like Twitter."
  spec.homepage              = "https://github.com/nnsnodnb/MultipleImageView"
  spec.swift_version         = "5.2"
  spec.license               = { :type => "MIT", :file => "LICENSE" }
  spec.author                = { "nnsnodnb" => "nnsnodnb@gmail.com" }
  spec.social_media_url      = "https://twitter.com/nnsnodnb"
  spec.platform              = :ios
  spec.platform              = :ios, "9.0"
  spec.ios.deployment_target = "9.0"
  spec.ios.framework         = "UIKit"
  spec.source                = { :git => "https://github.com/nnsnodnb/#{spec.name}.git", :tag => "#{spec.version}" }
  spec.source_files          = "#{spec.name}", "#{spec.name}/*.{h,swift}"
  spec.public_header_files   = "#{spec.name}/#{spec.name}.h"
  spec.user_target_xcconfig  = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.pod_target_xcconfig   = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
