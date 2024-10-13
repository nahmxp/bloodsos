import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'edit_info_screen.dart';
import 'request_blood_screen.dart';
import 'distress_call_screen.dart';
import 'map_screen.dart';
import 'api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation App',
      home: SignInScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/edit': (context) => EditInfoScreen(),
        '/requestBlood': (context) => RequestBloodScreen(),
        '/distressCall': (context) => DistressCallScreen(),
        '/map': (context) => MapScreen(),
      },
    );
  }
}

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Center(
        child: ElevatedButton(
          child: Text('Sign In'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ListView(
        children: [
          ListTile(title: Text('Edit Info'), onTap: () => Navigator.pushNamed(context, '/edit')),
          ListTile(title: Text('Request Blood'), onTap: () => Navigator.pushNamed(context, '/requestBlood')),
          ListTile(title: Text('Distress Call'), onTap: () => Navigator.pushNamed(context, '/distressCall')),
          ListTile(title: Text('Show Map'), onTap: () => Navigator.pushNamed(context, '/map')),
        ],
      ),
    );
  }
}

class RequestBloodScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _bloodBagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Request Blood')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(controller: _patientNameController, decoration: InputDecoration(labelText: 'Patient Name')),
            TextFormField(controller: _bloodBagsController, decoration: InputDecoration(labelText: 'Number of Blood Bags')),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ApiService.sendBloodRequest(
                    '2024-10-15',  // Just an example date
                    '12:00',
                    'Hospital ABC',
                    _patientNameController.text,
                    int.parse(_bloodBagsController.text),
                  );
                }
              },
              child: Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }
}