//
//  SplashView.swift
//  layoutapp
//
//  Created by Thiem Jason on 3/24/21.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        Text("WAITING !!!")
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .font(.system(size: 30))
        
            .onAppear(){
                print("SplashView appear")
            }
            .onDisappear(){
                print("SplashView disappear")
            }
        
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
