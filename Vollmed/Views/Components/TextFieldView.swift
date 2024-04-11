//
//  TextFieldView.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 20/02/24.
//

import SwiftUI

struct TextFieldView: View {
    var placeholder: String
    var isSecureField = false
    @Binding var text: String
    
    var body: some View {
        if (isSecureField) {
            SecureField(placeholder, text: $text)
               .padding(14)
               .background(Color.gray.opacity(0.25))
               .cornerRadius(14)
               .autocorrectionDisabled()
               .keyboardType(.emailAddress)
               .textInputAutocapitalization(.never)
        } else {
            TextField(placeholder, text: $text)
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
        }
    }
}


