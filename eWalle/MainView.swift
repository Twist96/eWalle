//
//  ContentView.swift
//  eWalle
//
//  Created by Tochi on 17/07/2020.
//  Copyright © 2020 Ugarsoft. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var isMenuShowing = false
    @State var homeViewPosition = CGSize.zero
    @State var loggedIn = false
    var body: some View {
        ZStack {
            MenuView(isMenuShowing: $isMenuShowing, loggedIn: $loggedIn)
            HomeView(isMenuShowing: $isMenuShowing)
                .rotationEffect(.degrees(isMenuShowing ? -15 : 0))
                .rotationEffect(.degrees(-Double(homeViewPosition.width/2)))
                .offset(x: isMenuShowing ? screen.width / 1.5 : 0)
                .offset(x: homeViewPosition.width * 3, y: homeViewPosition.height * 2)
                .scaleEffect(isMenuShowing ? 0.65 : 1)
                .scaleEffect(isMenuShowing ? CGFloat(1 - homeViewPosition.width/100) : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .gesture(
                DragGesture().onChanged{ value in
                    if self.isMenuShowing {
                        self.homeViewPosition = value.translation
                        print(self.homeViewPosition.width)
                    }
                }.onEnded{ value in
                    if self.homeViewPosition.width < -20{
                        self.isMenuShowing = false
                    }
                    self.homeViewPosition = .zero
                }
            )
            
            if !loggedIn {
                LoginView(loggedIn: $loggedIn)
                    .opacity(loggedIn ? 0 : 1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                //.previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                //.previewDisplayName("iPhone SE")
                //.environment(\.colorScheme, .dark)
            MainView()
                .environment(\.colorScheme, .dark)
        }
    }
}
