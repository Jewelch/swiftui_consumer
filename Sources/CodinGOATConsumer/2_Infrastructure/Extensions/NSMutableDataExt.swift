//
//  NSMutableDataExt.swift
//
//  Created by Jewel CHERIAA on 05/06/2023.
//

import Foundation

public extension NSMutableData {
    func appendDataFrom(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
