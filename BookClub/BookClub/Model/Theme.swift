//
// FILE          : Theme
// PROJECT       : PROG3230 - Assignment #2
// PROGRAMMER    : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION   : This file defines the Theme enumeration, which represents various themes for the book clubs.
//                 Each theme has associated properties for its accent color, main color, and name
//

import SwiftUI

enum Theme: String, Codable {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    var name: String {
        rawValue.capitalized
    }
}

