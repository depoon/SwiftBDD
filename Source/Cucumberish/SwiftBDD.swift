//
//  SwiftBDD.swift
//  SwiftBDD
//
//  Created by Kenneth Poon on 25/11/18.
//

import XCTest
import Foundation
import Cucumberish

class SwiftBDD: NSObject {
    
    @objc static let shared = SwiftBDD()
    
    var steps: [Steps] = []
    var launchArguments: [String] = []
    var launchEnvironment: [String: String] = [:]
    var appBundleIdentifier: String? = nil
    
    var currentPage: Page? = nil
    
    public func setup(steps: [Steps],
                         launchArguments: [String] = [],
                         launchEnvironment: [String: String] = [:],
                         appBundleIdentifier: String? = nil,
                         featuresInfo: SwiftBDDFeaturesExecutionInfo) {
        self.steps = steps
        self.launchArguments = launchArguments
        self.launchEnvironment = launchEnvironment
        self.appBundleIdentifier = appBundleIdentifier
        
        for s in steps {
            s.setupSteps()
        }
        
        before({ _ in
            
        })
        
        Cucumberish.executeFeatures(inDirectory: featuresInfo.folderName,
                                    from: featuresInfo.bundle,
                                    includeTags: featuresInfo.includeTags,
                                    excludeTags: featuresInfo.excludeTags)
        
        after({ _ in
            XCUIApplication().terminate()
        })
    }
    
    public var defaultSteps: [Steps] {
        let s: [Steps] = [
            ApplicationSteps(),
            AssertionSteps(),
            UserInteractionSteps()
        ]
        return s
    }
    /*
    @objc class func setupCucumberish() {
        before({ _ in
            WebServer.shared.setup()
            let app = XCUIApplication()
            app.launchArguments.append("-UITESTING")
            app.launchEnvironment["INFINITY_BASEURL"] = "http://localhost:\(WebServer.shared.port)"
            
        })
        PageSteps().setupSteps()
        ServerSteps().setupSteps()
        AssertionSteps().setupSteps()
        UserInteractionSteps().setupSteps()
        LoginSteps().setupSteps()
        NavigationSteps().setupSteps()
        OemSteps().setupSteps()
        ProfilePaymentMethodSteps().setupSteps()
        BillsHistorySteps().setupSteps()
        BillPaymentInputSteps().setupSteps()
        BillPaymentPaySteps().setupSteps()
        EvaChargingPointsSteps().setupSteps()
        
        let bundle = Bundle(for: CucumberishInitializer.self)
        Cucumberish.executeFeatures(inDirectory: "Features",
                                    from: bundle, includeTags: self.getTags(),
                                    excludeTags: self.getExclusionTags())
        
        after({ _ in
            WebServer.shared.tearDown()
            XCUIApplication().terminate()
        })
    }
    
    fileprivate class func getTags() -> [String]? {
        var itemsTags: [String]? = nil
        for i in ProcessInfo.processInfo.arguments {
            if i.hasPrefix("-Tags:") {
                let newItems = i.replacingOccurrences(of: "-Tags:", with: "")
                itemsTags = newItems.components(separatedBy: ",")
            }
        }
        return itemsTags
    }
    
    fileprivate class func getExclusionTags() -> [String]? {
        var itemsTags: [String]? = nil
        for i in ProcessInfo.processInfo.arguments {
            if i.hasPrefix("-ExclusionTags:") {
                let newItems = i.replacingOccurrences(of: "-ExclusionTags:", with: "")
                itemsTags = newItems.components(separatedBy: ",")
            }
        }
        return itemsTags
    }
 */
}

public struct SwiftBDDFeaturesExecutionInfo {
    public let folderName: String
    public let bundle: Bundle
    public let includeTags: [String]?
    public let excludeTags: [String]?
    
    public init(folderName: String,
         bundle: Bundle,
         includeTags: [String]? = nil,
         excludeTags: [String]? = nil) {
        self.folderName = folderName
        self.bundle = bundle
        self.includeTags = includeTags
        self.excludeTags = excludeTags
    }
}

func AndWhen(_ definitionString: String, body: @escaping CCIStepBody) {
    When(definitionString, body)
    And(definitionString, body)
}

func AndThen(_ definitionString: String, body: @escaping CCIStepBody) {
    Then(definitionString, body)
    And(definitionString, body)
}

func AndGiven(_ definitionString: String, body: @escaping CCIStepBody) {
    Given(definitionString, body)
    And(definitionString, body)
}
