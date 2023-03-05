//
//  String+Extension.swift
//  Counters
//  OG: https://github.com/vincent-pradeilles/swift-tips#shorter-syntax-to-deal-with-optional-strings
//  Created by Thalles Araújo on 05/03/23.
//

import Foundation
import UIKit

extension Optional where Wrapped == String {
    var orEmpty: String {
        switch self {
        case .some(let value):
            return value
        case .none:
            return String()
        }
    }
}
