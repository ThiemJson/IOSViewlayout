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
        return GeometryReader{ reader in
            VStack{
                Button(action: {
                    //                self.combineViewModel.startFetch()
                    self.combineViewModel.startFetchModel()
                    print("Size of CombineView: width - \(reader.size.width) \n height - \(reader.size.height)")
                    
                }){
                    Text("Fetch data")
                        .foregroundColor(.gray)
                }
                .frame(width: reader.size.width * 0.5, height: reader.size.height * 0.1)
                
                Text(self.combineViewModel.time)
                
                HStack{
                    GeometryReader{
                        smallReader in
                        Button {
                            //                            print("Size of CombineView: width - \(smallReader.size.width) \n height - \(smallReader.size.height)")
                            self.combineViewModel.startFetchModel()
                        } label: {
                            Text("button nested")
                        }
                        
                        Text(self.combineViewModel.timeModel.second.description)
                            .foregroundColor(.red)
                            .position(x: smallReader.size.width * 0.5, y: smallReader.size.height * 0.5)
                    }
                }
                .frame(width: reader.size.width * 0.5, height: reader.size.height * 0.3)
                .background(Color(.gray))
                .padding()
                
                Spacer()
            }
        }
        .padding()
        .font(.system(size: 36, weight: .bold))
        //        .background(Color(.yellow))
        //        .onReceive(self.combineViewModel.$seconds) { (outputValuee) in
        //            print("Second: \(outputValuee)")
        //        }
        //        .onReceive(self.combineViewModel.$time) { (outputValuee) in
        //            print("Time: \(outputValuee)")
        //        }
    }
}

struct CombineView_Previews: PreviewProvider {
    static var previews: some View {
        CombineView()
    }
}
