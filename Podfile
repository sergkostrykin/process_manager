platform :osx, '10.11'
inhibit_all_warnings!
use_frameworks!

target 'Processes' do
   pod 'MBPopup'
   pod 'Sparkle'
   pod 'SwiftGen'
end

post_install do |installer|
	# Sign the Sparkle helper binaries to pass App Notarization.
	system("codesign --force -o runtime -s 'Developer ID Application: Tweakbit Pty Ltd' Pods/Sparkle/Sparkle.framework/Resources/Autoupdate.app/Contents/MacOS/Autoupdate")
	system("codesign --force -o runtime -s 'Developer ID Application: Tweakbit Pty Ltd' Pods/Sparkle/Sparkle.framework/Resources/Autoupdate.app/Contents/MacOS/fileop")
end