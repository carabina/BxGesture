Pod::Spec.new do |s|

    s.name             = 'BxGesture'
    s.version = '1.0.0'
    s.summary          = 'An Extension for Missing Gesture Recognizers on iOS in Swift.'

    s.description      = 'BxGesture is based on the reactive RxGesture and provides'\
                         ' two gesture recognizers missing in UIKit: a touch down'\
                         ' recognizer as well as a force touch recognizer.'

    s.homepage         = 'https://github.com/borchero/BxGesture'
    s.license          = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
    s.author           = { 'Oliver Borchert' => 'borchero@icloud.com' }
    s.source           = { :git => 'https://github.com/borchero/BxGesture.git', :tag => s.version.to_s }

    s.platform = :ios
    s.ios.deployment_target = '11.0'

    s.source_files = 'BxGesture/**/*'

    s.dependency 'RxSwift', '~> 4.0'
    s.dependency 'RxCocoa', '~> 4.0'
    s.dependency 'RxGesture', '~> 1.2'

    s.framework = 'UIKit'

end
