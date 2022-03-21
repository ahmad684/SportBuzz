import 'package:flutter/material.dart';
var Team1,Team2;
var toss;
bool ts=false;
bool sc=false;
bool st=false;
bool wide=false;
bool no_ball=false;
bool legby=false;
bool byes=false;
bool out=false;
int scor=0,_out=0,target=0;
double rr=0;int over=0,ball=0,ining=1;


List<String> toss_list=[];
GetMatchTeams(String T1,String T2){
  Team1=T1;
  Team2=T2;
  print(Team1);
  print(Team2);
  toss_list.clear();
  toss_list.add(T1);
  toss_list.add(T2);
  print(toss_list);

}
class MatchCard extends StatefulWidget {
  const MatchCard({Key? key}) : super(key: key);

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {

  @override
  void initState() {
    ts=true;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Team1+" vs "+Team2),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: ListView(
          children: [

            Visibility(
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey,
                        border: Border.all(

                          width: 2,
                        ),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: [
                          Column(
                            children: [
                              Text(ining.toString()+'st Ining',style: TextStyle(fontSize: 19),),
                              Row(children: [
                                Text(scor.toString()+"-",style: TextStyle(fontSize: 40),),
                                Text(_out.toString(),style: TextStyle(fontSize: 40),),
                              ],)

                            ],
                          ),
                          Column(
                            children: [
                              Text('RR',style: TextStyle(fontSize: 19),),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(rr.toString(),style: TextStyle(fontSize: 20),),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(over.toString(),style: TextStyle(fontSize: 20),),
                                  Text("."+ball.toString(),style: TextStyle(fontSize: 20),),
                                  Text(' Over',style: TextStyle(fontSize: 20),),

                                ],
                              )


                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey,
                          border: Border.all(

                            width: 2,
                          ),
                        ),

                        child: Column(
                          children: [
                            Text('Target: '+target.toString(),style: TextStyle(fontSize: 25),),







                          ],
                        ),
                      ),
                    ),
                    visible: ts,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey,
                        border: Border.all(

                          width: 2,
                        ),
                      ),

                      child: Column(
                        children: [



                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //strike
                              Checkbox(value: st, onChanged: (v){
                               setState(() {
                                 st=v!;
                               });
                              }),
                              Text('Strike'),
                              Checkbox(value: wide, onChanged: (v){
                               setState(() {
                                 wide=v!;
                               });
                              }),
                              Text('Wide'),
                              Checkbox(value: no_ball, onChanged: (v){
                               setState(() {
                                 no_ball=v!;
                               });
                              }),
                              Text('No Ball'),

                            ],),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //strike

                              Checkbox(value: byes, onChanged: (v){
                               setState(() {
                                 byes=v!;
                               });
                              }),
                              Text('Byes'),
                              Checkbox(value: out, onChanged: (v){
                               setState(() {
                                 out=v!;
                               });
                              }),
                              Text('Wicket'),

                            ],),





                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey,
                        border: Border.all(

                          width: 2,
                        ),
                      ),

                      child: Column(
                        children: [



                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //strike

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(onPressed: (){
                                  if(st){
                                    setState(() {
                                      scor=scor+0;
                                      ball=ball+1;
                                      if(ball==7){

                                        over=over+1;
                                        rr=(scor/over);
                                        ball=0;
                                      }
                                    });

                                  }
                                  else if(out&no_ball)
                                  {

                                    setState(() {

                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                      }
                                    });}










                                 else if(out){

                                    setState(() {
                                      ball=ball+1;
                                      if(ball==7){

                                        over=over+1;
                                        rr=(scor/over);
                                        ball=0;
                                      }
                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                      }
                                    });}
                                  else if(out&st){

                                    setState(() {
                                      scor=scor+0;
                                      ball=ball+1;
                                      if(ball==7){

                                        over=over+1;
                                        rr=(scor/over);
                                        ball=0;
                                      }
                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                      }
                                    });}
                                }, child: Text('0'),style: ElevatedButton.styleFrom(
                                    primary: Colors.black),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(onPressed: (){
                                  if(st){
                                    setState(() {
                                      scor=scor+1;
                                      ball=ball+1;
                                      if(ball==7){

                                        over=over+1;
                                        rr=(scor/over);
                                        ball=0;
                                      }
                                    });

                                  }
                                  else if(wide){
                                    setState(() {
                                      scor=scor+1;
                                    });

                                  }



                                  else if(no_ball){
                                    setState(() {
                                      scor=scor+1;
                                    });

                                  }

                                  else if(byes){

                                    setState(() {
                                      scor=scor+1;
                                      ball=ball+1;
                                      if(ball==7){

                                        over=over+1;
                                        rr=(scor/over);
                                        ball=0;
                                      }
                                    });}

                                 else if(out){

                                    setState(() {
                                      ball=ball+1;
                                      if(ball==7){

                                        over=over+1;
                                        rr=(scor/over);
                                        ball=0;
                                      }
                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('All Team Out', 'Target:'+scor.toString(), 'OK');

                                      }
                                    });}
                                  else if(out&st){

                                    setState(() {
                                      scor=scor+1;
                                      ball=ball+1;
                                      if(ball==7){

                                        over=over+1;
                                        rr=(scor/over);
                                        ball=0;
                                      }
                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                      }
                                    });}
                                }, child: Text('1'),style: ElevatedButton.styleFrom(
                                    primary: Colors.black),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(onPressed: (){
                                  if(st){
                                    setState(() {
                                      scor=scor+2;
                                      ball=ball+1;
                                      if(ball==7){

                                        over=over+1;
                                        rr=(scor/over);
                                        ball=0;
                                      }
                                    });

                                  }

                                  else if(wide&byes){
                                   setState(() {
                                     scor=scor+2;
                                   });

                                  }

                                  else if(no_ball&byes){
                                    setState(() {
                                      scor=scor+2;
                                    });

                                  }
                                  else if(byes){

                                    setState(() {
                                      scor=scor+2;
                                      ball=ball+1;
                                      if(ball==7){

                                        over=over+1;
                                        rr=(scor/over);
                                        ball=0;
                                      }
                                    });}

                                 else if(out){

                                    setState(() {
                                      ball=ball+1;
                                      if(ball==7){

                                        over=over+1;
                                        rr=(scor/over);
                                        ball=0;
                                      }
                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                      }
                                    });}
                                  else if(out&st){

                                    setState(() {
                                      scor=scor+2;
                                      ball=ball+1;
                                      if(ball==7){

                                        over=over+1;
                                        rr=(scor/over);
                                        ball=0;
                                      }
                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                      }
                                    });}
                                }, child: Text('2'),style: ElevatedButton.styleFrom(
                                    primary: Colors.black),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(onPressed: (){
                                  if(st){
                                    setState(() {
                                      scor=scor+3;
                                      ball=ball+1;
                                      if(ball==7){
                                        rr=(scor/over);
                                        over=over+1;
                                        ball=0;
                                      }
                                    });

                                  }

                                  else if(wide&byes){
                                   setState(() {
                                     scor=scor+3;
                                   });

                                  }

                                  else if(no_ball&byes){
                                    setState(() {
                                      scor=scor+3;
                                    });

                                  }
                                  else if(byes){

                                    setState(() {
                                      scor=scor+3;
                                      ball=ball+1;
                                      if(ball==7){
                                        rr=(scor/over);
                                        over=over+1;
                                        ball=0;
                                      }
                                    });}

                                 else if(out){

                                    setState(() {
                                      ball=ball+1;
                                      if(ball==7){
                                        rr=(scor/over);
                                        over=over+1;
                                        ball=0;
                                      }
                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                      }
                                    });}
                                  else if(out&st){

                                    setState(() {
                                      scor=scor+3;
                                      ball=ball+1;
                                      if(ball==7){
                                        rr=(scor/over);
                                        over=over+1;
                                        ball=0;
                                      }
                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                      }
                                    });}
                                }, child: Text('3'),style: ElevatedButton.styleFrom(
                                    primary: Colors.black),),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: ElevatedButton(onPressed: (){}, child: Text('1'),style: ElevatedButton.styleFrom(
                              //       primary: Colors.black),),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: ElevatedButton(onPressed: (){}, child: Text('2'),style: ElevatedButton.styleFrom(
                              //       primary: Colors.black),),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: ElevatedButton(onPressed: (){}, child: Text('3'),style: ElevatedButton.styleFrom(
                              //       primary: Colors.black),),
                              // ),


                            ],),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //strike
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(onPressed: (){
                                  if(st){
                                    setState(() {
                                      scor=scor+4;
                                      ball=ball+1;
                                      if(ball==7){
                                        rr=(scor/over);
                                        over=over+1;
                                        ball=0;
                                      }
                                    });

                                  }

                                  else if(wide&byes){
                                    setState(() {
                                      scor=scor+4;
                                    });

                                  }

                                  else if(no_ball&byes){
                                    setState(() {
                                      scor=scor+4;
                                    });

                                  }
                                  else if(byes){

                                    setState(() {
                                      scor=scor+4;
                                      ball=ball+1;
                                      if(ball==7){
                                        rr=(scor/over);
                                        over=over+1;
                                        ball=0;
                                      }
                                    });}

                                  else if(out){

                                    setState(() {
                                      ball=ball+1;
                                      if(ball==7){
                                        rr=(scor/over);
                                        over=over+1;
                                        ball=0;
                                      }
                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                      }
                                    });}
                                  else if(out&st){

                                    setState(() {
                                      scor=scor+4;
                                      ball=ball+1;
                                      if(ball==7){
                                        rr=(scor/over);
                                        over=over+1;
                                        ball=0;
                                      }
                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                      }
                                    });}
                                }, child: Text('4'),style: ElevatedButton.styleFrom(
                                    primary: Colors.black),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(onPressed: (){
                                  if(st&no_ball){
                                    setState(() {
                                      scor=scor+5;
                                      ball=ball+1;
                                      if(ball==7){
                                        rr=(scor/over);
                                        over=over+1;
                                        ball=0;
                                      }
                                    });

                                  }

                                  else if(wide&byes){
                                    setState(() {
                                      scor=scor+5;
                                    });

                                  }

                                  else if(no_ball&byes){
                                    setState(() {
                                      scor=scor+5;
                                    });

                                  }


                                  else if(out){

                                    setState(() {
                                      ball=ball+1;
                                      if(ball==7){
                                        rr=(scor/over);
                                        over=over+1;
                                        ball=0;
                                      }
                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                      }
                                    });}

                                }, child: Text('5'),style: ElevatedButton.styleFrom(
                                    primary: Colors.black),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(onPressed: (){
                                  if(st){
                                    setState(() {
                                      scor=scor+6;
                                      ball=ball+1;
                                      if(ball==7){
                                        rr=(scor/over);
                                        over=over+1;
                                        ball=0;
                                      }
                                    });

                                  }





                                   if(out){

                                    setState(() {
                                      ball=ball+1;
                                      if(ball==7){
                                        rr=(scor/over);
                                        over=over+1;
                                        ball=0;
                                      }
                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                      }
                                    });}
                                   else if(st&out){
                                     setState(() {
                                       scor=scor+6;
                                       ball=ball+1;
                                       if(ball==7){
                                         rr=(scor/over);
                                         over=over+1;
                                         ball=0;
                                       }
                                       _out=_out+1;
                                       if(_out==11){
                                         _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                       }
                                     });
                                   }

                                }, child: Text('6'),style: ElevatedButton.styleFrom(
                                    primary: Colors.black),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(onPressed: (){
                                  if(st&no_ball){
                                    setState(() {
                                      scor=scor+7;

                                    });

                                  }






                                  else  if(out){

                                    setState(() {
                                      ball=ball+1;
                                      if(ball==7){
                                        rr=(scor/over);
                                        over=over+1;
                                        ball=0;
                                      }
                                      _out=_out+1;
                                      if(_out==11){
                                        _showMyDialog('Ining Completed', 'Targer'+scor.toString(), 'OK');

                                      }
                                    });}


                                }, child: Text('6'),style: ElevatedButton.styleFrom(
                                    primary: Colors.black),),
                              ),



                            ],),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //strike
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(onPressed: (){
                               setState(() {
                                 target=scor+1;
                                 scor=0;
                                 _out=0;
                                 ining=2;
                                 rr=0;
                                 over=0;
                                 ball=0;
                                 ts=true;


                               });
                                }, child: Text('Second Ining'),style: ElevatedButton.styleFrom(
                                    primary: Colors.black),),
                              ),




                            ],),





                        ],
                      ),
                    ),
                  ),











                ],
              ),
              visible: true,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
                if(scor<target){
                  setState(() {
                    target=0;
                    scor=0;
                    _out=0;
                    ining=2;
                    rr=0;
                    over=0;
                    ball=0;
                    ts=true;
                    _showMyDialog('Congratulations', 'First Team Won', 'ok');
                    Navigator.pop(context);
                  });

                }else{
                  setState(() {
                    target=scor+1;
                    scor=0;
                    _out=0;
                    ining=2;
                    rr=0;
                    over=0;
                    ball=0;
                    ts=true;
                  });
                  _showMyDialog('Congratulations', 'Second Team Won', 'ok');
                  Navigator.pop(context);
                }
              }, child: Text('Completed'),

              style: ElevatedButton.styleFrom(
                primary: Colors.black,

              ),
              ),
            )
          ],
        ),
      ),

    );
  }

  Future<void> _showMyDialog(String title, String msg1, var msg2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg1),
                Text(msg2),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
