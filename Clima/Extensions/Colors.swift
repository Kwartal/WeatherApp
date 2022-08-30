//
//  Colors.swift
//  Clima
//
//  Created by Богдан Баринов on 30.08.2022.
//

import UIKit

public class Colors {

    /**
     (light: "#FFFFFF", dark: "#000000") Основной цвет фона
     */
    public static let background = UIColor.create(light: "#FFFFFF", dark: "#000000")
    
    /**
     (light: "#262626", dark: "#FFFFFF") Базовый текст
     */
    public static let text = UIColor.create(light: "#262626", dark: "#FFFFFF")
    
    public static let weatherColor = UIColor.create(light: "#A2845E", dark: "#FF453A")

    /**
     Используется для точечных цветов когда нужно кастомное значение альфы например. Должен быть составлен из цветов перечисленных выше
     */
    public static func createCustom(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor.create(light: light, dark: dark)
    }
    

}
