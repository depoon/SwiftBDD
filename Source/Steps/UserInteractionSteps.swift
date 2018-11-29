//
//  UserInteractionSteps.swift
//  SwiftBDD
//
//  Created by Kenneth Poon on 26/11/18.
//

import Foundation
import Cucumberish

class UserInteractionSteps: Steps {
    
    open func setupSteps() {
        
        When("I tap on \"([^\\\"]*)\"") { (args, userInfo) -> Void in
            let describable: String = args![0]
            guard let tappablePage = SwiftBDD.shared.currentPage as? TappablePage else {
                XCTFail("Current Page is not Tappable")
                return
            }
            guard let tappableElement = tappablePage.tappableElement(describable: describable) else {
                XCTFail("Current Page does not have a tappable element")
                return
            }
            tappableElement.verticallySwipeUntilHittable()
            tappableElement.tap()
        }
        
        When("I swipe (up|down|left|right) on \"([^\\\"]*)\"") { (args, userInfo) -> Void in
            let describable: String = args![1]
            guard let direction = self.direction(text: args![0]) else {
                XCTFail("Invalid swipe direction")
                return
            }
            guard let swippablePage = SwiftBDD.shared.currentPage as? SwippablePage else {
                XCTFail("Current Page is not Swippable")
                return
            }
            guard let swippableElement = swippablePage.swippableElement(describable: describable) else {
                XCTFail("Current Page does not have a swippable element")
                return
            }
            swippableElement.verticallySwipeUntilHittable()
            swippableElement.swipeDirection(direction: direction)
        }
        
        When("I enter \"([^\\\"]*)\" as \"([^\\\"]*)\"") { (args, userInfo) -> Void in
            let text: String = args![0]
            let describable: String = args![1]
            guard let textEnterablePage = SwiftBDD.shared.currentPage as? TextEnterablePage else {
                XCTFail("Current Page is not Text Enterable")
                return
            }
            guard let textEnterableElement = textEnterablePage.textEnterableElement(describable: describable) else {
                XCTFail("Current Page does not have a tappable element")
                return
            }
            textEnterableElement.verticallySwipeUntilHittable()
            textEnterablePage.enter(text: text, intoField: textEnterableElement)
        }
    }
}

