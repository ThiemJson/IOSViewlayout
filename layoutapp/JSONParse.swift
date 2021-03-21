//
//  JSONParse.swift
//  layoutapp
//
//  Created by Thiem Jason on 3/22/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct JSONParse: View {
    @State private var showSheet = false
    @ObservedObject var getData = datas()
    var body: some View {
        print("render Root View")
        return NavigationView{
            List(getData.jsonData){
                data in
                ListRow(url: data.avatar_url , name: data.login, showSheet: $showSheet)
            }
            .navigationBarTitle("JSON Parsing")
        }
        
        .sheet(isPresented: $showSheet, content: {
            NavigationView{
                List(getData.jsonData){
                    data in
                    ListRow(url: data.avatar_url , name: data.login, showSheet: $showSheet)
                }
                .navigationBarTitle("JSON Parsing")
            }
        })
        
        .onAppear(){
            print("RootView on appear")
        }
    }
}

struct JSONParse_Previews: PreviewProvider {
    static var previews: some View {
        JSONParse()
    }
}

class datas : ObservableObject {
    @Published var jsonData = [dataType]()
    
    init() {
        guard let url = URL(string: "https://api.github.com/users") else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, _, _) in
            do {
                let fetch = try JSONDecoder().decode([dataType].self, from: data!)
                DispatchQueue.main.async {
                    self.jsonData = fetch
                }
            }
            catch{
                print("error trigger")
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

struct dataType: Identifiable, Decodable {
    let id: Int
    let login: String
    let node_id: String
    let avatar_url: String
}

struct ListRow : View {
    let url: String
    let name: String
    @Binding var showSheet : Bool
    
    var body: some View {
        HStack {
            AnimatedImage(url: URL(string: url))
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .shadow(radius: 20)
            Text(name)
                .fontWeight(.heavy)
                .padding(.leading,10)
            Spacer()
            Image(systemName: "message")
                .foregroundColor(.primary)
                .clipShape(Circle()).onTapGesture {
                    self.showSheet.toggle()
                }
        }
    }
}
