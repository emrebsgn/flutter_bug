import 'package:flutter/material.dart';
import 'package:flutter_bug/main.dart';
import 'package:flutter_bug/pages/list_screen.dart';
import 'package:flutter_bug/pages/list_view_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  var list=<String>[];
  String secilenElemanlar="";

  void getLocal()async{
    var sp=await SharedPreferences.getInstance();
    setState(() {
      secilenElemanlar=sp.getString("SecilenElemanlar") ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    getLocal();
  }

  @override
  Widget build(BuildContext context) {
    var screenInfos=MediaQuery.of(context); //Burada ekran boyutu alınacak.
    final double screenWidth=screenInfos.size.width;
    final double screenHeight=screenInfos.size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: List.generate(1, (index) => GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ListScreen()));
                },
                child: Card(
                  color:Colors.grey[300],
                  child: Container(
                    padding: EdgeInsets.all(screenWidth/25),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text("Seçenekler",style: TextStyle(
                            fontSize: screenWidth/22
                        ),),
                        secilenElemanlar.isNotEmpty?Text(secilenElemanlar):Center(),
                      ],
                    ),
                  ),
                ),
              ),),
            ),
            Flexible(
                child: Column(
                  children: [
                    SizedBox(height: 100,),
                    ElevatedButton(
                        onPressed: (){

                        },
                        child: Text("Ekle")),
                    ElevatedButton(
                        onPressed: ()async{
                          var sp=await SharedPreferences.getInstance();
                          sp.remove("ListeBool");
                          sp.remove("SecilenElemanlar");
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "Anasayfa")));
                        },
                        child: Text("Sil")),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ListViewScreen()));
                        },
                        child: Text("GİT")),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
