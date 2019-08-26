# vi: ft=ruby

Pod::Spec.new do |s|
  s.name = "DependentMap"
  s.version = "1.0.0"
  s.summary = "DependentMap Microframework"

  s.description = <<-DESC
  Dependent map type for Swift, allowing keys to specify the type of value that can be associated with them.
  DESC

  s.homepage = "https://github.com/pwc3/DependentMap"

  s.author = "Paul Calnan"

  s.source = { :git => "https://github.com/pwc3/DependentMap.git", :tag => "#{s.version}" }
  s.license = { :type => "MIT" }

  s.platform = :ios, "11.0"
  s.swift_version = "5.0"

  s.source_files = "Sources/DependentMap/**/*.swift"

end

