//
//  SplashView.swift
//  IOS_Demo_SwiftUI
//

import SwiftUI

struct SplashView: View {
    
    @State private var isPresented: Bool = false
    var body: some View {
        ZStack {
            if isPresented {
                ContentView()
            } else {
                VStack{
                    Spacer()
                    Text("IOS Test SWIFTUI")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Text("By Rahul Patni")
                        .font(.largeTitle)
                }.padding(.all, 10)
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation{
                    self.isPresented = true
                }
            }
        })
    }
}

#Preview {
    SplashView()
}
