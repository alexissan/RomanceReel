//
//  HorizontalCarouselView.swift
//  DatingAnimations
//
//  Created by Alexis Santos on 14/12/2024.
//

import SwiftUI

struct MockItem: Hashable {
    let imageName: String
    let age: UInt
    let name: String

    static let mockItems = [
        MockItem(imageName: "profile2", age: 26, name: "Julia"),
        MockItem(imageName: "profile1-korean-girl", age: 36, name: "Jessica"),
        MockItem(imageName: "profile3", age: 41, name: "Gloria"),
        MockItem(imageName: "profile4", age: 16, name: "Anatolia"),
        MockItem(imageName: "profile2", age: 48, name: "Lucia"),
        MockItem(imageName: "profile3", age: 23, name: "Juanita")
    ]
}

struct HorizontalCarouselView<Item: Hashable, Content: View>: View {
    @State private var currentPage: Int = 0
    @State private var pageOffset: CGFloat = 0
    @State private var dragOffset: CGFloat = 0
    @State private var isDragging: Bool = false // Tracks whether a drag is occurring

    let items: [Item]
    let content: (Item) -> Content

    init(items: [Item], @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.content = content
    }


    var body: some View {
        GeometryReader { geometry in
            let pageWidth = geometry.size.width // Width of each page
            let spacing: CGFloat = 30 // Space between pages

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(items.indices, id: \.self) { index in
                        content(items[index])
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height)
                            .rotation3DEffect(
                                getAngleForPage(index: index, pageWidth: pageWidth),
                                axis: (x: 1, y: 0, z: 0)
                            )
                            .animation(.easeInOut(duration: 0.25), value: currentPage)
                            .contentShape(Rectangle()) // Make the entire view tappable
                            .onTapGesture {
                                // Only allow tap if no dragging is happening
                                if !isDragging {
                                    print("Tapped on \(items[index])")
                                }
                            }
                    }
                }
                .padding(.horizontal, (geometry.size.width - pageWidth) / 2) // Center the first and last items
                .offset(x: dragOffset - CGFloat(currentPage) * (pageWidth + spacing))
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            isDragging = true // Drag has started
                            // Update pageOffset dynamically to follow the drag
//                            // Update dragOffset dynamically to follow the drag
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            let dragThreshold = pageWidth / 6
                            let totalOffset = value.translation.width

                            // Determine the target page
                            if totalOffset < -dragThreshold && currentPage < items.count - 1 {
                                currentPage += 1
                            } else if totalOffset > dragThreshold && currentPage > 0 {
                                currentPage -= 1
                            }

                            // Reset dragOffset and snap to the nearest page
                            withAnimation(.interpolatingSpring(stiffness: 100, damping: 80)) {
                                dragOffset = 0
                            }
                            // Allow taps again after drag ends
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isDragging = false
                            }
                        }
                )
            }
            .scrollClipDisabled()
        }
    }

    private func getAngleForPage(index: Int, pageWidth: CGFloat) -> Angle {
        let offsetFromCenter = (CGFloat(index) - CGFloat(currentPage)) * pageWidth
        let totalOffset = offsetFromCenter + dragOffset // Include drag offset for dynamic rotation
        let rotation = -totalOffset / pageWidth * 8 // Adjust multiplier for rotation intensity

        if index < currentPage {
            return .degrees(rotation) // Tilt upwards for pages to the left
        } else if index > currentPage {
            return .degrees(-rotation) // Tilt downwards for pages to the right
        } else {
            return .degrees(0) // No rotation for the current page
        }
    }
}
