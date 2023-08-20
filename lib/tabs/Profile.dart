import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User _user;
  late Map<String, dynamic> _userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    _user = _auth.currentUser!;
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(_user.uid).get();
    _userData = userSnapshot.data() as Map<String, dynamic>;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: _userData != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(_userData['profileImage']),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Name: ${_userData['name']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Email: ${_user.email}'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Perform logout
                      _auth.signOut();
                      Navigator.pop(context);
                    },
                    child: Text('Logout'),
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
