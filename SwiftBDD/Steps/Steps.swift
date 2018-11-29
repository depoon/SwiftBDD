//
//  Steps.swift
//  SwiftBDD
//
//  Created by Kenneth Poon on 25/11/18.
//

import Foundation

protocol Steps {
    
    func setupSteps()
}

extension Steps {
    func direction(text: String) -> XCUIElementDirection? {
        guard let direction = XCUIElementDirection(rawValue: text.lowercased()) else {
            return nil
        }
        return direction
    }
}
