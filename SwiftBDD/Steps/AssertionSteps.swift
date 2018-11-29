//
//  AssertionSteps.swift
//  SwiftBDD
//
//  Created by Kenneth Poon on 29/11/18.
//

import Foundation
import Cucumberish

class AssertionSteps: Steps {
    
    func setupSteps() {
        
        Then("I should see \"([^\\\"]*)\"") { (args, userInfo) -> Void in
            let describable: String = args![0]
            guard let currentPage = SwiftBDD.shared.currentPage else {
                XCTFail("Current Page Not Set")
                return
            }
            currentPage.waitToSee(describable: describable)
        }
    }
}
