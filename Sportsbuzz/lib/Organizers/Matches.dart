import 'package:flutter/material.dart';
import 'package:sportsbuzz/Organizers/ScoreCard.dart';
var List11=[];
var List12=[];
var List13=[];
bool match=false;
MatchVisibilty(bool m){
  match=m;

}
class Scheduald extends StatefulWidget {
  const Scheduald({Key? key}) : super(key: key);

  @override
  State<Scheduald> createState() => _SchedualdState();
}

class _SchedualdState extends State<Scheduald> {

@override
  void initState() {
  print(List11);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matches'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: List11.length,
            itemBuilder: (BuildContext context,index){
            if(List11.isEmpty){
              return CircularProgressIndicator();
            }
            else{
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(

                  shape: RoundedRectangleBorder(


                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 1,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                  trailing: Visibility(
                    child: IconButton(onPressed: (){


                }, icon: Icon(Icons.delete)),
                    visible: match,
                  ),
                        tileColor: Colors.black12,
                        title: Center(child: Text(List11[0]['Title'],
                          style: TextStyle(fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),)),
                        
                        //subtitle: Text(ds['Details'],style: TextStyle(fontSize: 20,color: Colors.black),),


                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(List11[index]['Team1']+" vs "+List11[index]['Team2'],style: TextStyle(fontSize: 25),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Date:"+List11[index]['Date'],style: TextStyle(fontSize: 20,color: Colors.red),)),
                      ),
                      Visibility(
                        child: ButtonBar(
                          children: [
                            IconButton(onPressed: (){

                                GetMatchTeams(List11[index]['Team1'],List11[index]['Team2']);

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MatchCard()));
                            }, icon: Icon(Icons.start_outlined))
                          ],
                        ),
                        visible: match,
                      )


                    ],
                  ),
                ),
              );
            }
            }),
      ),
    );
  }

}
