import 'package:database_sqlf/first.dart';
import 'package:flutter/material.dart';

class view_data extends StatefulWidget {
  const view_data({super.key});

  @override
  State<view_data> createState() => _view_dataState();
}

class _view_dataState extends State<view_data> {
  List <Map> l=[];
  getdata()
  async {
    String qry="select * from student";
    l = await first.database!.rawQuery(qry);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: Text("View Data"),
  ),
      body: FutureBuilder(future: getdata(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
          {
              return  ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
                return ListTile(
                  title:  Text("${l[index]['name']}"),
                  subtitle: Text("${l[index]['contact']}"),

                  trailing: Wrap(
                    children: [
                      IconButton(onPressed: () {
                      String qry="delete from student where id=${l[index]['id']}";
                      first.database!.rawDelete(qry);
                      setState(() {

                      });

                      }, icon:Icon(Icons.delete)),
                      IconButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return first(l[index]);
                        },));
                      }, icon:Icon(Icons.edit)),
                    ],
                  ),
                );
              },);
          }
        else
          {
             return CircularProgressIndicator();
          }
      },)

    );
  }
}
