//
//  ContentView.swift
//  Slider
//
//  Created by Анатолий Миронов on 08.11.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var targetValue = Int.random(in: 0...100)
    @State private var currentValue = 50.0
    @State private var opacity = 1.0
    @State private var alertPresented = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Подвиньте слайдер как можно ближе к: \(targetValue)")
            
            HStack {
                Text("0")
                SliderView(currentValue: $currentValue, opacity: $opacity)
                    .onChange(of: currentValue) { _ in
                        changeOpacity()
                    }
                Text("100")
            }
            .padding(.bottom, 20)
            
            Button("Проверь меня!", action: showResult)
                .alert("Your score", isPresented: $alertPresented, actions: {}) {
                    Text(">>>   \(computeScore())   <<<")
                }
            Button("Начать заново") {
                targetValue = Int.random(in: 0...100)
                changeOpacity()
            }
        }
        .padding()
    }
    
    private func showResult() {
        alertPresented.toggle()
    }
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return 100 - difference
    }
    
    private func changeOpacity() {
        opacity = Double(computeScore()) / 100
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
