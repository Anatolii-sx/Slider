//
//  SliderView.swift
//  Slider
//
//  Created by Анатолий Миронов on 08.11.2021.
//

import SwiftUI

struct SliderView: UIViewRepresentable{
    @Binding var currentValue: Double
    @Binding var opacity: Double
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.moveThumb),
            for: .allTouchEvents
        )
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(currentValue)
        uiView.thumbTintColor = UIColor(red: 255, green: 0, blue: 0, alpha: opacity)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(currentValue: $currentValue)
    }
}

extension SliderView {
    class Coordinator: NSObject {
        @Binding var currentValue: Double
        
        init(currentValue: Binding<Double>) {
            self._currentValue = currentValue
        }
        
        @objc func moveThumb(_ sender: UISlider) {
            currentValue = Double(sender.value)
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(currentValue: .constant(50), opacity: .constant(0.5))
    }
}
