//
//  XCUIElement+Extensions.swift
//  SwiftBDD
//
//  Created by Kenneth Poon on 25/11/18.
//

import Foundation
import XCTest

enum XCUIElementDirection: String {
    case up, down, left, right
}

enum SwiftBDDError: Error {
    case directionUndetermined
}

extension XCUIElement {
    
    func swipeDirection(direction: XCUIElementDirection) {
        switch direction {
        case .up:
            self.swipeUp()
        case .down:
            self.swipeDown()
        case .left:
            self.swipeLeft()
        case .right:
            self.swipeRight()
        }
    }
    
    func verticallySwipeUntilHittable() {
        guard !self.isHittable else {
            return
        }
        guard self.identifier != "" else {
            XCTFail("Vertical swipe searchable element should have an identifier")
            return
        }
        guard let swippableSuperView = self.swippableSuperviewElement(of: self) else {
            XCTFail("Scrollable superview of field '\(self.identifier)' not found")
            return
        }
        guard let direction = try? self.determineVerticalSwippableDirectionToFindElement() else {
            XCTFail("Unable to determine vertical swipe direction")
            return
        }
        swippableSuperView.swipeDirection(direction: direction)
        while !self.isHittable ||
            self.isElementVerticallyOutOfBounds(swippableDirection: direction) {
                swippableSuperView.swipeDirection(direction: direction)
        }
    }
    
    func swippableSuperviewElement(of field: XCUIElement) -> XCUIElement? {
        let superViewQuery = XCUIApplication().descendants(matching: .any).containing(field.elementType, identifier: field.identifier)
        return superViewQuery.allElementsBoundByIndex.first
    }
    
    func determineVerticalSwippableDirectionToFindElement() throws -> XCUIElementDirection {
        let frame = self.frame
        if frame.origin.y <= 0 {
            return .down
        }
        if frame.origin.y >= XCUIApplication().windows.element(boundBy: 0).frame.size.height {
            return .up
        }

        throw SwiftBDDError.directionUndetermined
    }
    
    func isElementVerticallyOutOfBounds(swippableDirection: XCUIElementDirection) -> Bool {
        if swippableDirection == .up, self.frame.origin.y < 0 {
            return true
        }
        let window = XCUIApplication().windows.element(boundBy: 0)
        if swippableDirection == .down, self.frame.origin.y > window.frame.size.height {
            return true
        }
        return false
    }
}
