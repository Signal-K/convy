//
//  CustomTextField.swift
//  Trackme
//
//  Created by Liam Arbuckle on 23/5/2025.
//

import SwiftUI

extension Color {
    static let gray70 = Color(white: 0.7)
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
        }
        
        .padding()
        .background(Color.gray70.opacity(0.2))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray70, lineWidth: 1)
        )
        .cornerRadius(12)
        .foregroundColor(.white)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    @State static var text = ""
    
    static var previews: some View {
        CustomTextField(placeholder: "Email", text: $text)
            .padding()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
