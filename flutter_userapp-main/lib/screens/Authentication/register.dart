import 'package:flutter/material.dart';
import 'package:flutter_userapp/servicios/authentication_services/auth_services.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function toggleScreen;

  const Register({Key? key, required this.toggleScreen}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();

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

//build principal registro de usuario
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
                    /* IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {},
                    ),*/
                    SizedBox(height: 30),
                    Text(
                      "Bienvenido",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Crear una cuenta para continuar",
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
                          await loginProvider.register(
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
                          ? CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            )
                          : Text(
                              "Crear Usuario",
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
                        Text("Ya tienes una cuenta ?"),
                        SizedBox(width: 5),
                        TextButton(
                          onPressed: () => widget.toggleScreen(),
                          child: Text("Login"),
                        )
                      ],
                    ),
                    /* SizedBox(height: 5),
                    
                    if (loginProvider.errorMessage != other)
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: Colors.amberAccent,
                        child: ListTile(
                          title: Text(loginProvider.errorMessage),
                          leading: Icon(Icons.error),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => loginProvider.setMessage(null),
                          ),
                        ),
                      )
                      */
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
