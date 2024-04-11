//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 08/02/24.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    let service = WebService()
    let authManager = AuthenticationManager.shared
    @State private var appointments: [Appointment] = []
    
    func getAllAppointments() async {
        guard let patientID = authManager.patientiID else {
            print("Erro ao obter patient-id")
            return
        }
        
        do {
            if let appointments = try await service.getAllAppointmentsFromPatient(patientID: patientID) {
                self.appointments = appointments
            }
        } catch {
            print("Error on getAllAppointments: \(error)")
        }
        
        
    }
    
    var body: some View {
        VStack {
            if (appointments.isEmpty) {
                Text("Não há nenhuma consulta agendada no momento!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.cancel)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(appointments) { appointment in
                        SpecialistCardView(specialist: appointment.specialist, appointment: appointment)
                    }
                }
            }
        }
        .navigationTitle("Minhas consultas")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .onAppear() {
            Task {
                await getAllAppointments()
            }
        }
    }
}

#Preview {
    MyAppointmentsView()
}
