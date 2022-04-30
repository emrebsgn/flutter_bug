import 'package:flutter/material.dart';
import 'package:flutter_bug/pages/filter_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anasayfa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var l=<String>["İstanbul","Ankara","Edirne","Kırklareli","Trabzon"];
  var list=<String>[];
  var listBool=<String>[];

  void getLocal()async{
    var sp=await SharedPreferences.getInstance();
    /*for(var i=0;i<10;i++){
      list.add(i.toString());
    }*/
    sp.setStringList("Liste", l);
    //print(sp.getStringList("Liste"));
    for(var i in l){
      listBool.add("false");
    }
    sp.setStringList("ListeBool", listBool);
  }

  @override
  void initState() {
    super.initState();
    getLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterScreen()));
                },
                child: Text("Filtre"))
          ],
        )
      ),
    );
  }
}
