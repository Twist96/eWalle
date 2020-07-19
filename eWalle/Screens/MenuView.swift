//
//  MenuView.swift
//  eWalle
//
//  Created by Tochi on 18/07/2020.
//  Copyright © 2020 Ugarsoft. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @Binding var isMenuShowing: Bool
    var body: some View {
        VStack(alignment: .leading) {
            //header + profile
            Group {
                MenuHeader(isMenuShowing: $isMenuShowing)
                Spacer()
                //.frame(maxHeight: screen.height > 600 ? 50 : 20)
            }
            
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        MenuGroup()
                        Spacer()
                        
                        HStack(alignment: .center) {
                            Image("power")
                            Text("Logout")
                                .font(.custom("AvenirNextLTPro-Bold", size: 16))
                        }
                        .padding(.horizontal, 30)
                        
                        Spacer()
                            .frame(height: 10)
                        
                        Text("Version 2.0.1")
                            .font(.custom("AvenirNextLTPro-Regular", size: 10))
                            .padding(.horizontal, 30)
                        Spacer()
                        .frame(height: 16)
                    }
                    .frame(height: geometry.frame(in: .global).height, alignment: .top)
                    .frame(maxHeight: 1000)
                }
            }
            .frame(width: 150)
            
        }
        .background(
            Color("card_background")
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuView(isMenuShowing: .constant(false))
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
                //.environment(\.colorScheme, .dark)
            MenuView(isMenuShowing: .constant(false))
                .environment(\.colorScheme, .dark)
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct MenuHeader: View {
    
    @Binding var isMenuShowing: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                HStack {
                    Image(uiImage: #imageLiteral(resourceName: "carol"))
                        .frame(width: 50, height: 50)
                        .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9529411765, blue: 0.9647058824, alpha: 1)))
                        .clipShape(Circle())
                    VStack {
                        Text("Carol Black")
                            .font(.custom("AvenirNextLTPro-Demi", size: 16))
                        Text("Seattle,Washington")
                            .font(.custom("AvenirNextLTPro-Regular", size: 10))
                    }
                }
            }
            .padding(20)
            .padding(.horizontal, screen.height > 600 ? 30 : 0)
            .padding(.top, screen.height > 600 ? 42 : 0)
            .background(Color("background"))
            .cornerRadius(60, corners: [.bottomRight])
            .edgesIgnoringSafeArea(.all)
            
            Spacer()
            
            Button(action: {
                self.isMenuShowing = false
            }) {
                Image("xmark")
                    .renderingMode(.original)

            }
            .padding()
            .padding(.horizontal, screen.height > 600 ? 16 : 0)
            .offset(y: 16)
        }
    }
}

struct MenuGroup: View {
    @State var menuMinY: CGFloat = 0
    @State var offsetVlaue: CGFloat = 0
    @State var selectedIndex: Int = 0
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 25) {
                ForEach(menuData.indices, id: \.self) { index in
                    GeometryReader { geometry in
                        Text(menuData[index].name)
                            .padding(.leading, 30)
                            .font(.custom(index == self.selectedIndex ? "AvenirNextLTPro-Bold" : "AvenirNextLTPro-Regular", size: 16))
                            .frame(width: 150, height: 33, alignment: .leading)
                            .onTapGesture {
                                self.offsetVlaue = geometry.frame(in: .global).minY - self.menuMinY
                                self.selectedIndex = index
                        }.onAppear{
                            if index == 0{
                                self.menuMinY = geometry.frame(in: .global).minY
                            }
                        }
                    }
                    .frame(width: 150, height: 33)
                    
                }
            }
            Color("yellow")
                .frame(width: 5, height: 33)
                .offset(y: offsetVlaue)
                .animation(Animation.easeInOut(duration: 0.1))
        }
    }
}

struct MenuItem {
    var id = UUID()
    var name: String
}

let menuData = [MenuItem(name: "Home"),
                MenuItem(name: "Profile"),
                MenuItem(name: "Accounts"),
                MenuItem(name: "Transactions"),
                MenuItem(name: "Stats"),
                MenuItem(name: "Settings"),
                MenuItem(name: "Help")]
