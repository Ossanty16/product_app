

import 'package:flutter/material.dart';
import 'package:product_app/providers/login_form_provider.dart';
import 'package:product_app/ui/input_decorations.dart';
import 'package:product_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: AuthBackground(
        child: Column(
          children: [
            const SizedBox(height: 250,),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text('Login', style: Theme.of(context).textTheme.headline4,),
                  const SizedBox(height: 30,),
                  //const Text('formulario')
                  ChangeNotifierProvider(
                    create: ( _ ) => LoginFormProvider(),
                    child: _LoginForm(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            const Text(
              'Crear una nueva cuenta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        )
      )
    );
  }

  
}

class _LoginForm extends StatelessWidget {
  _LoginForm();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
  
    return Container(
      child: Form(
        key: loginForm.formKey,
        child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(hintText: 'correo@servidor.com', labelText: 'correo electronico', prefixIcon: Icons.alternate_email_rounded),
            onChanged: (value) => loginForm.email=value,
            validator: (value) {
              String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = new RegExp(pattern);

              return regExp.hasMatch(value ?? '') ? null : 'correo no valido';

            },
          ),
          TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(hintText: '*****',labelText: 'contraseña',prefixIcon: Icons.lock_clock_outlined),
            onChanged: (value) => loginForm.password=value,
            validator: (value) {
              return (value != null && value.length >= 6)
              ? null: 'se necesitan 6 letras';
            },
        
          ),
              
          MaterialButton(
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                if(!loginForm.isValidForm()) return;

                Navigator.pushReplacementNamed(context, 'home');
              }
          )
        ],
      ),
      )

      
    );
  }
}