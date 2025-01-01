//
//  ProfileCardView.swift
//  DatingAnimations
//
//  Created by Alexis Santos on 13/12/2024.
//

import SwiftUI

struct ProfileCardViewModel {
    var imageName: String
    var age: UInt
    var name: String
}

struct ProfileCardView: View {

    private let cardWidthFactor: CGFloat = 1
    private let cardHeightFactor: CGFloat = 1

    var viewModel: ProfileCardViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(viewModel.imageName)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * cardWidthFactor,
                           height: geometry.size.height * cardHeightFactor)
                    .cornerRadius(30)
                    .clipped()
                VStack {
                    Spacer()
                    ProfileCardContentView(age: viewModel.age,
                                           name: viewModel.name)
                }
            }
            .frame(width: geometry.size.width * cardWidthFactor,
                   height: geometry.size.height * cardHeightFactor)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ProfileCardContentView: View {
    var age: UInt
    var name: String

    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(age)")
                        .font(.title)
                    Text(name)
                        .font(.largeTitle)
                        .bold()
                }
                Spacer()
                VStack(spacing: 20) {
                    GlossyButtonView(systemImageName: "heart") {
                        print("Liked Button Pressed")
                    }
                    GlossyButtonView(systemImageName: "square") {
                        print("Comments Button Pressed")
                    }
                }
            }
            .foregroundColor(.white)
            .padding()
        }

    }
}

#Preview {
    let viewModel = ProfileCardViewModel(imageName: "profile1-korean-girl", age: 26, name: "Julia")
    ProfileCardView(viewModel: viewModel)
}
