import 'package:flutter/material.dart';
import 'package:practise/Controllers/Crud_services.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      // obscureText: true,
                      controller: name,
                      validator: (value) => value!.isEmpty?"Enter any name":null,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Name")),
                    )),
                SizedBox(height: 20,),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      // obscureText: true,
                      controller: phone,

                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Phone")),
                    )),
                SizedBox(height: 20,),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      // obscureText: true,
                      controller: email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Email")),
                    )),
                SizedBox(height: 20,),
                SizedBox(
                    height: 65,
                    width: MediaQuery.of(context).size.width * .9,
                    child: ElevatedButton(
                        onPressed: () {
            if(formKey.currentState!.validate()){
              CrudServices().AddNewContacts(name.text, phone.text, email.text);
              Navigator.pushReplacementNamed(context, "/home");
            }
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 16),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
