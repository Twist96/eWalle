//
//  FontModifiers.swift
//  eWalle
//
//  Created by Tochi on 18/07/2020.
//  Copyright © 2020 Ugarsoft. All rights reserved.
//

import SwiftUI

struct AvenirFontModifier: ViewModifier{
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom("AvenirNextLTPro-Regular", size: size))
    }
}

struct AvenirBoldFontModifier: ViewModifier{
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom("AvenirNextLTPro-Bold", size: size))
    }
}

struct AvenirMediumFontModifier: ViewModifier{
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom("AvenirNextLTPro-Demi", size: size))
    }
}
