import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OpenSchedule extends StatefulWidget {
  const OpenSchedule({this.allowBooking = false, super.key});

  final bool allowBooking;

  static String uri = '/open-schedules';

  @override
  State<OpenSchedule> createState() => _OpenScheduleState();
}

class _OpenScheduleState extends State<OpenSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Active Doctors")),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("schedule")
              .where("reserved", isEqualTo: false)
              .where("date",
                  isEqualTo: DateFormat('yyyy-MM-dd').format(DateTime.now()))
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return (snapshot.data?.docs ?? []).isNotEmpty
                  ? ListView(
                      children: [
                        for (final data in snapshot.data?.docs ?? [])
                          ListTile(
                            title: Text(
                                data.data()["doctor_name"] ?? "Doctor's name"),
                            subtitle: Text(
                                "${data.data()["duty"]} ${data.data()["date"]}"),
                            trailing: widget.allowBooking
                                ? TextButton(
                                    child: const Text("Book"),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("schedule")
                                          .doc(data.id)
                                          .set({"reserved": true},
                                              SetOptions(merge: true));
                                    },
                                  )
                                : null,
                          )
                      ],
                    )
                  : const Center(child: Text("No doctor is available today"));
            }

            if (snapshot.hasError) {
              return const Center(child: Text("An error occurred"));
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
