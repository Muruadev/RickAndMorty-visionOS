//
//  Spinner.swift
//  RickAndMorty
//
//  Created by Fernando Murua Alcazar on 28/6/23.
//

import SwiftUI

struct Spinner: View {
    
    let rotationTime: Double = 0.75
    let fullRotation: Angle = .degrees(360)
    static let initialDegree: Angle = .degrees(270)
    let animationTime: Double = 1.9
    
    @State var spinnerStart: CGFloat = 0.0
    @State var spinnerEndS1: CGFloat = 0.03
    @State var spinnerEndS2S3: CGFloat = 0.03

    @State var rotationDegreeS1 = initialDegree
    @State var rotationDegreeS2 = initialDegree
    @State var rotationDegreeS3 = initialDegree

    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
               .edgesIgnoringSafeArea(.all)

            ZStack {
                SpinnerCircle(start: spinnerStart, end: spinnerEndS2S3, rotation: rotationDegreeS3, color: .purple)
                SpinnerCircle(start: spinnerStart, end: spinnerEndS2S3, rotation: rotationDegreeS2, color: .pink)
                SpinnerCircle(start: spinnerStart, end: spinnerEndS1, rotation: rotationDegreeS1, color: .blue)

            }.frame(width: 200, height: 200)
            Text("Fetching Data...")
                .padding(.top, 240)
        }
            .onAppear() {
                self.animateSpinner()
                Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) { (mainTimer) in
                    self.animateSpinner()
                }
            }
    }
    
    func animateSpinner(with timeInterval: Double, completion: @escaping (() -> Void)) {
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: rotationTime)) {
                completion()
            }
        }
    }
    
    func animateSpinner() {
            animateSpinner(with: rotationTime) { self.spinnerEndS1 = 1.0 }

            animateSpinner(with: (rotationTime * 2) - 0.025) {
                self.rotationDegreeS1 += fullRotation
                self.spinnerEndS2S3 = 0.8
            }

            animateSpinner(with: (rotationTime * 2)) {
                self.spinnerEndS1 = 0.03
                self.spinnerEndS2S3 = 0.03
            }

            animateSpinner(with: (rotationTime * 2) + 0.0525) { self.rotationDegreeS2 += fullRotation }

            animateSpinner(with: (rotationTime * 2) + 0.225) { self.rotationDegreeS3 += fullRotation }
        }
}

struct SpinnerCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color
    
    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .fill(color)
            .rotationEffect(rotation)
    }
}
