import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({Key? key}) : super(key: key);

  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {

  var list=<String>[];
  var listBool=<String>[];
  var listGecici=<String>[];
  var listTump=<String>[];
  String secilenElemanlar="";

  void getLocal()async{
    var sp=await SharedPreferences.getInstance();
    setState(() {
      list=sp.getStringList("Liste") ?? listGecici;
      listBool=sp.getStringList("ListeBool") ?? listGecici;
      secilenElemanlar=sp.getString("SecilenElemanlar") ?? "";
    });

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
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: ()async{
                var sp=await SharedPreferences.getInstance();
                setState(() {

                  if(listBool[index]=="true"){
                    //geçici liste
                    var l=<String>[];
                    String text="";
                    l=secilenElemanlar.split(",");


                    String txt=list[index];
                    l.remove(txt);
                    print(l);


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
            );
          }),
    );
  }
}
