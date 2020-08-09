//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nate Lee on 6/27/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
        ].shuffled()
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertMsg = ""
    @State private var score: Int = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 18) {
                VStack {
                    Text("Tap the flag of").padding(.horizontal)
                        .foregroundColor(.white)
                    Text("\(countries[correctAnswer])")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { index in
                    Button(action: {
                        // Action here
                        self.flagTapped(index)
                    }) {
                        FlagImage(countryName: self.countries[index])
                            .accessibility(label: Text(self.labels[self.countries[index], default: "Unknown flag"]))
                    }
                }
                
                Spacer()
            }
        }
        .alert(isPresented: self.$showingScore) { () -> Alert in
            Alert(title: Text("\(self.scoreTitle)"), message: Text("\(alertMsg)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "✅Correct"
            score += 1
            alertMsg = "Yay, and your score is \(score)."
        } else {
            scoreTitle = "🚫Wrong"
            // Tell them which country it is of
            alertMsg = "Oops, it's the flag of \(countries[number])."
        }
        showingScore = true
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
