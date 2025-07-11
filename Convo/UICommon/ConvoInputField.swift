//
//  ConvoInputField.swift
//  Convo
//
//  Created by Liam Arbuckle on 11/6/2025.
//

import SwiftUI

struct ConvoInputField: View {
    let title: String
    @Binding var text: String

    private let surface = Color.white
    private let border = Color(#colorLiteral(red: 0.78, green: 0.83, blue: 0.9, alpha: 1))

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.gray)

            TextField("", text: $text)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(surface)
                        .shadow(color: .white.opacity(0.7), radius: 4, x: -2, y: -2)
                        .shadow(color: .black.opacity(0.08), radius: 4, x: 2, y: 2)
                )
                .font(.body)
                .autocorrectionDisabled()
        }
    }
}
