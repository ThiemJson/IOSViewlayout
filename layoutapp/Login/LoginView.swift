//
//  LoginView.swift
//  layoutapp
//
//  Created by Thiem Jason on 3/23/21.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    @StateObject var  loginViewModel = LoginViewModel()
    var body: some View {
        return NavigationView {
            ZStack {
                if self.loginViewModel.authentication == Authentication.Loadding{
                    SplashView()
                }
                else if self.loginViewModel.authentication == Authentication.LoggedIn {
                    HomeView().environmentObject(self.loginViewModel)
                }
                else {
                    VStack{
                        Image("facebook")
                            .resizable()
                            .clipShape(Circle())
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            .padding()
                            .frame(width: 200, height:200)
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            Text("Username")
                                .foregroundColor(.blue)
                                .fontWeight(.heavy)
                                .font(.title3)
                            TextField("username", text: $username)
                                .textFieldStyle(PlainTextFieldStyle())
                                .cornerRadius(20)
                                .frame(height: 50)
                                .padding([.leading, .trailing], 20)
                                .foregroundColor(.gray)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                                .frame(height: 50)
                        })
                        .padding([.leading, .trailing], 40)
                        .padding([.bottom, .top], 30)
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            Text("Password")
                                .foregroundColor(.blue)
                                .fontWeight(.heavy)
                                .font(.title3)
                            TextField("password", text: $password)
                                .textFieldStyle(PlainTextFieldStyle())
                                .cornerRadius(20)
                                .frame(height: 50)
                                .padding([.leading, .trailing], 20)
                                .foregroundColor(.gray)
                                .font(.system(size: 19))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                                .frame(height: 50)
                        })
                        .padding([.leading, .trailing], 40)
                        
                        HStack{
                            Spacer()
                            Button(action: {
                                self.loginViewModel.login(username: self.username, password: self.password)
                            }, label: {
                                Text("SIGN IN")
                                    .fontWeight(.bold)
                                    .frame(width: 300, height: 45, alignment: .center)
                            })
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .padding()
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
        .onAppear(){
            print("Login View appear")
            self.username = ""
            self.password = ""
        }
        .onDisappear(){
            print("Login View disappear")
        }
    }
    
    private func signInOnClick(){
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
