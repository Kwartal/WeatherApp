//
//  UIColor + Extension.swift
//  Clima
//
//  Created by Богдан Баринов on 30.08.2022.
//

import UIKit
import UIColor_Hex_Swift

extension UIColor {
    
    public static func create(light: String, lightAlpha: Double = 1.0, dark: String? = nil, darkAlpha: Double = 1.0) -> UIColor {
        if let dark = dark {
            return create(light: UIColor(light).withAlphaComponent(lightAlpha),
                          dark: UIColor(dark).withAlphaComponent(darkAlpha))
        }
        else {
            return UIColor(light)
        }
    }
    
    public static func create(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .unspecified, .light:
                    return light
                case .dark:
                    return dark
                @unknown default:
                    return light
                }
            }
        }
        else {
            return light
        }
    }
}
