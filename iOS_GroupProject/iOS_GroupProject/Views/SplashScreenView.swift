//
//  SplashScreenView.swift
//  iOS_GroupProject
//
//  Created by Thang Do Quang on 21/09/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State var startAnimating = false
    @State var bowAnimation = false
    @State var glow = false
    @State var isFinished = false
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        HStack {
            if !isFinished {
                ZStack{
                    Color("Color2")
                        .ignoresSafeArea()
                    
                    GeometryReader{proxy in
                        let size = proxy.size
                        
                        ZStack{
                            VStack (spacing: -60){
                                ZStack{
                                    Circle()
                                        .trim(from: 0, to: bowAnimation ? 0.5 : 0)
                                        .stroke(
                                            .linearGradient(.init(colors: [
                                                Color("Color2"),
                                                Color("Color3"),
                                                Color("Color1"),
                                                Color("Color4"),
                                                Color("Color2")
                                            ]), startPoint: .leading, endPoint:.trailing)
                                            ,style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round
                                            )
                                        )
                                        .overlay(
                                            Circle()
                                                .fill(Color(.white).opacity(0.4))
                                                .frame(width: 6, height: 6)
                                                .overlay(
                                                    Circle()
                                                        .fill(Color(.white).opacity(glow ? 0.2 : 0.1))
                                                        .frame(width: 20, height: 20)
                                                )
                                                .blur(radius: 2.5)
                                                .offset(x: (size.width / 2) / 2)
                                                .rotationEffect(.init(degrees: bowAnimation ? 180 : 0))
                                                .opacity(startAnimating ? 1 : 0)
                                        )
                                        .frame(width: size.width / 2, height: size.width / 2)
                                        .rotationEffect(.init(degrees: -200))
                                        .offset(y: 10)
                                    
                                    Image("Logo")
                                        .renderingMode(.template)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: size.width / 1.9, height: size.width / 1.9)
                                        .opacity(bowAnimation ? 1: 0)
                                }
                                Image("name")
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: size.width / 1.9, height: size.width / 1.9)
                            }

                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                                withAnimation(.linear(duration: 2)){
                                    bowAnimation.toggle()
                                }
                                
                                withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
                                    glow.toggle()
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                    withAnimation(.spring()) {
                                        startAnimating.toggle()
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                        withAnimation {
                                            isFinished.toggle()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }
}
