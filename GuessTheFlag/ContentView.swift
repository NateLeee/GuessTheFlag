//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nate Lee on 6/27/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        VStack(spacing: 18) {
            VStack {
                Text("Tap the flag of").padding(.horizontal)
                Text("\(countries[correctAnswer])")
            }
            
            ForEach(0..<3) { index in
                Button(action: {
                    // Action here
                }) {
                    Image(self.countries[index]).renderingMode(.original)
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
