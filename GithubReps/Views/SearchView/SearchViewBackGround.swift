//
//  SearchViewBackGround.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 07.02.2025.
//

import SwiftUI

struct SearchViewBackGround: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.001).ignoresSafeArea()
            VStack {
                Image("gitlogo")
                    .frame(width: 130, height: 130)
                    .cornerRadius(80)
                    .padding(32)
                Spacer()

            }
        }
    }
}

#Preview {
    SearchViewBackGround()
}
