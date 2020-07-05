//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Nate Lee on 7/5/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    var countryName: String
    
    var body: some View {
        Image(countryName)
            .renderingMode(.original)
            .aspectRatio(1.5, contentMode: .fill)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.white, lineWidth: 1))
            .shadow(color: .gray, radius: 6)
            .padding(.bottom, 9)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(countryName: "Germany")
    }
}
