// Copyright 2018 Oliver Borchert
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit
import RxGesture
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    
    public func forceTouchOrLongPressGesture(withHapticFeedback haptic: Bool = true) -> Observable<ForceTouch> {
        let forceTouch = gesture(ForceTouchGestureRecognizer())
            .filter { _ in self.base.traitCollection.forceTouchCapability == .available }
            .when(.changed, .ended, .cancelled)
            .map { $0.force }
        let longPress = longPressGesture(minimumPressDuration: 0.75)
            .filter { _ in self.base.traitCollection.forceTouchCapability != .available }
            .when(.began).map { _ in ForceTouch.completed }
        return forceTouch.amb(longPress)
            .do(onNext: { force in
                if case .completed = force, haptic {
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
                }
            })
    }
    
    public func touchDownGesture() -> ControlEvent<TouchDownGestureRecognizer> {
        return gesture(TouchDownGestureRecognizer())
    }
}
