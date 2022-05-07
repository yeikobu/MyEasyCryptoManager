//
//  DonateView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 06-05-22.
//

import SwiftUI

struct DonateView: View {
    
    @StateObject var donateViewModel = DonateViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Namespace var animation
    @State var isWalletButtonPressed: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    
                    Spacer()
                    
                    Text("Donate")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    //MARK: - Why donate stack
                    VStack(alignment: .leading) {
                        Text("\(donateViewModel.donateModel.whyDonate)")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                        
                        Text("\(donateViewModel.donateModel.whyDonateParagraph)")
                            .font(.system(size: 12, design: .rounded))
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .blur(radius: 0)
                            .opacity(0.8)
                    )
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                    .foregroundColor(.white)
                    
                    //MARK: - How to donate stack
                    VStack(alignment: .leading) {
                        Text("\(donateViewModel.donateModel.howToDonate)")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                        
                        HStack {
                            Text("\(donateViewModel.donateModel.howToDonateImportant) ")
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                            
                            Text("\(donateViewModel.donateModel.howToDonateImportantParagraph)")
                                .font(.system(size: 12, design: .rounded))
                        }
                        
                        Text("\(donateViewModel.donateModel.donatesBNBSmartChain)")
                            .font(.system(size: 12, design: .rounded))
                        
                        //MARK: - Button with wallet direction
                        VStack(alignment: .leading) {
                            Button {
                                withAnimation(.spring()) {
                                    self.isWalletButtonPressed = true
                                    self.donateViewModel.copyToClipboard()
                                }
                            } label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(donateViewModel.donateModel.walletDirectionTitle)")
                                            .font(.system(size: 12, design: .rounded))
                                            .padding(.bottom, 0)
                                        
                                        Text("\(donateViewModel.donateModel.walletDirection)")
                                            .font(.system(size: 11, design: .rounded))
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Image(systemName: !isWalletButtonPressed ? "doc.on.clipboard" : "doc.on.clipboard")
                                            .font(.system(size: 11, design: .rounded))
                                            .shadow(color: .black.opacity(0.2), radius: 2, x: 3, y: 3)
                                            .shadow(color: .black.opacity(0.2), radius: 2, x: -3, y: -3)
                                        
                                        Text(!isWalletButtonPressed ? "Copy" : "Copied!")
                                            .font(.system(size: 10, weight: .bold, design: .rounded))
                                            .shadow(color: .black.opacity(0.4), radius: 2, x: 3, y: 3)
                                            .shadow(color: .black.opacity(0.4), radius: 2, x: -3, y: -3)
                                    }
                                    .foregroundColor(!isWalletButtonPressed ? Color("Buttons") : .yellow)
                                    
                                }
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.ultraThinMaterial)
                                        .blur(radius: 0.5)
                                        .opacity(0.7)
                                )
                                .shadow(color: .black.opacity(0.2), radius: 2, x: 3, y: 3)
                                .shadow(color: .black.opacity(0.2), radius: 2, x: -3, y: -3)
                            }
                        }
                        
                        

                    
                        
                        
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .blur(radius: 0)
                            .opacity(0.8)
                    )
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                    .foregroundColor(.white)
                }
                
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 50)
            
            
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .padding(6)
                    .foregroundColor(Color("Buttons"))
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                            .blur(radius: 0)
                            .opacity(0.8)
                    )
            }
            .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
            .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
            .padding(.top, 50)
            .padding(.trailing, 10)
        }
        .ignoresSafeArea()
        .frame(maxHeight: .infinity)
        .background(
            Image("wallpaper2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.4)
        )
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}
