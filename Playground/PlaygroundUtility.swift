//
//  PlaygroundUtility.swift
//  CombinePratice
//
//  Created by N. M on 2023/06/14.
//

import Foundation

public func example(_ description: String, action: () -> Void) {
   printExampleHeader(description)
   action()
}

public func printExampleHeader(_ description: String) {
    print("\n--- \(description) ---")
}

public enum MyError: Error {
    case failed
}
