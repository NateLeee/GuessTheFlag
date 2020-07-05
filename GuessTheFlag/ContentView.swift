//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nate Lee on 6/27/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
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
