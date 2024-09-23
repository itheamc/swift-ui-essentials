//
//  ShimmerView.swift
//  SwiftUiEssentials
//
//  Created by Amit on 23/09/2024.
//

import SwiftUI

struct ShimmerView: View {
    @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { geometry in
            // The gradient used for the shimmer effect
            let gradient = LinearGradient(
                gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1), Color.gray.opacity(0.3)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            
            // Shimmering Rectangle
            Rectangle()
                .fill(gradient)
                .rotationEffect(Angle(degrees: 30)) // Adding angle to the gradient
                .offset(x: isAnimating ? geometry.size.width : -geometry.size.width) // Initial offset
                .onAppear {
                    withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                        isAnimating = true // Triggers the animation
                    }
                }
        }
    }
}
#Preview {
    ShimmerView()
}


