//
//  StringExtension.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/13/24.
//

import SwiftUI

extension String {
    func size(_ font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font : font]
        return self.size(withAttributes: attributes)
    }
}
