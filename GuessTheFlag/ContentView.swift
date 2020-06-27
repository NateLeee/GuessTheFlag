//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nate Lee on 6/27/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        Button(action: {
            self.showingAlert = true
        }) {
            Text("Show Alert")
        }.alert(isPresented: $showingAlert) { () -> Alert in
            Alert(title: Text("Test Alert"), message: Text("This is some detail message"), dismissButton: .cancel(Text("Dismiss!")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
