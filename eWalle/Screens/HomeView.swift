//
//  HomeView.swift
//  eWalle
//
//  Created by Tochi on 18/07/2020.
//  Copyright © 2020 Ugarsoft. All rights reserved.
//

import SwiftUI
import Grid

struct HomeView: View {
    
    @Binding var isMenuShowing: Bool
    private var mainScrollAxis: Axis.Set{
        return isMenuShowing ? [] : .vertical
    }
    
    private var usersScrollAxis: Axis.Set{
        return isMenuShowing ? [] : .horizontal
    }
    
    var body: some View {
        ScrollView(mainScrollAxis, showsIndicators: false) {
            VStack {
    
                //header
                Group {
                    HStack {
                        Image(uiImage: #imageLiteral(resourceName: "logo"))
                            .frame(width: 50, height: 50)
                        Text("eWalle")
                            .font(.custom("Ubuntu-Bold", size: 28))
                        Spacer()
                        Button(action: {
                            self.isMenuShowing.toggle()
                        }) {
                            Image("menu")
                                .renderingMode(.original)
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 16)
                    Spacer()
                    .frame(height: 50)
                }
                
                //balance card
                Group {
                    Text("Account Overview")
                    .foregroundColor(Color("text"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .modifier(AvenirMediumFontModifier(size: 16))
                    BalanceCardView()
                    Spacer()
                    .frame(height: 50)
                }
                
                //send money user scroll
                Group {
                    HStack {
                        Text("Send Money")
                            .foregroundColor(Color("text"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .modifier(AvenirMediumFontModifier(size: 16))
                        Image("scan")
                    }
                    .padding(8)
                    .padding(.horizontal, 22)
                    ScrollView(usersScrollAxis, showsIndicators: false) {
                        HStack(spacing: 16) {
                            AddButton()
                            
                            ForEach(userData) { user in
                                UserCard(user: user)
                            }

                        }
                        .padding(.leading, 30)
                    }
                    .frame(height: 120)
                    Spacer()
                    .frame(height: 50)
                }
                
                //service
                Group {
                    HStack {
                        Text("Services")
                            .foregroundColor(Color("text"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .modifier(AvenirMediumFontModifier(size: 16))
                        Image(uiImage: #imageLiteral(resourceName: "filter"))
                    }
                    .padding(8)
                    .padding(.horizontal, 22)
                    Grid(serviceData) { service in
                        ServiceView(service: service)
                    }
                }
            
                //this where error is coming from
                
            }
        }
        .background(
            Color("background")
                .cornerRadius(isMenuShowing ? 30 : 0)
                .edgesIgnoringSafeArea(.all)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        )
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView(isMenuShowing: .constant(false))
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
                //.environment(\.colorScheme, .dark)
            HomeView(isMenuShowing: .constant(false))
                .environment(\.colorScheme, .dark)
        }
    }
}

struct BalanceCardView: View {
    var body: some View {
        HStack {
            VStack(spacing: 16) {
                Text("20,600")
                    .modifier(AvenirMediumFontModifier(size: 24))
                Text("Current balance")
                    .modifier(AvenirFontModifier(size: 12))
            }
            Spacer()
            
            AddButton()
        }
        .frame(height: 116)
        .padding(.horizontal, 25)
        .background(Color("card_background"))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
    }
}

struct AddButton: View {
    var body: some View {
        Button(action: {}) {
            Image(uiImage: #imageLiteral(resourceName: "plus"))
                .renderingMode(.original)
        }
        .frame(width: 50, height: 50)
        .background(Color("yellow"))
        .clipShape(Circle())
    }
}

struct UserCard: View {
    var user: User
    var body: some View {
        VStack {
            Image(uiImage: user.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .background(Color("background"))
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color("border"), lineWidth: 2)
            )
            Spacer()
                .frame(height: 12)
            Text(user.name)
                .foregroundColor(Color("text"))
                .modifier(AvenirFontModifier(size: 12))
        }
        .frame(width: 100, height: 120)
        .background(Color("card_background"))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color("border"), lineWidth: 2)
        )
            .padding(2)
    }
}

struct ServiceView: View {
    var service: Service
    var body: some View {
        VStack {
            service.image
                .frame(width: 60, height: 60)
                .background(Color("card_background"))
                .cornerRadius(12)
            Text(service.name)
                .frame(minHeight: 20)
                .multilineTextAlignment(.center)
                .modifier(AvenirMediumFontModifier(size: 10))
                .padding(.horizontal, 4)
                .padding(.top, 4)
        }
        .frame(width: 60, height: 150)
        .padding(4)
        .padding(.bottom, 4)
    }
}

struct User: Identifiable {
    var id = UUID()
    var name: String
    var image: UIImage
}

struct Service: Identifiable {
    var id = UUID()
    var name: String
    var image: Image
}

let userData = [
    User(name: "Mike", image: #imageLiteral(resourceName: "mike")),
    User(name: "Joshpeh", image: #imageLiteral(resourceName: "josh")),
    User(name: "Ashley", image: #imageLiteral(resourceName: "ashley"))
]

let serviceData = [
    Service(name: "Send Money", image: Image("send_money")),
    Service(name: "Receive Money", image: Image("receive_money")),
    Service(name: "Mobile Prepaid", image: Image("phone")),
    Service(name: "Electricity Bill", image: Image("electricity")),
    Service(name: "Cashback Offer", image: Image("tag")),
    Service(name: "Movie Tickets", image: Image("ticket")),
    Service(name: "Flight Tickets", image: Image("plane")),
    Service(name: "More Options", image: Image("more"))
]

