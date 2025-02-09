//
//  ResultLine.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 06.02.2025.
//

import SwiftUI

struct OwnerAvatar: View {
    let avatarURL: String
    let avatarSize: CGFloat
    let cornerRadius: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.gray.opacity(0.2))
            .frame(width: avatarSize, height: avatarSize)
            .overlay{
                AsyncImage(url: URL(string: avatarURL)!) { response in
                    if let image = response.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: avatarSize, height: avatarSize)
                            .clipped ( )
                            .cornerRadius(cornerRadius)
                    } else {
                        ProgressView()
                    }
                }
            }
    }
}

#Preview {
    OwnerAvatar(avatarURL: repositoryModelMockData.avatarURL, avatarSize: 40, cornerRadius: 5)
}
