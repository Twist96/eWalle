//
//  LoginView.swift
//  eWalle
//
//  Created by Tochi on 18/07/2020.
//  Copyright © 2020 Ugarsoft. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        HStack {
            Image(uiImage: #imageLiteral(resourceName: "login_margin"))
                .resizable()
                .frame(maxWidth: screen.width / 3)
                .frame(height: screen.height + 30, alignment: .center)
                .aspectRatio(contentMode: .fit)
            
            VStack {
                Header()
                Spacer()
                VStack(alignment: .leading, spacing: 15) {
                    Image(uiImage: #imageLiteral(resourceName: "logo"))
                        .frame(width: 60, height: 60)
                    Text("eWalle")
                        .font(.custom("Ubuntu-Medium", size: 28))
                    Text("Open An Account For Digital E-Wallet Solutions.Instant Payouts.\n\n\nJoin For Free.")
                        .foregroundColor(Color(#colorLiteral(red: 0.4823529412, green: 0.4980392157, blue: 0.6196078431, alpha: 1)))
                        .modifier(AvenirFontModifier(size: 14))
                    
                }
                Spacer()
                Button(action: {
                    print(screen.height)
                }) {
                    HStack {
                        Text("Sign in")
                        .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.137254902, blue: 0.1882352941, alpha: 1)))
                            .font(.custom("AvenirNextLTPro-Demi", size: 16))
                        Image(uiImage: #imageLiteral(resourceName: "arrow_right"))
                            .renderingMode(.original)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 15)
                .background(Color("yellow"))
                .cornerRadius(20)
                
                Spacer().frame(height: 40)
                
                Text("Create an account")
                    .font(.custom("AvenirNextLTPro-Regular", size: 16))
            
            }
            .padding(.vertical, 30)
            .padding(.top, screen.height > 600 ? 42 : 0)
            .frame(height: screen.height)
            
        }
        .background(Color("background"))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
                .environment(\.colorScheme, .dark)
            LoginView()
                .environment(\.colorScheme, .dark)
        }
    }
}

let screen = UIScreen.main.bounds
var os = UIDevice.current.systemVersion

struct Header: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("06:20 PM")
                    .fontWeight(.semibold)
                    .modifier(AvenirFontModifier(size: 24))
                
                Spacer()
                
                HStack() {
                    Image(uiImage: #imageLiteral(resourceName: "cloud"))
                        .frame(width: 18, height: 16)
                    Text("34° C")
                        .fontWeight(.semibold)
                        .modifier(AvenirFontModifier(size: 13))
                }
            }
            
            Text("Nov.10.2020 | Wednesday")
                .modifier(AvenirFontModifier(size: 13))
        }
        .padding(.horizontal, 30)
    }
}
