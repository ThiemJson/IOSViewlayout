import SwiftUI

// Our observable object class
class Person: ObservableObject {
    @Published var age = 0
}


struct ContentView : View {
    var body: some View{
        let person = Person()
        return DaddyOfRootView(person: person)
    }
}

struct DaddyOfRootView: View {
    var person : Person;
    var body: some View {
        let demoPerson = Person()
        demoPerson.age = 30
        return RootView(person: demoPerson)
            .environmentObject(person)
    }
}

struct RootView: View {
   var person : Person
    
    var body: some View {
        print("==> render RootView")
        return TabView(selection: .constant(8),
                       content:{
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
    @State var text:String = ""
    var screenName: String
    var body: some View {
        print("==> render \(self.screenName) person: \(person.age)")
        return VStack{
            Text("In demoview1 \(self.person.age)")
            TextField("Buggy Keyboard Issue \(person.age)", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                person.age = Int(text)!
            }, label: {
                Text("Change enviroment")
            })
        }
        .onAppear(){
            text = String(person.age)
            debugPrint("OnAppear of : \(screenName)")
        }
        .onDisappear(perform: {
            debugPrint("onDisappear of : \(screenName)")
        })
    }
    
}

struct DemoView:View {
    @EnvironmentObject var person : Person
    var screenName:String
    var body: some View {
        VStack{
            Text(screenName)
                .font(.title)
            DemoView1(screenName: screenName)
        }
        .padding()
    }
}
