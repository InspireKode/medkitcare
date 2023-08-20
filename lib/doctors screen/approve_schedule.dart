import 'package:flutter/material.dart';

class Appointment {
  final String patientName;
  final DateTime appointmentTime;
  bool approved;

  Appointment({
    required this.patientName,
    required this.appointmentTime,
    this.approved = false,
  });
}

class DoctorApp extends StatelessWidget {
  final String doctorName;
  final List<Appointment> appointments;

  DoctorApp({required this.doctorName, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Approval for: - $doctorName'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(appointments[index].patientName),
            subtitle: Text(
                'Appointment Time: ${appointments[index].appointmentTime}'),
            trailing: appointments[index].approved
                ? Icon(Icons.check_circle, color: Colors.green)
                : ElevatedButton(
                    onPressed: () {
                      appointments[index].approved = true;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Appointment Approved'),
                            content: Text('The appointment has been approved.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Approve'),
                  ),
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final List<Appointment> doctorAppointments = [
    Appointment(
        patientName: 'Patient 1',
        appointmentTime: DateTime.now().add(Duration(days: 1))),
    Appointment(
        patientName: 'Patient 2',
        appointmentTime: DateTime.now().add(Duration(days: 2))),
    Appointment(
        patientName: 'Patient 3',
        appointmentTime: DateTime.now().add(Duration(days: 3))),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor App',
      home:
          DoctorApp(doctorName: 'Dr. Smith', appointments: doctorAppointments),
    );
  }
}
