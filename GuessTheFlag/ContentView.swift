//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nate Lee on 6/27/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ForEach(0..<3) {_ in
                HStack {
                    Text("Hello World")
                    Text("This is inside a stack")
                    Text("This is inside a stack")
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
