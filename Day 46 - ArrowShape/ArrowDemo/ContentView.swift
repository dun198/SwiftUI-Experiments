//
//  ContentView.swift
//  ArrowDemo
//
//  Created by Tobias Dunkel on 17.11.22.
//

import SwiftUI

struct ContentView: View {
    @State private var startPoint: CGPoint = .init(x: 100, y: 100)
    @State private var endPoint: CGPoint = .init(x: 200, y: 200)
    @State private var midPoint: CGPoint = .init(x: 150, y: 120)
    @State private var width: Double = 10
    
    @State private var editMode = false
    @State private var isAnmiationDone = false
    
    var body: some View {
        VStack {
            Arrow(startPoint: startPoint, endPoint: endPoint, midPoint: midPoint, width: width)
                .controlsView(startPoint: $startPoint, endPoint: $endPoint, midPoint: $midPoint, editMode: $editMode)
            
            Text("Width")
            Slider(value: $width.animation(), in: 10...80, step: 10)                    .padding([.horizontal, .bottom])
                .padding([.horizontal, .bottom])

            Button("Animate width change") {
                withAnimation(.interpolatingSpring(mass: 2, stiffness: 100, damping: 20, initialVelocity: 10)) {
                    width = isAnmiationDone ? 60 : 20
                    isAnmiationDone.toggle()
                }
               
            }
            .padding()
            
            Button("Edit Mode: \(editMode ? "On" : "Off")") {
                editMode.toggle()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
