import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;
  Widget calcButton(String btntext, Color btncolor, Color txtColor){
    return Container(
      child: RaisedButton(
        onPressed: (){
            calculation(btntext);
      },
      child: Text('$btntext',
        style: TextStyle(
          fontSize: 35,
          color: txtColor,
        ),
        
      ),
      shape: CircleBorder(),
      color: btncolor,
      padding: EdgeInsets.all(20),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: Text(''), 
      backgroundColor: backgroundColor,
      bottomOpacity: 0.0,
      elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(Icons.lightbulb, color: mode ? Colors.black : Colors.white,),
              onPressed: () {
                switchColor();
              })
        ],
      )

      ,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.all(10.0),
                  child: Text('$text',
                    textAlign: TextAlign.left,
                    style: TextStyle(color:  mode ? Colors.black : Colors.white  , fontSize: 100),
                    ),
                  )
                ],
              ),
             
            ),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcButton('AC', Colors.grey, Colors.white),
                  calcButton('+/-', Colors.grey, Colors.white),
                  calcButton('%', Colors.grey, Colors.white),
                  calcButton('/', Colors.amber, Colors.white),
                ],
             ),
             SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcButton('9', Colors.grey, Colors.white),
                  calcButton('8', Colors.grey, Colors.white),
                  calcButton('7', Colors.grey, Colors.white),
                  calcButton('+', Colors.amber, Colors.white),
                ],
             ),
             SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcButton('6', Colors.grey, Colors.white),
                  calcButton('5', Colors.grey, Colors.white),
                  calcButton('4', Colors.grey, Colors.white),
                  calcButton('-', Colors.amber, Colors.white),
                ],
             ),
             SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcButton('3', Colors.grey, Colors.white),
                  calcButton('2', Colors.grey, Colors.white),
                  calcButton('1', Colors.grey, Colors.white),
                  calcButton('/', Colors.amber, Colors.white),
                ],
             ),
             SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                    onPressed: (){
                        calculation('0');
                    },
                    shape: StadiumBorder(),
                    child: Text('0',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white
                      ),
                    ),
                    color: Colors.grey[850],
                    ),
                  calcButton('.', Colors.grey, Colors.white),
                  calcButton('=', Colors.amber, Colors.white),
                ],
             )
          ],
        ),
      ),
    );
  }
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  dynamic backgroundColor = Colors.white;
  dynamic mode = true;

  void switchColor(){
    if(mode){
      setState(() {
       backgroundColor = Colors.black;     
       mode = false;

      });
      
    }else{
      setState(() {
       backgroundColor = Colors.white;    
       mode = true;
      });
      
    }
    print('user tapped on ');
  }

  
   void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    
    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
         finalResult = add();
      } else if( preOpr == '-') {
          finalResult = sub();
      } else if( preOpr == 'x') {
          finalResult = mul();
      } else if( preOpr == '/') {
          finalResult = div();
      } 

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
          numOne = double.parse(result);
      } else {
          numTwo = double.parse(result);
      }

      if(opr == '+') {
          finalResult = add();
      } else if( opr == '-') {
          finalResult = sub();
      } else if( opr == 'x') {
          finalResult = mul();
      } else if( opr == '/') {
          finalResult = div();
      } 
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
     result = numOne / 100;
     finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }
    
    else if(btnText == '+/-') {
        result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();        
        finalResult = result;        
    
    } 
    
    else {
        result = result + btnText;
        finalResult = result;        
    }


    setState(() {
          text = finalResult;
        });

  }


  String add() {
         result = (numOne + numTwo).toString();
         numOne = double.parse(result);           
         return doesContainDecimal(result);
  }

  String sub() {
         result = (numOne - numTwo).toString();
         numOne = double.parse(result);
         return doesContainDecimal(result);
  }
  String mul() {
         result = (numOne * numTwo).toString();
         numOne = double.parse(result);
         return doesContainDecimal(result);
  }
  String div() {
          result = (numOne / numTwo).toString();
          numOne = double.parse(result);
          return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {
    
    if(result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if(!(int.parse(splitDecimal[1]) > 0))
         return result = splitDecimal[0].toString();
    }
    return result; 
  }

}