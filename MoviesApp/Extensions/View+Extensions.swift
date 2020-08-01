//
//  View+Extensions.swift
//  MoviesApp
//
//  Created by Roger Lacson on 6/15/20.
//  Copyright © 2020 Roger Lacson. All rights reserved.
//

import Foundation
import SwiftUI

enum DisplayMode {
    case fullscreen
}

extension View {
    
    var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    func fullscreen() -> some View {
        return self.frame(width: screenSize.width, height: screenSize.height)
    }
    
}
