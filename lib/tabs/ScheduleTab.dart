import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medkitcare/styles/colors.dart';
import 'package:medkitcare/styles/styles.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({this.allowApproval = false, Key? key}) : super(key: key);

  final bool allowApproval;

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

enum FilterStatus {
  Pending,
  Approved,
}

class _ScheduleTabState extends State<ScheduleTab> {
  FilterStatus status = FilterStatus.Pending;
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Duty Schedule',
              textAlign: TextAlign.center,
              style: kTitleStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(MyColors.bg),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.Pending) {
                                  status = FilterStatus.Pending;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.Approved) {
                                  status = FilterStatus.Approved;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                filterStatus.name,
                                style: kFilterStyle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: Duration(milliseconds: 200),
                  alignment: _alignment,
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: status == FilterStatus.Pending
                    ? FirebaseFirestore.instance
                        .collection("schedule")
                        .where("reserved", isEqualTo: true)
                        .where("approved", isEqualTo: false)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection("schedule")
                        .where("approved", isEqualTo: true)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data?.docs ?? [];

                    if (data.length == 0) {
                      return const Center(child: Text("Nothing at the moment"));
                    }

                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var _schedule = List.from(data)[index];
                        bool isLastElement = data.length + 1 == index;
                        return Card(
                          margin: !isLastElement
                              ? EdgeInsets.only(bottom: 20)
                              : EdgeInsets.zero,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _schedule['doctor_name'],
                                          style: TextStyle(
                                            color: Color(MyColors.header01),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Doctor",
                                          style: TextStyle(
                                            color: Color(MyColors.grey02),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                DateTimeCard(
                                  date: DateTime.tryParse(_schedule["date"]) ??
                                      DateTime.now(),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                if (status == FilterStatus.Pending)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Color(MyColors.bg)),
                                        ),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("schedule")
                                              .doc(_schedule.id)
                                              .set({
                                            "approved": false,
                                            "reserved": false
                                          }, SetOptions(merge: true));
                                        },
                                      ),
                                    ),
                                    if (widget.allowApproval) ...[
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: MaterialButton(
                                          color: Color(MyColors.bg),
                                          child: Text(
                                            'Approve',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection("schedule")
                                                .doc(_schedule.id)
                                                .set({
                                              "approved": true,
                                              "reserved": true
                                            }, SetOptions(merge: true));
                                          },
                                        ),
                                      )
                                    ]
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("An error occurred"),
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  const DateTimeCard({
    required this.date,
    this.period = "Morning",
    Key? key,
  }) : super(key: key);

  final DateTime date;
  final String period;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                DateFormat("yMMMd").format(date),
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: Color(MyColors.primary),
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                period,
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
