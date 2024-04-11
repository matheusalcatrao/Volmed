//
//  SignInView.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 19/02/24.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var isLoading: Bool = false
    
    var authManager = AuthenticationManager.shared
    
    let service = WebService()

    func login() async {
        do {
            isLoading = true
            if let response = try await service.loginPatient(email: email, password: password) {
                authManager.saveToken(token: response.token)
                authManager.savePatinetID(id: response.id) 
            } else {
                showAlert = true
            }
        } catch {
           
            showAlert = true
            print("Ocorreu um erro no login: \(error)")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isLoading = false
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 36, alignment: .center)
            Text("Olá!")
                .font(.title2)
                .bold()
                .foregroundStyle(.accent)
            Text("Preencha para acessar sua conta.")
                .font(.title3)
                .foregroundStyle(.gray)
                .padding(.bottom)
            Text("Email")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            TextField("Insira seu email", text: $email)
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
            Text("Senha")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            SecureField("Insira sua senha", text: $password)
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            Button(action: {
                //
                Task {
                    await login()
                }
            }, label: {
                ButtonView(text: "Entrar", buttonType: .primary)
            })
            NavigationLink{
                SignUpView()
            } label: {
                Text("Ainda não possui uma conta? Cadastre-se")
                    .bold()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Ops!, algo deu errado"),
                message: Text("Houve algo de errado, tente novamente mais tarde."),
                dismissButton: .default(Text("OK"))
            )
        }
        .springLoadingBehavior(.enabled)
        .fullScreenCover(isPresented: $isLoading) {
            LoadingView()
        }
    }
}

#Preview {
    SignInView()
}
