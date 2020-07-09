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
    
    @State private var rotationArray = [0.0, 0, 0]
    @State private var opacityArray: [Double] = [1, 1, 1]
    
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
                            .opacity(self.opacityArray[index])
                            .rotation3DEffect(.degrees(self.rotationArray[index]), axis: (x: 0, y: 1, z: 0))
                    }
                }
                
                Text("Current Score: \(score)")
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
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
        
        withAnimation {
            rotationArray[correctAnswer] = 360
            for i in 0 ..< opacityArray.count {
                opacityArray[i] = i == correctAnswer ? 1 : 0.25
            }
        }
        
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
    
    private func anotherRound() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        rotationArray = [0.0, 0, 0]
        opacityArray = [1, 1, 1]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
