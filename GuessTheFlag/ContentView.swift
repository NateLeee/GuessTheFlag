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
    
    @State private var controlArray = [true, true, true]
    @State private var indexShouldRotate: Int? = nil
    
    
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
                        self.flagTapped(index)
                    }) {
                        FlagImage(countryName: self.countries[index])
                            .opacity(self.indexShouldRotate == index ? 1 : 0.25)
                            .rotation3DEffect(Angle(degrees: self.indexShouldRotate == index ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                            .animation(Animation.default)
                    }
                }
                
                Text("Current Score: \(score)")
                    .foregroundColor(.white)
                
                Button("Shuffle") {
                    self.askQuestion()
                }
                
                Spacer()
            }
        }
        .alert(isPresented: self.$showingScore) { () -> Alert in
            Alert(title: Text("\(self.scoreTitle)"), message: Text("\(alertMsg)"), dismissButton: .default(Text("Continue")))
                
        }
    }
    
    private func flagTapped(_ number: Int) {
        controlArray = [false, false, false]
        controlArray[correctAnswer] = true
        
        indexShouldRotate = correctAnswer
        
        if number == correctAnswer {
            score += 1
        } else {
            scoreTitle = "🚫Wrong"
            // Tell them which country it is of
            alertMsg = "Oops, it's the flag of \(countries[number])."
            showingScore = true
        }
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        controlArray = [true, true, true]
        indexShouldRotate = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
