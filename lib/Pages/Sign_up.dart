import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practise/Controllers/auth_service.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});
  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController Password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Text(
                "Sign Up",
                style:
                    GoogleFonts.sora(fontSize: 40, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Email cannot be empty" : null,
                    controller: email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text("Email")),
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    validator: (value) => value!.length < 8
                        ? "Password should have atleast 8 characters"
                        : null,
                    obscureText: true,
                    controller: Password,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text("Password")),
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 65,
                  width: MediaQuery.of(context).size.width * .9,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          authService()
                              .createAccountWithEmail(email.text, Password.text)
                              .then((value) => {
                                    if (value == "Account Created")
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text("Account Created"))),
                                        Navigator.pushReplacementNamed(context, "/home")
                                      }
                                    else
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(value,style: TextStyle(color: Colors.white),),
                                          backgroundColor: Colors.red.shade400,
                                        ))
                                      }
                                  });
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16),
                      ))),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 65,
                width: MediaQuery.of(context).size.width * .9,
                child: OutlinedButton(
                  onPressed: () {
                    authService().ContinueGoogle().then((value)=>{
                      if(value=="Google Login Successful")
                        {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                              content:
                              Text("Google LogIn Successful"))),
                          Navigator.pushReplacementNamed(
                              context, "/home")
                        }
                      else
                        {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content: Text(
                              value,
                              style:
                              TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red.shade400,
                          ))
                        }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "Assets/Images/google.png",
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        "Continue With Google",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: Text("Sign Up"))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
