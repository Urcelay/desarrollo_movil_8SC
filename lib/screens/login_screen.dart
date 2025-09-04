import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controlador de la lógica de animaciones
  StateMachineController? controller;

  // Entradas del StateMachine
  SMIBool? isChecking; // Activa al oso chismoso
  SMIBool? isHandsUp;  // Se tapa los ojos
  SMITrigger? trigSuccess; // Se emociona
  SMITrigger? trigFail; // Se pone sad
  SMINumber? numLook; //mueve los ojos

  // Variable para controlar la visibilidad de la contraseña
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'animated_login_character.riv',
                  stateMachines: ["Login Machine"],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      "Login Machine",
                    );
                    if (controller == null) return;

                    artboard.addController(controller!);

                    // Conexión con los inputs del StateMachine
                    isChecking = controller!.findSMI('isChecking');
                    isHandsUp = controller!.findSMI('isHandsUp');
                    trigSuccess = controller!.findSMI('trigSuccess');
                    trigFail = controller!.findSMI('trigFail');
                    numLook = controller!.findSMI('numLook');
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Email
              TextField(
                onChanged: (value) {
                  if (isHandsUp != null) {
                    isHandsUp!.change(false); // no subir manos en email
                  }
                  if (isChecking != null) {
                    isChecking!.change(true); // activar osito chismoso
                  }

                  // mover ojos según cantidad de letras
                  if (numLook != null) {
                    numLook!.value = value.length.toDouble();
                  }
                }, 
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Password
              TextField(
                onChanged: (value) {
                  if (isChecking != null) {
                    isChecking!.change(false); // dejar de mirar al escribir pass
                  }
                  if (isHandsUp != null) {
                    isHandsUp!.change(true); // se tapa los ojos
                  }
                },
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: size.width,
                child: const Text(
                  "Forgot your Password?",
                  textAlign: TextAlign.right,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 10),

              // Botón de login
              MaterialButton(
                minWidth: size.width,
                height: 50,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () {
                  // Puedes probar:
                  // trigSuccess?.fire();
                  // trigFail?.fire();
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),

              // Registro
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
