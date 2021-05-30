//
//  ContentView.swift
//  DatingAppUI
//
//  Created by Neha on 24/05/21.
//

import SwiftUI

struct ContentView: View {
    @State var profile_data = [
        Profile(id: 0, name: "Katy", image: "p2", age: 33, offset: 0),
        Profile(id: 1, name: "Klara", image: "p", age: 34, offset: 0),
        Profile(id: 2, name: "Grace", image: "p2", age: 18, offset: 0),
        Profile(id: 3, name: "Stephnie", image: "p", age: 29, offset: 0),
        Profile(id: 4, name: "Cassie", image: "p2", age: 32, offset: 0),
        Profile(id: 5, name: "Abigail", image: "p", age: 30, offset: 0),
        Profile(id: 6, name: "Marth", image: "p2", age: 37, offset: 0)
    ]

    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Button(action: {}) {
                    Image(systemName: "square.grid.2x2")
                        .renderingMode(.template)
                    
                }
                Text("Blind Dating")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "bell")
                        .renderingMode(.template)
                }
                
            }
            .foregroundColor(.black)
            .padding()
            
            GeometryReader { g in
                ZStack {
                    ForEach(profile_data.reversed()) { profile in
                    
                        ProfileView(profile: profile, frame: g.frame(in: .local))
                    }
                }
            }
            .padding([.horizontal,.bottom])
            
            Spacer(minLength: 0)
        }
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ProfileView: View {
    @State var profile: Profile
    @State var frame: CGRect
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom )) {
            Image(profile.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: frame.width, height: frame.height)
            //
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                (profile.offset > 0 ? Color.green : Color.red)
                    .opacity(profile.offset != 0 ? 0.7 : 0)
                HStack {
                    if profile.offset < 0 {
                        Spacer(minLength: 0)
                    }
                    Text(profile.offset == 0 ? "" : (profile.offset > 0 ? "Liked" : "Rejected"))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top,25)
                        .padding(.horizontal)
                    if profile.offset > 0 {
                        Spacer(minLength: 0)
                    }
                }
            }
            
            LinearGradient(gradient: .init(colors: [Color.black.opacity(0.2), Color.black.opacity(0.6)]), startPoint: .center, endPoint: .bottom)
            
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(profile.name)
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                        
                        Text("\(profile.age)+" )
                            .fontWeight(.bold)
                        
                    }
                    .foregroundColor(.white)
                    Spacer(minLength: 0)
                    
                }
                
                HStack(spacing: 30) {
                    Spacer(minLength: 0)
                    Button(action: {
                        withAnimation(Animation.easeIn(duration: 0.8)) {
                            profile.offset = -500
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                    Button(action: {
                        withAnimation(Animation.easeIn(duration: 0.8)) {
                            profile.offset = 500
                        }
                    }) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                    Spacer(minLength: 0)
                }
               
            }
            .padding()
        }
        .cornerRadius(30)
        .offset(x: profile.offset)
        .rotationEffect(.init(degrees: profile.offset == 0 ? 0 : (profile.offset > 0 ? 12 : -12)))
        .gesture(
            DragGesture()
                .onChanged({ value in
                    withAnimation(.default) {
                        profile.offset = value.translation.width
                    }
                })
                .onEnded({ value in
                    withAnimation(.easeIn) {
                        if profile.offset > 150 {
                            profile.offset = 500
                        }
                        else if profile.offset < -150 {
                            profile.offset = -500
                        }
                        else {
                            profile.offset = 0
                        }
                    }
                 })
            
        )
    }
}

struct Profile: Identifiable {
    var id: Int
    var name: String
    var image: String
    var age: Int
    var offset: CGFloat
}

