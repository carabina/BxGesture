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

import UIKit.UIGestureRecognizerSubclass

open class ForceTouchGestureRecognizer: UIGestureRecognizer {
    
    private static let threshold: CGFloat = 0.2
    
    public private(set) var force: ForceTouch = .cancelled
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        
        self.state = .possible
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        guard let touch = touches.first else { return }
        
        if touch.normalizedForce > ForceTouch.minThreshold {
            if self.state == .possible {
                self.state = .began
            }
            if touch.normalizedForce < ForceTouch.maxThreshold {
                self.state = .changed
            } else {
                self.state = .ended
            }
        } else {
            if case .cancelled = self.force { } else {
                self.state = .cancelled
            }
        }
        self.force = ForceTouch(touch.normalizedForce)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        
        self.force = .cancelled
        self.state = .cancelled
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        
        self.force = .cancelled
        self.state = .cancelled
    }
    
    open override func reset() {
        super.reset()
        
        self.force = .cancelled
        cancelsTouchesInView = false
    }
}

extension UITouch {
    
    internal var normalizedForce: CGFloat {
        return force / maximumPossibleForce
    }
}

