//
//  ContentView.swift
//  clean-architecture
//
//  Created by Danish Aziz on 2/4/2025.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = InterviewViewModel()
    @StateObject var settings = UserSettings()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world! \(viewModel.counter)")
            Button("Click") {
                viewModel.text = "Hello, World!"
                print("test")
                viewModel.counter += 1
            }.padding(.top)
            ProfileView().environmentObject(settings)
        }
        .padding()
        
        let task = Task {
            let test = NewTest()
            let data = try await test.getData()
            print(data)
        }
    }
}

#Preview {
    ContentView()
}


class InterviewViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var counter: Int = 0
}

struct ProfileView: View {
    
    @EnvironmentObject var settings: UserSettings  // Access shared object
    
    var body: some View {
        VStack {
            Text("Username: \(settings.username)").equatable()
            Button("Change Name") {
                settings.username = "John Doe"
                let task = Task {
                    await test()
                }
            }
        }
    }
    
    func test() async {
        do {
            let con = Concurrecny()
            async let data = try con.getData()
            
            let result = await data
            print(result)
        } catch {
            print("Error occurred: \(error)")
        }
    }
}

class UserSettings: ObservableObject {
    @Published var username: String = "Guest"
}


class Concurrecny: ObservableObject {
    
    func getData() async throws -> String {
        try await Task.sleep(nanoseconds: 100000000)
        return "data"
    }
}









class NewTest: ObservableObject {
    func getData() async throws -> String {
        do {
            try await Task.sleep(nanoseconds: 100000000)
        } catch {
            return "error"
        }
       
        return "Test"
    }
    
    
    func test() async throws {
        
        let test1 = try await getData()
        
        let result = test1
        
        
    }
}



















