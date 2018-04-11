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

import Foundation

public enum ForceTouch {
    
    case cancelled
    case strength(CGFloat)
    case completed
    
    internal init(_ normalizedStrength: CGFloat) {
        if normalizedStrength >= ForceTouch.maxThreshold {
            self = .completed
        } else if normalizedStrength <= ForceTouch.minThreshold {
            self = .cancelled
        } else {
            self = .strength((normalizedStrength - ForceTouch.minThreshold) *
                (1 / (ForceTouch.maxThreshold - ForceTouch.minThreshold)))
        }
    }
    
    internal static var minThreshold: CGFloat {
        return 0.2
    }
    
    internal static var maxThreshold: CGFloat {
        return 0.7
    }
}

