import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart'; // Import flutter_phone_direct_caller package
import 'package:practise/Controllers/Crud_services.dart';
import 'package:practise/Controllers/auth_service.dart';
import 'package:practise/Pages/Add_contact.dart';
import 'package:practise/Pages/Update_contact.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider_installer.dart';
import 'Login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ProviderInstaller.installProvider();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CheckLoging(),
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => Home(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  late Stream<QuerySnapshot> _stream;
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _stream = CrudServices().getContacts();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> callUser(String num) async {
    try {
      bool? res = await FlutterPhoneDirectCaller.callNumber(num); // Using flutter_phone_direct_caller to initiate the call
      if (!res!) {
        throw 'Could not launch $num';
      }
    } catch (e) {
      print('Error launching phone: $e');
      // Handle error as needed
    }
  }

  void searchContact(String query) {
    setState(() {
      _stream = CrudServices().getContacts(SearchQuery: query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width * .8, 80),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: TextFormField(
                onChanged: (value) => searchContact(value),
                controller: searchController,
                focusNode: searchFocusNode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Search",
                  prefixIcon: Icon(Icons.search_outlined),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                    onPressed: () {
                      searchController.clear();
                      searchFocusNode.unfocus();
                      searchContact('');
                    },
                    icon: Icon(Icons.close),
                  )
                      : null,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddContact()),
          );
        },
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    maxRadius: 30,
                    child: Text(
                      FirebaseAuth.instance.currentUser!.email![0].toUpperCase(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(FirebaseAuth.instance.currentUser!.email!),
                ],
              ),
            ),
            ListTile(
              onTap: () async {
                await authService().Logout();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Logged out"),
                    backgroundColor: Colors.red.shade400,
                  ),
                );
                Navigator.pushReplacementNamed(context, "/login");
              },
              leading: Icon(Icons.logout_outlined),
              title: Text("Logout"),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No contacts"));
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(data["name"][0]),
                  ),
                  title: Text(data["name"]),
                  subtitle: Text(data["phone"]),
                  trailing: IconButton(
                    onPressed: () => callUser(data["phone"]), // Calling the callUser function on IconButton press
                    icon: Icon(Icons.call),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateContact(
                          DocId: document.id,
                          name: data["name"],
                          phone: data["phone"],
                          email: data["email"],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
          return Center(child: Text("No contacts found"));
        },
      ),
    );
  }
}

class CheckLoging extends StatefulWidget {
  const CheckLoging({super.key});

  @override
  State<CheckLoging> createState() => _CheckLogingState();
}

class _CheckLogingState extends State<CheckLoging> {
  @override
  void initState() {
    super.initState();
    authService().isLogIn().then((isLoggedIn) {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
