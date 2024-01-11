//
//  SignInView.swift
//  ReFix
//
//  Created by Ivan Laptii on 11.01.2024.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack {
            appLogo
            signInTextFieldForm
            forgotPasswordButton
            unregisteredButton
            Spacer()
            signInButton
            Spacer()
        }
        .onTapGesture {
            isFocused = false
        }
    }
}

extension SignInView {
    var appLogo: some View {
        Image("AppLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 80)
            .padding(.top, 150)
    }
    
    var signInTextFieldForm: some View {
        VStack {
            Form {
                customTextFieldWithIcon(icon: "envelope.fill",
                    placeholder: "Пошта",
                    text: $viewModel.email
                )
                customTextFieldWithIcon(
                    icon: "lock.fill",
                    placeholder: "Пароль",
                    text: $viewModel.password
                )
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .frame(minHeight: 130, maxHeight: 150)
            .padding(.top, 100)
        }
    }
    
    func customTextFieldWithIcon(icon: String, placeholder: String, text: Binding<String>) -> some View {
        HStack(alignment: .center) {
            Image(systemName: icon)
                .frame(width: 30)
            customTextField(placeholder: placeholder, text: text)
        }
    }
    
    func customTextField(placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .focused($isFocused)
            .modifier(ClearButtonViewModifier(text: text))
    }
    
    var forgotPasswordButton: some View {
        Button("Забули пароль?") {
            //TODO: navigation to forgot password
        }
    }
    
    var unregisteredButton: some View {
        Button("Ще не зареєстровані?") {
            withAnimation {
                viewModel.authState = .signUp
            }
        }
        .padding(10)
        .buttonStyle(.borderless)
    }
    
    var signInButton: some View {
        Button ("Увійти") {
        }
        .padding(10)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    SignInView()
        .environmentObject(AuthViewModel())
}
