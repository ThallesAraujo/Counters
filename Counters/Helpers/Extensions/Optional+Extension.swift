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


extension Optional where Wrapped == UIColor{
    
    var orDefault: UIColor{
        switch self{
        case .some(let value):
            return value
        case .none:
            return .systemBlue
        }
        
    }
    
}

extension Optional where Wrapped == UIImage{
    
    var orEmpty: UIImage{
        switch self {
        case .none:
            return UIImage()
        case .some(let wrapped):
            return wrapped
        }
    }
    
}

extension Optional where Wrapped == Int{
    var orZero: Int{
        switch self {
        case .none:
            return 0
        case .some(let wrapped):
            return wrapped
        }
    }
}
