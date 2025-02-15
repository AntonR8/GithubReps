//
//  AboutApp.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 07.02.2025.
//

import SwiftUI

struct AboutApp: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("""
    Приложение ищет репозитории github.com, отображает информацию по ним и сохраняет их в избранные для просмотра в оффлайн-режиме.
    """)
                Text("""
    Экран поиска
    • Должно быть поле для ввода поискового запроса.
    • Должен быть список полных названий, найденных по запросу репозиториев.
    При нажатии на элемент списка должен осуществляться переход на экран отдельного репозитория.
    • Для поиска следует использовать запрос
    https://developer.github.com/v3/search/#search-repositories.
    """)
                Text("""
    Экран отдельного репозитория
    • Должна быть кнопка добавления в избранное.
    • Должны отображаться:
    • полное название репозитория
    • его описание
    • полное имя владельца репозитория
    • e-mall владельца
    • Для загрузки данных о пользователе следует использовать запрос
    https://developer.github.com/v3/users/#get-a-single-user.
    """)
                Text("""
    Экран избранных репозиториев
    • Должен быть список полных названий репозиториев в избранном.
    • Список избранных должен быть доступен без подключения к сети.
    • Список избранных должен сохраняться между запусками приложения.
    """)
            }
            .padding()
        }
        .navigationTitle("О приложении")
    }
}

#Preview {
    NavigationStack {
        AboutApp()
    }
}
