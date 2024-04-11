//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 06/02/24.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    var specialistID: String
    let service = WebService()
    var isRescheduleView: Bool
    var appointmentID: String?
    var authManager = AuthenticationManager.shared
    
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var isAppointmentScheduled = false
    @Environment(\.presentationMode) var presentationMode
    
    
    init (specialistID: String, isRescheduleView: Bool = false, appointmentID: String? = nil) {
        self.specialistID = specialistID
        self.isRescheduleView = isRescheduleView
        self.appointmentID = appointmentID
    }
    
    func rescheduleAppointment() async {
        guard let appointmentID else {
            print("Houve um erro ao obter o ID da cinsulta")
            return
        }
        do {
            if let _ = try await service.rescheduleAppointment(appointmentID: appointmentID, date: selectedDate.convertToString()) {
                isAppointmentScheduled = true
            } else {
                isAppointmentScheduled = false
            }
        } catch {
            isAppointmentScheduled = false
            print("Ocorreu um erro ao reagendar: \(error)")
        }
        showAlert = true
    }
    
    func scheduleAppointment() async {
        guard let patientID = authManager.patientiID else {
            print("Erro ao obter patient-id")
            return
        }
        do {
            if let _ = try await service.scheduleAppointment(
                specialistID: specialistID,
                patientID: patientID,
                date: selectedDate.convertToString()) {
                isAppointmentScheduled = true
            } else {
                isAppointmentScheduled = false
            }
        } catch {
            isAppointmentScheduled = false
            print("Ocorreu um erro ao agendar: \(error)")
            
        }
        showAlert = true
    }
    
    var body: some View {
        VStack {
            Text("Selecione a data e o horário da consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            DatePicker("Escolha a data da consulta", selection: $selectedDate)
                .datePickerStyle(.graphical)
            Button(action: {
                Task {
                    if isRescheduleView {
                        await rescheduleAppointment()
                        return
                    }
                    await scheduleAppointment()
                }
            }, label: {
                ButtonView(text: isRescheduleView ? "Reagendar" :"Agendar consulta")
                
            })
        }
        .padding()
        .navigationTitle(isRescheduleView ? "Reagendar" :"Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear() {
            UIDatePicker.appearance().minuteInterval = 15
        }
        .alert(isAppointmentScheduled ? "Sucesso" : "Ops, algo deu errado", isPresented: $showAlert, presenting: isAppointmentScheduled) { _ in
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Ok")
            })
        } message: { isScheduled in
            if isScheduled {
                Text("A consulta foi \(isRescheduleView ? "reagendada" : "agendada")  com sucesso")
            } else {
                Text("Deu um erro ao \(isRescheduleView ? "reagendada" : "agendada") sua consulta.")
            }
        }
        
    }
}

#Preview {
    ScheduleAppointmentView(specialistID: "123")
}
