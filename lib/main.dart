import 'package:flutter/material.dart'; //libreria material
import 'screens/login_screen.dart'; //importa la pantalla de login
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget { //sin estado 
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    );
  }
}


