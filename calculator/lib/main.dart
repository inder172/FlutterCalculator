import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}
Size size;
class _CalculatorState extends State<Calculator> {

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    StackResult=new List();
  }

  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;

    return Scaffold(body:
      Center(
        child: Container(height: size.height*0.96,width: size.width*0.95,color: Colors.redAccent,
          child: ListView(
            children: [
              Expanded(child: Container(child: Card( shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(padding: EdgeInsets.all(10),
                child: Column(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      (Data=="")?
                      Text('_______________________',style: TextStyle(fontSize: 28,color: Colors.grey[500]),overflow: TextOverflow.ellipsis,softWrap: true,textAlign: TextAlign.right,):
                      Text(Data,style: TextStyle(fontSize: 28,color: Colors.grey[500]),overflow: TextOverflow.ellipsis,softWrap: true,textAlign: TextAlign.right,),
                    ],
                  ),

                    SizedBox(height: 10,),
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      (result==0)?
                      Text('Result',style: TextStyle(fontSize: 60,color: Colors.grey[800],fontWeight: FontWeight.w800),overflow: TextOverflow.ellipsis,):
                      Text(result.toString(),style: TextStyle(fontSize: 60,color: Colors.grey[800],fontWeight: FontWeight.w800),overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                    SizedBox(height: 30,)
                ],),
              ),
              ),
                height: size.height*0.34,
              )),
              Divider(height: 0.2,),
              Column(children: [
                // CreateRow(Name: ['C','◄','%','/',],function: [ClickFunction(Symbol: true,Number: "C"),ClickFunction(Symbol: true,Number: "="),ClickFunction(Symbol: true,Number: "%"),ClickFunction(Symbol: true,Number: "/"),]),
                // CreateRow(Name: ['7','8','9','x',],function: [ClickFunction(Number: "7"),ClickFunction(Number: "8"),ClickFunction(Number: "9"),ClickFunction(Symbol: true,Number: "*"),]),
                // CreateRow(Name: ['4','5','6','-',],function: [ClickFunction(Number: "4"),ClickFunction(Number: "5"),ClickFunction(Number: "6"),ClickFunction(Symbol: true,Number: "-"),]),
                // CreateRow(Name: ['1','2','3','+',],function: [ClickFunction(Number: "1"),ClickFunction(Number: "2"),ClickFunction(Number: "3"),ClickFunction(Symbol: true,Number: "+"),]),
                // CreateRow(Name: ['.','0','.','=',],function: [ClickFunction(Symbol: true,Number: "."),ClickFunction(Number: "0"),ClickFunction(Symbol: true,Number: "."),ClickFunction(Symbol: true,Number: "="),])
                CreateRow(Name: ['C','◄','%','/',],function: [new FunctionProperties(true, "C"),new FunctionProperties(true, "="),new FunctionProperties(true, "%"),new FunctionProperties(true, "/"),]),
                CreateRow(Name: ['7','8','9','x',],function: [new FunctionProperties(false, "7"),new FunctionProperties(false, "8"),new FunctionProperties(false, "9"),new FunctionProperties(true, "*"),]),
                CreateRow(Name: ['4','5','6','-',],function: [new FunctionProperties(false, "4"),new FunctionProperties(false, "5"),new FunctionProperties(false, "6"),new FunctionProperties(true, "-"),]),
                CreateRow(Name: ['1','2','3','+',],function: [new FunctionProperties(false, "1"),new FunctionProperties(false, "2"),new FunctionProperties(false, "3"),new FunctionProperties(true, "+"),]),
                CreateRow(Name: ['.','0','.','=',],function: [new FunctionProperties(true, "."),new FunctionProperties(false, "0"),new FunctionProperties(true, "."),new FunctionProperties(true, "="),]),
              ],)
            ],
          ),
        ),
      ),);
  }


  double result=0;
  String ConcString="";
  dynamic ClickFunction({String Number,bool Symbol=false})
  {
    //print("Number:"+Number);
    Data+=Number;
    if(Data.contains("="))
    {
      String temp=Data;
      Data=Data.replaceAll("=", "");
      if(temp[temp.length-1]=='=')
      {
        Data=Data+"=";
      }
      StackResult.remove("=");
      StackResult.add("=");
    }
    print("1");
    if(Symbol==true) {
      print("2");
      StackResult.add(ConcString);
      StackResult.add(Number);
      print("3");
      ConcString="";
      print("4");
      if(Number=="C")
        {
          StackResult.clear();
          result=0;
          Data="";
        }
      else
        {
          if (StackResult[StackResult.length-1] == "◄") {
            StackResult.removeAt(StackResult.length-1);
          }
        }
    }
    else
      {
        print("5");
        ConcString+=Number;
      }
    print("6");
    print("Data:    "+Data);
    CalResult();

  }



  List<String> StackResult;
  String Data="";
  void CalResult()
  {
    if(StackResult.length>0) {
      double Result = 0;
      double tempNumber = 0;
      int Limit = StackResult.length - 1;
      print("CalResult()    1");
      if (double.tryParse(StackResult[StackResult.length - 1]) != null) {
        Limit = StackResult.length+1;
      }
      print("CalResult()    2");
      double val = double.parse(StackResult[0]);
      //Data=StackResult[0];
      int CharStartingIndex = -1;
      int EndStartingIndex = 0;
      double a=Limit/2;
      int b=a.toInt();
      print("CalResult()    3      "+b.toString());
      for (int i = 0; i < b; i++) {
        CharStartingIndex = CharStartingIndex + 2;
        EndStartingIndex = EndStartingIndex + 2;
        print( val.toString() +","+ StackResult[CharStartingIndex]+","+StackResult[EndStartingIndex]);

        if (StackResult[CharStartingIndex] == "+") {
          val = val + double.parse(StackResult[EndStartingIndex]);
        }
        else {
          if (StackResult[CharStartingIndex] == "-") {
            val = val - double.parse(StackResult[EndStartingIndex]);
          }
          else {
            if (StackResult[CharStartingIndex] == "*") {
              val = val * double.parse(StackResult[EndStartingIndex]);
            }
            else {
              if (StackResult[CharStartingIndex] == "/") {
                val = val / double.parse(StackResult[EndStartingIndex]);
              }
              else
                {
                  if (StackResult[CharStartingIndex] == "C") {
                    StackResult.clear();
                    val=0;
                    Data="";
                  }
                  else
                    {
                      if (StackResult[CharStartingIndex] == "%") {
                        val = val % double.parse(StackResult[EndStartingIndex]);
                      }
                      else
                        {

                        }
                    }
                }
            }
          }
        }
      }
      print("CalResult()    4");

      result=val;
      if (StackResult[StackResult.length-1] == "=")
      {
        //print("They Called me");
        print("-------------->"+Data);
        print("--------------> , "+val.toString());
        Data=val.toString();
        StackResult.clear();
        StackResult.add(val.toString());
        result=double.parse("0");
      }
      if(double.tryParse(StackResult[StackResult.length - 1])=="=")
      {
        StackResult.removeAt(StackResult.length-1);

      }

      print("Data:"+Data+"  ,Result:" + val.toString());
    }
    print("They Called me");
    setState(() {

    });
  }
  //+  -  *   /   %
  List<int> SymbolCharacterRange=[43,45,42,47,37];

  Widget CreateRow({@required List<String> Name,@required List<FunctionProperties> function})
  {
    return Row(
      children: <Widget>[

        Expanded(
          flex: 1,
          child: InkWell(onTap: (){
            //function[0]();
            ClickFunction(Symbol: function[0].Symbol,Number: function[0].Number);
          },
            child: Container(
              color: Colors.amber,
              height: size.height*0.115,
              child: Center(child: Text(Name[0],textAlign: TextAlign.center,style: TextStyle(fontSize: 27),),),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(onTap: (){
            ClickFunction(Symbol: function[1].Symbol,Number: function[1].Number);
          },
            child: Container(
              color: Colors.tealAccent,
              height: size.height*0.115,
              child: Center(child: Text(Name[1],textAlign: TextAlign.center,style: TextStyle(fontSize: 27),),),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(onTap: (){
            ClickFunction(Symbol: function[2].Symbol,Number: function[2].Number);
          },
            child: Container(
              color: Colors.blue,
              height: size.height*0.115,
              child: Center(child: Text(Name[2],textAlign: TextAlign.center,style: TextStyle(fontSize: 27),),),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(onTap: (){
            ClickFunction(Symbol: function[3].Symbol,Number: function[3].Number);
          },
            child: Container(
              color: Colors.amber,
              height: size.height*0.115,
              child: Center(child: Text(Name[3],textAlign: TextAlign.center,style: TextStyle(fontSize: 27),),),
            ),
          ),
        ),
      ],
    );
  }


}
class FunctionProperties{
  bool Symbol;
  String Number;
  FunctionProperties(this.Symbol,this.Number);
}