import 'package:flutter/material.dart';

import '../Controllers/Crud_services.dart';
class UpdateContact extends StatefulWidget {
  const UpdateContact({super.key, required this.DocId, required this.email, required this.name, required this.phone});
 final String DocId;
 final String email;
 final String name;
 final String phone;
  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  final formKey=GlobalKey<FormState>();
  @override
  void initState() {
    email.text=widget.email;
    name.text=widget.name;
    phone.text=widget.phone;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Contact"),
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
                            CrudServices().UpdateContacts(name.text, phone.text, email.text,widget.DocId);
                            Navigator.pushReplacementNamed(context, "/home");
                          }
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 16),
                        ))),
                SizedBox(height: 20,),
                SizedBox(
                    height: 65,
                    width: MediaQuery.of(context).size.width * .9,
                    child: ElevatedButton(
                        onPressed: () {
                          CrudServices().deleteContact(widget.DocId);
                          Navigator.pop(context);

                        },
                        child: Text(
                          "Delete",
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
