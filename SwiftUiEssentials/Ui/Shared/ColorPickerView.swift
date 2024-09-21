//
//  ColorPickerView.swift
//  SwiftUiEssentials
//
//  Created by Amit on 21/09/2024.
//

import SwiftUI
struct Post: Identifiable {
    let id: Int
    let title: String
    let body: String
}

struct ColorPickerView: View {
    @State private var bgColor =
        Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

    var body: some View {
        VStack {
            ColorPicker("Alignment Guides", selection: $bgColor)
        }
    }
}

#Preview {
    ColorPickerView()
}
