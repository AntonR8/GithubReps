//
//  SettingsView.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 07.02.2025.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var mainViewModel: MainViewModel
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    var body: some View {
        List {
            Section("Информация") {
                NavigationLink {
                    AboutApp()
                } label: {
                    Label(
                        title: { Text("О приложении") },
                        icon: { Image(systemName: "questionmark.circle") }
                    )
                }
                NavigationLink {
                    DeveloperView()
                } label: {
                    Label(
                        title: { Text("Разработчик") },
                        icon: { Image(systemName: "person.crop.circle") }
                    )
                }
            }
            Section("Настройки") {
                    Toggle("🌙   Темная тема всегда", isOn: $mainViewModel.darkColorScheme)
            }
            if let appVersion {
                Text("Версия приложения \(appVersion)")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color.clear)
                    .padding()
            }
        }
        .foregroundStyle(.primary)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        SettingsView(mainViewModel: MainViewModel())
    }
}
