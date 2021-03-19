import SwiftUI

// Our observable object class
class Person: ObservableObject {
    @Published var age = 0
}


struct ContentView : View {
    var body: some View{
        let person = Person()
        return RootView(person: person)
    }
}

struct RootView: View {
    @StateObject var person : Person
    
    var body: some View {
        TabView(selection: .constant(2),
                content:  {
                    DemoView(screenName: "Home")
                        .tabItem {
                            Image.init(systemName: "star.fill")
                            Text("Home")
                        }.tag(1)
                    DemoView( screenName: "Result")
                        .tabItem {
                            Image.init(systemName: "star.fill")
                            Text("Result")
                        }.tag(2)
                    DemoView(screenName: "More")
                        .tabItem {
                            Image.init(systemName: "star.fill")
                            Text("More")
                        }.tag(3)
                })
            .environmentObject(person)
    }
}

struct DemoView1 : View {
    @EnvironmentObject var person : Person
    var body: some View {
        VStack{
            Text("In demoview1 \(person.age)")
        }
        .onAppear(){
            print("==> \(person.age)")
        }
    }
    
}

struct DemoView:View {
    @EnvironmentObject var person : Person
    @State var text:String = ""
    var screenName:String
    var body: some View {
        VStack{
            Text(screenName)
                .font(.title)
            
            TextField("Buggy Keyboard Issue \(person.age)", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            DemoView1()
        }
        .padding()
        .onAppear(perform: {
            debugPrint("OnAppear of : \(screenName)")
        })
    }
}
