import 'package:blood_donation_sql/Screens/loading.dart';
import 'package:blood_donation_sql/db/database_helper.dart';
import 'package:blood_donation_sql/models/user_model.dart';
import 'package:flutter/material.dart';

class ListOfDonatedStudents extends StatefulWidget {
  const ListOfDonatedStudents({super.key});

  @override
  State<ListOfDonatedStudents> createState() => _ListOfDonatedStudentsState();
}

class _ListOfDonatedStudentsState extends State<ListOfDonatedStudents> {
  final dbhelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Student>>(
      future: dbhelper.readallDonatedStudents(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isEmpty == true
              ? const Center(
                  child: Text(
                    'No donations yet',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  // shrinkWrap: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  // scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 80,
                      // width: 300,
                      decoration: BoxDecoration(
                        // border: Border.all(color: kbg2, width: 3),
                        color: const Color.fromARGB(255, 183, 218, 247),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 10), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Container(
                          // radius: ,
                          decoration: BoxDecoration(
                              // border: Border.all(width: 2),
                              color:
                                  const Color.fromARGB(255, 246, 181, 83),
                              borderRadius: BorderRadius.circular(10)
                              // shape: BoxShape.

                              ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              snapshot.data![index].mis.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        title: Text(
                          snapshot.data![index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              overflow: TextOverflow.visible),
                        ),
                        subtitle: Text(
                          snapshot.data![index].email,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis),
                        ),
                        // trailing: IconButton(
                        //   onPressed: () async{
                        //     await dbhelper.deleteStudent(snapshot.data![index].mis);
                        //   },
                        //   icon: const Icon(Icons.delete)),
                      ),
                    );

                    // Text(snapshot.data![index].name);
                  });
        }
        return const Loader();
      }),
    );
  }
}
