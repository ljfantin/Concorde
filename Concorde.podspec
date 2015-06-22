Pod::Spec.new do |s|
  s.name             = "Concorde"
  s.version          = "0.0.3"
  s.summary          = "Download and decode progressive JPEGs easily."
  s.homepage         = "https://github.com/contentful-labs/Concorde/"
  s.social_media_url = 'https://twitter.com/contentful'

  s.license = {
    :type => 'MIT',
    :file => 'LICENSE'
  }

  s.authors      = { "Boris Bügling" => "boris@buegling.com" }
  s.source       = { :git => "https://github.com/contentful-labs/Concorde.git",
                     :tag => s.version.to_s }
  s.requires_arc = true

  s.default_subspecs = 'Core'

  s.ios.deployment_target     = '8.0'
  s.ios.frameworks            = 'UIKit'
  s.osx.deployment_target     = '10.9'

  s.subspec 'Core' do |core_spec|
    core_spec.source_files         = 'Code/*.{h,m}', 'vendor/libjpeg-turbo/include/*'
    core_spec.public_header_files  = 'Code/CCBufferedImageDecoder.h'
    core_spec.vendored_libraries   = 'vendor/libjpeg-turbo/lib/libturbojpeg.a'

    core_spec.ios.source_files     = 'Code/CCBufferedImageView.swift'
  end

  s.subspec 'CoreObjectiveC' do |core_spec|
    core_spec.source_files         = 'Code/*.{h,m}', 'vendor/libjpeg-turbo/include/*'
    core_spec.public_header_files  = 'Code/CCBufferedImageDecoder.h'
    core_spec.vendored_libraries   = 'vendor/libjpeg-turbo/lib/libturbojpeg.a'

    core_spec.ios.source_files     = 'Code/CCBufferedImageView.{h,m}'
  end

  s.subspec 'Contentful' do |contentful_spec|
    contentful_spec.ios.source_files = 'Code/CCBufferedImageView+Contentful.swift'

    contentful_spec.dependency 'Concorde/Core'
    contentful_spec.dependency 'ContentfulDeliveryAPI', '>= 1.6.0'
  end
end
