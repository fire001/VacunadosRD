import 'package:flutter/material.dart';
import 'package:flutter_userapp/servicios/authentication_services/auth_services.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function toggleScreen;

  const Login({Key? key, required this.toggleScreen}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();
//controladores de texto
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

//build principal login
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //button back
                    /*IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {},
                    ),*/
                    SizedBox(height: 30),
                    Text(
                      "VacunadosRD",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "inicie sesion para continuar",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      validator: (val) => val!.isNotEmpty
                          ? null
                          : "Por favor ingrese un email valido",
                      decoration: InputDecoration(
                          hintText: "Introduzca su email",
                          prefixIcon: Icon(Icons.mail),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      validator: (val) => val!.length < 6
                          ? "Ingrese una contraseña mayor de 6 digitos"
                          : null,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key),
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    MaterialButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          print("Email: ${_emailController.text}");
                          print("Email: ${_passwordController.text}");
                          await loginProvider.login(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                        }
                      },
                      height: 70,
                      minWidth:
                          loginProvider.isLoading ? null : double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: loginProvider.isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Aun no tienes una cuenta ?"),
                        SizedBox(width: 5),
                        TextButton(
                          onPressed: () => widget.toggleScreen(),
                          child: Text("Registrar"),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
