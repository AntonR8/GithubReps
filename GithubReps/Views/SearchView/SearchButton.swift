//
//  NewPhotoButton.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 12.09.2024.
//

import SwiftUI

struct SearchButton: View {
    var action: () -> Void
    let isDisabled: Bool

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "sparkles")
                Text("Искать")
            }
            .foregroundStyle(isDisabled ? .white.opacity(0.5) : .white)
            .padding(14)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .foregroundStyle(isDisabled ? Color.gray.gradient : Color.purple.gradient)
            )
        }
        .disabled(isDisabled)
        .padding(.vertical)
    }
}

#Preview {
    SearchButton(action: {}, isDisabled: true)
}
