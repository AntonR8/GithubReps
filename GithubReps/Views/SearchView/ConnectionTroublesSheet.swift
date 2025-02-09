//
//  ConnectionTroublesSheet.swift
//  GithubReps
//
//  Created by Антон Разгуляев on 09.02.2025.
//


import SwiftUI

struct ConnectionTroublesSheet: ViewModifier {
    @Bindable var mainViewModel: MainViewModel

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $mainViewModel.showConnectionProblems, content: {
                ZStack {
                    Color.black.opacity(0.3).ignoresSafeArea()
                    VStack {
                        Image(systemName: "point.3.connected.trianglepath.dotted")
                            .font(.largeTitle)
                        Text("Проблемы с соединением с сервером. Такое бывает. Попробуйте позже через пару минут.")
                            .multilineTextAlignment(.center)
                            .padding()
                        Text("Если ошибка постоянно появляется поробуйте конкретизировать ваш запрос, так как GitHub ограничивает количество результатов за определённое время...")
                            .foregroundStyle(.white)
                            .padding()
                            .background(.black)
                            .cornerRadius(10)
                    }
                    .foregroundStyle(.red)
                }
                .presentationDetents([.height(200), .large])
            })

    }
}


extension View {
    func connectionTroublesSheet(mainViewModel: MainViewModel) -> some View {
        modifier(ConnectionTroublesSheet(mainViewModel: mainViewModel))
    }
}
