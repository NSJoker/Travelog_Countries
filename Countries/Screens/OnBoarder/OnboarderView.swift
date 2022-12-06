//
//  OnboarderView.swift
//  Countries
//
//  Created by Chandrachudh K on 04/12/22.
//

import SwiftUI

struct OnboarderView: View {
    
    @ObservedObject var onBoaderViewModel: OnBoaderViewModel
    @State private var currentStep: Int = 0
    
    private let imageSize: CGFloat = SCREEN_WIDTH*3/4
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                // MARK: Skip Button
                if currentStep != self.onBoaderViewModel.onBoardingSteps.count - 1 {
                    Button {
                        self.currentStep = self.onBoaderViewModel.onBoardingSteps.count - 1
                    } label: {
                        Text("Skip")
                            .padding(16)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            // MARK: TabView to Change the views
            TabView(selection: self.$currentStep) {
                ForEach(0..<self.onBoaderViewModel.onBoardingSteps.count, id: \.self) { step in
                    VStack {
                        Image(self.onBoaderViewModel.onBoardingSteps[step].image)
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                        
                        Text(self.onBoaderViewModel.onBoardingSteps[step].title)
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.center)
                        
                        Text(self.onBoaderViewModel.onBoardingSteps[step].description)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                            .padding(.top, 16)
                    }
                    .tag(step)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // MARK: Pagination indicator
            HStack {
                ForEach(0..<self.onBoaderViewModel.onBoardingSteps.count, id: \.self) { step in
                    if step == currentStep {
                        Rectangle()
                            .frame(width: 20, height: 10)
                            .cornerRadius(10)
                            .foregroundColor(.onboarding)
                    } else {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.bottom, 24)
            
            // MARK: Bottom Button
            Button {
                if self.currentStep < self.onBoaderViewModel.onBoardingSteps.count - 1 {
                    withAnimation(.easeIn(duration: 0.25)) {
                        self.currentStep += 1
                    }
                } else {
                    // Get Started logic
                    self.onBoaderViewModel.getStarted()
                }
            } label: {
                Text(currentStep < self.onBoaderViewModel.onBoardingSteps.count - 1 ? "Next" : "Get Started")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.onboarding)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                    .foregroundColor(.black)
            }
            .buttonStyle(.plain)

        }
    }
}

struct OnboarderView_Previews: PreviewProvider {
    static var previews: some View {
        OnboarderView(onBoaderViewModel: .init())
    }
}
