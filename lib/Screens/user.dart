import 'package:blood_donation_sql/constants.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    var sz = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hello userrrr'),
        ),
        drawer: SafeArea(
          child: SizedBox(
            width: sz.width*.7,
            child: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const UserAccountsDrawerHeader(
                    accountName: Text("Abhishek Mishra"),
                    accountEmail: Text("abhishekm977@gmail.com"),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Text(
                        "A",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.app_registration_rounded),
                    title: const Text(
                      "Enroll yourself",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add_card),
                    title: const Text("Certificate",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  const Divider(height: 10, thickness: 2,),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Log out",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: sz.width,
              decoration: BoxDecoration(
                border: Border.all(color: kGreen),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Not enrolled yet',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Container(
              width: sz.width,
              decoration: BoxDecoration(
                border: Border.all(color: kBlack),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Enroll to see details',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ));
  }
}
