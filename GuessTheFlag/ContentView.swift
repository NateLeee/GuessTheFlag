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
        Button(action: {
            print("Edit button was tapped")
        }) {
            HStack(spacing: 9) {
                Image(systemName: "pencil").renderingMode(.original)
                Text("Edit")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
