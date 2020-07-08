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
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    @State private var score: Int = 0
    
    @State private var shouldOverrideOpacity = true
    
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
                            .opacity(self.determineOpacity(index: index))
                            .animation(.easeOut(duration: 1.5))
                    }
                }
                
                Text("Current Score: \(score)")
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .alert(isPresented: self.$showingAlert) { () -> Alert in
            Alert(title: Text("\(self.alertTitle)"), message: Text("\(alertMsg)"), dismissButton: .default(Text("Continue")) {
                self.anotherRound()
                })
            
        }
    }
    
    private func flagTapped(_ number: Int) {
        shouldOverrideOpacity = false
        
        if number == correctAnswer {
            score += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.anotherRound()
            }
            
        } else {
            alertTitle = "🚫Wrong"
            alertMsg = "Oops, it's the flag of \(countries[number])."
            showingAlert = true
        }
    }
    
    private func determineOpacity(index: Int) -> Double {
        if (shouldOverrideOpacity) {
            return 1
        }
        if (index == correctAnswer) {
            return 1
        } else {
            return 0.25
        }
    }
    
    private func anotherRound() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        shouldOverrideOpacity = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
