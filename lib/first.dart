import 'package:database_sqlf/view_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main()
{
  runApp(MaterialApp(
  home: first(),
    debugShowCheckedModeBanner: false,
  )
  );
}class first extends StatefulWidget {
  static Database? database;

  Map ?m;
  first([this.m]);


  @override
  State<first> createState() => _firstState();
}
class _firstState extends State<first> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  get()
  async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    // open the database
    first.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, contact TEXT)');
        });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    if(widget.m!=null)
      {
        t1.text=widget.m!['name'];
        t2.text=widget.m!['contact'];
        setState(() {

        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("ADD DATA"),
      ),
      body: Column(
        children: [

          TextField(
            controller: t1,
          ),
          TextField(
            controller: t2,
          ),
          ElevatedButton(onPressed: () {
            String name=t1.text;
            String contact=t2.text;
           if(widget.m!=null)
           {
                String qry="update student set name='$name',contact='$contact' where id=${widget.m!['id']}";
                first.database!.rawUpdate(qry);
           }
           else
             {
               String qry="insert into student values(null,'$name','$contact')";
               first.database!.rawInsert(qry);
               print("$name,$contact");
             }
            Navigator.push(context,MaterialPageRoute(builder: (context) {
              return view_data();
            },));

          }, child: Text("Submit")),
          ElevatedButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) {
              return view_data();
            },));

          }, child: Text("View")),
        ],
      ),
    );
  }
}
