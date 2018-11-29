//
//  Page.swift
//  SwiftBDD
//
//  Created by Kenneth Poon on 25/11/18.
//

import Foundation
import XCTest

protocol Page {
    var pageIdentifiableElement: XCUIElement { get }
    var pageName: String { get }
    
}

protocol TappablePage {
    func tappableElement(describable: String) -> XCUIElement?
}

protocol SwippablePage {
    func swippableElement(describable: String) -> XCUIElement?
}

protocol TextEnterablePage {
    func textEnterableElement(describable: String) -> XCUIElement?
}

extension Page {
    func waitToSee(describable: String, timeout: TimeInterval = 5) {
        let predicate = NSPredicate(format: "(label CONTAINS[c] %@) OR (title CONTAINS[c] %@)", describable, describable)
        let result = XCUIApplication().descendants(matching: .any).containing(predicate)
        let element = XCUIApplication().staticTexts[result.element.label]
        guard element.waitForExistence(timeout: timeout) else {
            XCTFail("Unable to find visible element with substring \"\(describable)\"")
            return
        }
    }
}

extension TextEnterablePage {
    func enter(text: String, intoField: XCUIElement) {
        let app = XCUIApplication()
        if !intoField.accessibilityElementIsFocused() {
            intoField.tap()
        }
        if app.buttons["Clear text"].exists {
            app.buttons["Clear text"].tap()
        } else if let fieldValue = intoField.value as? String {
            var deleteString: String = ""
            for _ in fieldValue {
                deleteString += "\u{8}"
            }
            intoField.typeText(deleteString)
        }
        intoField.typeText(text)
    }
}


