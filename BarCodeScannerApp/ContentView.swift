//
//  ContentView.swift
//  BarCodeScannerApp
//
//  Created by Muhammad Zeshan on 10/07/2024.
//

import SwiftUI

struct ContentView: View {
    var items = ["Personal Information","Change Password","Transaction Pin","Members","Refer a Friend & Earn","Referal Points"]
    
    var body: some View {
        
           VStack{
                ZStack{
                    Image("bg")
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 150)
                    
                    VStack{
                        TopView().padding(.top, 20)
                        ProfileInfoView()
                    }
                    
                }
                List{
                    ForEach(items, id: \.self){item in
                        Text(item.description)
                        
                    }.padding()
                }
                
            }
    }
}

#Preview {
    ContentView()
}

struct TopView:View {
    var body: some View {
        HStack{
            Button{
                
            }label: {
                Image(systemName: "arrow.left")
            }
            .frame(width: 50,height: 50)
            .tint(Color(.label))
            
            Spacer()
            Text("Profile")
                .font(.title2)
            Spacer()
            Text("1")
                .hidden()
            Spacer()
        }.padding()
    }
}

struct ProfileInfoView:View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .padding()
            
            VStack(alignment: .leading) {
                Text("Muhammad Zeshan")
                    .font(.headline)
                Text("zeeshanbiit786@gmail.com")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Image(systemName: "qrcode")
                .resizable()
                .frame(width: 30,height: 30)
                .padding()
            
            
        }.padding()
        .background(Color(.white))
        .cornerRadius(10)
    }
}
