//
//  NeumorphicInputField.swift
//  Convo
//
//  Created by Liam Arbuckle on 14/7/2025.
//

import SwiftUI

private let surface = Color.white

struct NeumorphicInput: View {
    let title: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)

            TextField("", text: $text)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(surface)
                        .shadow(color: .white.opacity(0.7), radius: 4, x: -2, y: -2)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)
                )
                .font(.body)
                .autocorrectionDisabled()
        }
    }
}
