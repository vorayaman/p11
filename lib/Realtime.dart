

import 'package:firebase_database/firebase_database.dart';

class realtimedatabase
{
    FirebaseDatabase firebaseDatabase=FirebaseDatabase.instance;

    DatabaseReference? dbref;

    void add(String t1,String b1,String p1,)
    {
        dbref=firebaseDatabase.ref();
        dbref!.child("NEWS").push().set({"title":"$t1","body":"$b1","photo":"$p1",});
    }
    
    Stream<DatabaseEvent> getReadnews()
    {
        dbref=firebaseDatabase.ref();
        return dbref!.child("NEWS").onValue;
    }

    void deletenews(String key)
    {
        dbref=firebaseDatabase.ref();
        dbref!.child("NEWS").child("$key").remove();
    }

    void updatedata(String t1,String b1,String p1,String key)
    {
        dbref=firebaseDatabase.ref();
        dbref!.child("NEWS").child("$key").set({"title":t1,"body":b1,"photo":p1,});
    }
}