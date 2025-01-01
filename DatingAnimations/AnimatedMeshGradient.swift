//
//  AnimatedMeshGradient.swift
//  DatingAnimations
//
//  Created by Alexis Santos on 14/12/2024.
//

import SwiftUI

struct AnimatedMeshGradient: View {
    @State private var onAppear = false

    private let moodyOrange = Color("MoodyOrange")
    private let moodyBlue = Color("MoodyBlue")

    var body: some View {
        MeshGradient(width: 3, height: 3, points: [
            .init(0, 0), .init(0.5, 0), .init(1, 0),
            .init(0, 0.5), .init(0.5, 0.5), .init(1, 0.5),
            .init(0, 1), .init(0.5, 1), .init(1, 1)
        ], colors: [
            onAppear ? .moodyBlue : .moodyOrange, .moodyBlue, onAppear ? .moodyOrange : .moodyBlue,
            .moodyBlue, onAppear ? .moodyBlue : .moodyOrange, onAppear ? .moodyOrange : .moodyBlue,
            onAppear ? .moodyOrange : .moodyBlue, onAppear ? .moodyBlue : .moodyOrange, .moodyBlue,
        ])
        .onAppear {
            withAnimation(
                .easeInOut(duration: 2)
                .repeatForever(autoreverses: true)) {
                    onAppear.toggle()
            }
        }
    }
}

#Preview {
    AnimatedMeshGradient()
}
