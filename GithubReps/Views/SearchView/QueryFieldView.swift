//
//  LoginView.swift
//  SaveVideo
//
//  Created by Антон Разгуляев on 18.12.2024.
//

import SwiftUI

struct QueryFieldView: View {
    @Binding var currentQuery: String
    @FocusState.Binding var isFocused: Bool
    var onSubmitAction: () -> Void

    var body: some View {
        TextField(String("например Image Generator"), text: $currentQuery)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .onSubmit {
                onSubmitAction()
            }
            .submitLabel(.search)
            .padding(12)
            .padding(.leading, 30)
            .background(.secondary.opacity(0.1))
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .stroke(isFocused ? Color.yellow : Color.secondary,
                            lineWidth: isFocused ? 1 : 0.3)
            }
            .overlay {
                HStack{
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if !currentQuery.isEmpty {
                        Button(action: {currentQuery = ""}) {
                            Image(systemName: "xmark")
                                .foregroundStyle(.gray)
                                .font(.footnote)
                                .padding(6)
                                .overlay {
                                    Capsule()
                                        .fill(.clear)
                                        .stroke(.gray)
                                }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(1)
            .focused($isFocused)
    }
}

#Preview {
//    QueryFieldView(currentQuery: .constant(""), isFocused: , onSubmitAction: {})
}
