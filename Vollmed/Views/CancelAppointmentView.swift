//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 09/02/24.
//

import SwiftUI

struct CancelAppointmentView: View {
    
    var appointmentID: String
    
    @State private var reasonToCancel = ""
    @State private var showAlert = false
    @State private var cancelAppointment = false
    @Environment(\.presentationMode) var presentationMode
    let service = WebService()
    
    func cancelAppointment() async {
        do {
            if try await service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel) {
                print("Consulta cancelada com sucesso")
                cancelAppointment = true
            }
        } catch {
            print("Erro ao desmarcar consulta: \(error)")
            cancelAppointment = false
        }
        showAlert = true
    }
    
    func goBackPage() {
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Conte-nos o motivo do cancelamento da sua consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $reasonToCancel)
                .padding()
                .font(.title3)
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.lightBlue).opacity(0.15))
                .cornerRadius(16)
                .frame(maxHeight: 300)
            
            Button(action: {
                Task {
                    await cancelAppointment()
                }
            }, label: {
                ButtonView(text: "Cancelar consulta", buttonType: .cancel)
            })
        }
        .padding()
        .navigationTitle("Cancelar consulta")
        .navigationBarTitleDisplayMode(.large)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(cancelAppointment ? "Sucesso!" : "Ops, algo deu errado!"),
                message: Text(cancelAppointment ? "A consulta foi cancelada com sucesso." : "Houve um erro ao cancelar sua consulta. Por favor tente novamente ou entre em contato via telefone."),
                dismissButton: .default(
                    Text("OK"),
                    action: goBackPage
                )
            )
        }
    }
}

#Preview {
    CancelAppointmentView(appointmentID: "123")
}
