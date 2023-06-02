import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user!.isAnonymous) {
      // User is not logged in, show login screen or redirect to login page
      // You can customize this part according to your app's authentication flow
      return Center(
        child: Text('Please log in to view account information'),
      );
    } else {
      // User is logged in, fetch and display account information
      return Scaffold(
        // appBar: AppBar(
        //   title: Text('Account Info'),
        // ),
        body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('Users')
              .doc(user.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching user data'));
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text('User data not found'));
            }

            final userData = snapshot.data!.data() as Map<String, dynamic>;

            final email = userData['email'] ?? '';
            final name = userData['name'] ?? '';
            // final age = userData['age'] ?? '';

            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(210, 214, 132, 17),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Information',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Email: $email',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Name: $name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        // Text(
                        //   'Age: $age',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 16.0,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}