//
//  LoginView.swift
//  layoutapp
//
//  Created by Thiem Jason on 3/23/21.
//

import SwiftUI

struct HomeView: View {
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject var loginViewModel : LoginViewModel
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    self.loginViewModel.logout()
                }, label: {
                    Text("SIGN OUT")
                        .fontWeight(.bold)
                        .frame(width: 100, height: 50, alignment: .center)
                })
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding([.leading, .trailing], 40)
                
            }
            Image("facebook")
                .resizable()
                .clipShape(Circle())
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .padding()
                .frame(width: 200, height:200)
            
            Text(LoginService.getToken())
                .foregroundColor(.blue)
                .fontWeight(.bold)
                .font(.system(size: 30))
                .padding()
            Spacer()
        }
        
        .onAppear(){
            print("Home View appear")
        }
        .onDisappear(){
            print("Home View disappear")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
