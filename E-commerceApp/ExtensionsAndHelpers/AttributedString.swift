//
//  AttributedString.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 05.11.2022.
//

import UIKit

//extension String {
//    func createStringtToStrike(stringtToStrike: String) -> NSMutableAttributedString {
//        let attributedString = NSMutableAttributedString(string: self)
//        let range = attributedString.mutableString.range(of: stringtToStrike)
//        attributedString.addAttributes([NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue], range: range)
//        return attributedString
//    }
//    func createStringtToColor(stringtToColor: String, color: UIColor) -> NSMutableAttributedString {
//        let attributedString = NSMutableAttributedString(string: self)
//        let range = attributedString.mutableString.range(of: stringtToColor)
//        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : color], range: range)
//        return attributedString
//    }
//}



extension NSMutableAttributedString {
    func createStringtToStrike(stringtToStrike: String, size: CGFloat){
        //let attributedString = NSMutableAttributedString(string: self)
        let range = self.mutableString.range(of: stringtToStrike)
        self.addAttributes([NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)], range: range)
    }
    func createStringtToColor(stringtToColor: String, color: UIColor){
       // let attributedString = NSMutableAttributedString(string: self)
        let range = self.mutableString.range(of: stringtToColor)
        self.addAttributes([NSAttributedString.Key.foregroundColor : color], range: range)
    }
}
