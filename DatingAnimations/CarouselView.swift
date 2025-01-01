//
//  ContentView.swift
//  DatingAnimations
//
//  Created by Alexis Santos on 13/12/2024.
//

import SwiftUI

struct CarouselView: View {
    var body: some View {
        let items = MockItem.mockItems
        GeometryReader { geometry in
            ZStack {
                AnimatedMeshGradient()

                Text("Every great person should be met with another")
                    .foregroundColor(.white.opacity(0.02))
                    .bold()
                    .font(.system(size: 100))
                    .multilineTextAlignment(.center)
                HorizontalCarouselView(items: items, content: { item in
                    let viewModel = ProfileCardViewModel(imageName: item.imageName,
                                                         age: item.age,
                                                         name: item.name)
                    ProfileCardView(viewModel: viewModel)
                })
                .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.65)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Center within parent
                VStack {
                    Spacer()
                    Text("""
                         Every great person should be met 
                         with another
                         """)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.init(top: 0, leading: 0, bottom: 100, trailing: 0))
                }
            }
            .ignoresSafeArea()

        }
    }
}

#Preview {
    CarouselView()
}
