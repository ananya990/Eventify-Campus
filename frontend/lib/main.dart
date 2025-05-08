import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/bottom_navbar.dart';
import 'package:flutter_application_2/screens/eventDetailspg.dart';
import 'package:flutter_application_2/screens/homepg.dart';
import 'package:flutter_application_2/screens/login.dart';
import 'package:flutter_application_2/screens/notificationspg.dart';
import 'package:flutter_application_2/screens/register.dart';
import 'package:flutter_application_2/screens/user_profile_page.dart';
import 'package:flutter_application_2/screens/calendarpg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login', // optional: better than using `home`
      routes: {
        'register': (context) => MyRegister(),
        'login': (context) => MyLogin(),
        'home': (context) => EventHome(),
        //'eventdetails': (context) => EventDescriptionPage(),
        'profilepage': (context) => UserProfilePage(),
        'calendarpage': (context) => CalendarPage(),
        'notificationpage': (context) => NotificationsPage(),
        'navbar': (context) => BottomNavbar(currentIndex: 0, onTap: (index) {}),
      },
    );
  }
}
