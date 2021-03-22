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
        Button(action: {
            self.combineViewModel.startFetch()
        }){
            Text("Fetch data")
                .foregroundColor(.gray)
        }
        
        
        .onReceive(self.combineViewModel.objectWillChange) { (value) in
            print("==> \(value)")
        }
    }
}

struct CombineView_Previews: PreviewProvider {
    static var previews: some View {
        CombineView()
    }
}
