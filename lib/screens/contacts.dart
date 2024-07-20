import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  fetchData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('your_collection').get();
      for (var doc in querySnapshot.docs) {
        print(doc.data());
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Contacts").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        "This is data fetched from Firestore Database",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              child: Text("${index + 1}",
                                style: TextStyle(fontSize: 20),),
                            ),
                            title: Text(
                              snapshot.data!.docs[index]['phoneNo'],
                              style: const TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              snapshot.data!.docs[index]['name'],
                              style: const TextStyle(fontSize: 17),
                            ),
                            minVerticalPadding: 12,
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    ),
                  ),
                ],
              );
            }
            else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.hasError.toString()),
              );
            }
            else {
              return const Center(
                child: Text('No Data Found!'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
