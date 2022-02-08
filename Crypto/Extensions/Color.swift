//
//  Color.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme{
    let accent = Color("AccesntColor")
    let bacckground = Color("BackgroundColor")
    let greencolor = Color("Greencolor")
    let tedcolor = Color("Redcolor")
    let secondTextColor = Color("SecondTextColor")
    
}

struct LaunchTheme{
    let accent = Color("LaunchAccentColor")
    let bacckground = Color("Launchbackground")
}
