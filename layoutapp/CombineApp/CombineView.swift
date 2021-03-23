//
//  CombineView.swift
//  layoutapp
//
//  Created by Thiem Jason on 3/22/21.
//

import SwiftUI

struct CombineView: View {
    @StateObject private var combineViewModel = CombineViewModel()
    var body: some View {
        return ScrollView{
            Button(action: {
                self.combineViewModel.startFetch()
            }){
                Text("Fetch data")
                    .foregroundColor(.gray)
            }
            Text(self.combineViewModel.time)
        }
        .padding()
        .font(.system(size: 36, weight: .bold))
    }
}

struct CombineView_Previews: PreviewProvider {
    static var previews: some View {
        CombineView()
    }
}
