//
//  DeveloperView.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 07.02.2025.
//

import SwiftUI

struct DeveloperView: View {
    let contactURL = URL(string: "https://t.me/AntonR87")!
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 50)
                Image("IMG_1369-2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .cornerRadius(75)
                Text("Разгуляев Антон Александрович")
                    .font(.largeTitle)
                    .bold()
                Text("iOS | Swift | SwiftUI разработчик")
                    .font(.title2)
                    .foregroundStyle(.secondary)
                    .bold()
                    .padding(.bottom)
                Text("г. Санкт-Петербург")

                Text("37 лет, родился 25 июня 1987")
                    .foregroundStyle(.secondary)

                Text("Связаться:")
                    .padding(.top)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Link(destination: contactURL, label: {
                    Label("@AntonR87", systemImage: "paperplane.circle.fill")
                        .padding(.horizontal)
                        .padding(.vertical,8)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .foregroundStyle(.white)
                })


                .navigationTitle("Разработчик")
                .navigationBarTitleDisplayMode(.inline)
            }
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    NavigationStack {
        DeveloperView()
    }
}
