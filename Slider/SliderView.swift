//
//  SliderView.swift
//  Slider
//
//  Created by Анатолий Миронов on 08.11.2021.
//

import SwiftUI

struct SliderView: UIViewRepresentable{
    @Binding var currentValue: Double
    
    let color: UIColor
    let alpha: Int
    
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.moveThumb),
            for: .valueChanged
        )
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(currentValue)
        uiView.thumbTintColor = color.withAlphaComponent(CGFloat(alpha) / 100)
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
        SliderView(currentValue: .constant(50), color: .red, alpha: 1)
    }
}
