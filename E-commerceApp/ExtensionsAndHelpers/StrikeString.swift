//
//  StrikeString.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 05.11.2022.
//

import UIKit

extension String {
        func createAttributedString(stringtToStrike: String) -> NSMutableAttributedString {
            let attributedString = NSMutableAttributedString(string: self)
            let range = attributedString.mutableString.range(of: stringtToStrike)
            attributedString.addAttributes([NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue], range: range)
            return attributedString
        } }
