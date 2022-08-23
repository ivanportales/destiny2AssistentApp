//
//  UIFont+Extensions.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 22/08/22.
//

import UIKit

extension UIFont {
    static func normalFont(sized size: CGFloat) -> UIFont {
        return UIFont(name: "FuturaBookCTT Normal", size: size)!
    }
    
    static func normalItalicFont(sized size: CGFloat) -> UIFont {
        return UIFont(name: "Futura-BookOblique", size: size)!
    }
}
