import 'package:flutter/material.dart';
import 'package:flutter_bug/pages/filter_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  var list=<String>[];
  var listBool=<String>[];
  var listGecici=<String>[];
  var listTump=<String>[];
  String secilenElemanlar="";
  String txt="";
  var l=<String>[];

  void getLocal()async{
    var sp=await SharedPreferences.getInstance();
    setState(() {
      list=sp.getStringList("Liste") ?? listGecici;
      listBool=sp.getStringList("ListeBool") ?? listGecici;
      secilenElemanlar=sp.getString("SecilenElemanlar") ?? "";
    });
    print("Get Local Seçilen Elemanlar: ${secilenElemanlar}");

  }

  void listeDuzenle(){
    listBool.clear();
    for(var i in list){
      listBool.add("false");
    }
    setState(() {
      listBool;
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
                children: List.generate(list.length, (index) => GestureDetector(
                  onTap: ()async{
                    var sp=await SharedPreferences.getInstance();
                    setState(() {

                      if(listBool[index]=="true"){
                        //geçici liste
                        l=secilenElemanlar.split(",");


                        txt=list[index];
                        print(txt);
                        l.remove(txt);
                        //String ist="İstanbul";
                        //String ank="Ankara";
                        //l.remove(ist);
                        //l.remove(ank);
                        print(l);
                        print(l.toString().length);
                        secilenElemanlar=l.toString();
                        print(secilenElemanlar);
                        secilenElemanlar=secilenElemanlar.substring(1,secilenElemanlar.length-1);
                        setState(() {
                          listBool[index]="false";
                          sp.setStringList("ListeBool",listBool);
                          secilenElemanlar;
                        });
                      }else{ //Ekle

                        if(secilenElemanlar.isNotEmpty){
                          print("boş değil");
                          secilenElemanlar=secilenElemanlar+","+list[index];
                        }else{
                          print("3");
                          secilenElemanlar=list[index];
                        }


                        setState(() {
                          listBool[index]="true";
                          sp.setStringList("ListeBool",listBool);
                          secilenElemanlar;
                        });
                      }

                    });
                  },
                  child: Card(
                    color:listBool[index]=="true"?Colors.green:Colors.grey[300],
                    child: Container(
                      padding: EdgeInsets.all(screenWidth/25),
                      width: double.infinity,
                      child: Text(list[index],style: TextStyle(
                          fontSize: screenWidth/22
                      ),),
                    ),
                  ),
                ),)
            ),
            Flexible(child: ElevatedButton(
              onPressed: ()async{
                var sp=await SharedPreferences.getInstance();
                setState(() {
                  sp.setString("SecilenElemanlar", secilenElemanlar);
                });
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FilterScreen()));
              },
              child: Text("Kaydet"),
            ))
          ],
        ),
      ),
    );
  }
}
