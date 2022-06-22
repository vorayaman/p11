import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:p11/Realtime.dart';
import 'package:p11/auth/fireclass.dart';
import 'package:p11/modal/firemodal.dart';

class HOMESCREEN extends StatefulWidget {
  const HOMESCREEN({Key? key}) : super(key: key);

  @override
  State<HOMESCREEN> createState() => _HOMESCREENState();
}

class _HOMESCREENState extends State<HOMESCREEN> {
  TextEditingController title = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController body = TextEditingController();
  TextEditingController dtitle = TextEditingController();
  TextEditingController dphone = TextEditingController();
  TextEditingController dbody = TextEditingController();

  List<Firemodal> l1 = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
              onPressed: () {
                Auth().signOut(context);
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: title,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: phone,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: body,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  realtimedatabase().add(title.text, phone.text, body.text);
                },
                child: Text("ADD DATA"),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: realtimedatabase().getReadnews(),
                    builder: (context, AsyncSnapshot snapshot) {
                      l1.clear();
                      if (snapshot.hasError) {
                        return Text("${snapshot.hasError}");
                      } else if (snapshot.hasData) {
                        DataSnapshot snap = snapshot.data.snapshot;

                        for (DataSnapshot sp in snap.children) {
                          String photo = sp.child("photo").value.toString();
                          String title = sp.child("title").value.toString();
                          String body = sp.child("body").value.toString();
                          String? key = sp.key;

                          Firemodal firemodal =
                              Firemodal(photo, title, body, key!);
                          l1.add(firemodal);
                        }
                      }

                      return ListView.builder(
                          itemCount: l1.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  Container(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(l1[index].photo)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("${l1[index].title}"),
                                      Text("${l1[index].body}"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            dtitle.text=l1[index].title;
                                            dbody.text=l1[index].body;
                                            dphone.text=l1[index].photo;
                                          });

                                          updateDialog(l1[index].key);
                                        },
                                        child: Text("update"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          realtimedatabase()
                                              .deletenews(l1[index].key);
                                        },
                                        child: Text("Delete"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateDialog(String key) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            actions: [
              TextField(
                controller: dtitle,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: dtitle,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: dtitle,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  realtimedatabase().updatedata(dtitle.text, dbody.text, dphone.text, key);

                  Navigator.pop(context);
                },
                child: Text("UPDATE"),
              ),
            ],
          );
        });
  }
}
