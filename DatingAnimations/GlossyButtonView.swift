//
//  GlossyButtonView.swift
//  DatingAnimations
//
//  Created by Alexis Santos on 13/12/2024.
//

import SwiftUI

struct GlossyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Adds a pressed effect
            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0),
                       value: configuration.isPressed)
    }
}

struct GlossyButtonView: View {
    var systemImageName: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImageName)
        }
        .buttonStyle(GlossyButtonStyle())
    }
}
