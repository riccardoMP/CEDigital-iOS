//
//  NSMutableAttributedStringExtension.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 14/08/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import UIKit

//https://stackoverflow.com/questions/28496093/making-text-bold-using-attributed-string-in-swift
extension NSMutableAttributedString {
    var fontSize:CGFloat { return 14 }
    var boldFont:UIFont { return UIFont(name: "AvenirNext-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont(name: "AvenirNext-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
    
    func bold(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func boldAsteriskLikeWhatsapp(resultString: String, originFont:UIFont, boldFont:UIFont) -> NSMutableAttributedString {
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: resultString, attributes: [NSAttributedString.Key.font: originFont ] )
        
        guard let regex  = try? NSRegularExpression(pattern: "(\\*)(.*?)(\\*)", options: []) else {
            return attributedString
        }
        
        let range: NSRange = NSMakeRange(0, resultString.count)
        
        regex.enumerateMatches(in: resultString.lowercased(), options: [], range: range) { (textCheckingResult, matchingFlags, stop) in
            guard let subRange = textCheckingResult?.range else {
                return
            }
            
            
            
            attributedString.addAttributes([NSAttributedString.Key.font : boldFont], range: subRange)
        }
        
        attributedString.mutableString.replaceOccurrences(of: "*", with: "", options: .caseInsensitive, range: NSRange(location: 0, length: resultString.count))
        
        
        return attributedString
    }
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}

