Pod::Spec.new do |spec|

  spec.name         = "DrawTransition"
  spec.version      = "0.0.1"
  spec.summary      = "Draw Transition"
  spec.homepage     = "https://github.com/Arestronaut/Draw-Transition"
  spec.license      = "MIT"
  spec.author             = { "Raoul Schwagmeier" => "r.schwagmeier@gmail.com" }
  spec.platform      = :ios, "14.0"
  spec.swift_version = "5.0"
  spec.source       = { :git => "https://github.com/Arestronaut/Draw-Transition.git", :tag => "#{spec.version}" }
  spec.source_files  = "DrawTransition/**/*.{h,m,swift}"
  
end
