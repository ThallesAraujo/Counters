//
//  Double+Extension.swift
//  Counters
//
//  Created by Thalles Araújo on 09/03/23.
//

import Foundation
extension Double {
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
      formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = style
      return formatter.string(from: self).orEmpty
  }
}
