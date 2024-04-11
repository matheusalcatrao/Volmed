//
//  SignUpView.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 19/02/24.
//

import SwiftUI

struct SignUpView: View {
    let service = WebService()
    
    @State private var name = ""
    @State private var email = ""
    @State private var cpf = ""
    @State private var phoneNumber = ""
    @State private var healthPlan: String
    @State private var password = ""
    @State private var isPatientRegister = false
    @State private var showAlert = false
    @State private var navigateToSignInView = false
    
    let healthPlans: [String] = [
    "Amil", "Unimed", "Bradesco Saúde", "SulAmérica", "Hapvida", "Notredame Intermédica", "São Francisco Saúde", "Golden Cross", "Medial Saúde", "América Saúde", "Outro"
    ]
    
    init() {
        self.healthPlan = healthPlans[0]
    }
    
    func register() async {
        do {
            let patient = Patient(id: nil, cpf: cpf, name: name, email: email, password: password, phoneNumber: phoneNumber, healthPlan: healthPlan)
            
            if let _ = try await service.registerPatient(patient: patient) {
                print("Paciente foi cadastrado com sucesso!")
                isPatientRegister = true
            }
            
        } catch {
            print("Ocorreu um erro ao cadastrar paciente: \(error)")
            isPatientRegister = false
        }
        showAlert = true
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16.0) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 36, alignment: .center)
                    .padding(.vertical)
                
                Text("Olá, boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
                Text("Insira seus dados para criar uma conta.")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                Text("Nome")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                TextFieldView(placeholder: "Insira seu nome completo", text: $name)
                
                Text("Email")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                TextFieldView(placeholder: "Insira seu email", text: $email)
                
                Text("CPF")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                TextFieldView(placeholder: "Insira seu CPF", text: $cpf)
                    .keyboardType(.numberPad)
                
                Text("Telefone")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                TextFieldView(placeholder: "Insira seu telefone", text: $phoneNumber)
                    .keyboardType(.numberPad)
                
                Text("Senha")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                TextFieldView(placeholder:"Insira sua senha", isSecureField: true, text: $password)
                
                Text("Selecione o seu plano de saúde")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                Picker("", selection: $healthPlan) {
                    ForEach(healthPlans, id: \.self) { healthPlan in
                        Text(healthPlan)
                    }
                }
                
                Button(action: {
                    Task {
                        await register()
                    }
                }, label: {
                    ButtonView(text: "Cadastrar")
                })
                NavigationLink{
                    SignInView()
                } label: {
                    Text("Já possui uma conta? Faça o login!")
                        .bold()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                }
                    
            }
        }
        .navigationBarBackButtonHidden()
        .padding()
        .alert(isPatientRegister ? "Sucesso!" : "Ops, algo deu errado!", isPresented: $showAlert, presenting: $isPatientRegister) { _ in
            Button(action: {
                navigateToSignInView = true
            }, label: {
                Text("OK")
            })
        } message: { _ in
            if isPatientRegister {
                Text("O paciente foi criado com sucesso!")
            } else {
                Text("Houve um erro ao cadastrar o paciente. Por favor tente novamente mais tarde.")
            }
        }
        .navigationDestination(isPresented: $navigateToSignInView, destination: {
            SignInView()
        })
    }
}

#Preview {
    SignUpView()
}
