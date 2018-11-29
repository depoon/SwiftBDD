//
//  ApplicationSteps.swift
//  SwiftBDD
//
//  Created by Kenneth Poon on 26/11/18.
//

import Foundation
import Cucumberish

class ApplicationSteps: Steps {
    
    func setupSteps() {
        
        Given("App is ready") { (args, userInfo) -> Void in
            let app = XCUIApplication()
            app.launchArguments = SwiftBDD.shared.launchArguments
            app.launchEnvironment = SwiftBDD.shared.launchEnvironment
            app.launch()
        }
        
        Given("I send App to background and resume") { (args, userInfo) -> Void in
            guard let bundleIdentifier = SwiftBDD.shared.appBundleIdentifier else {
                XCTFail("Application Bundle Identifier not set. Use \'SwiftBDD.shared.setup()\'")
                return
            }
            XCUIDevice.shared.press(.home)
            Thread.sleep(forTimeInterval: 1)
            let application = XCUIApplication(bundleIdentifier: bundleIdentifier)
            application.activate()
        }
    }
}
