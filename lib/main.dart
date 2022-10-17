import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'alllist.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const MyApp());
}

//function for convert to hex format color
int hexcolor(String c) {
  String scolor = '0xff' + c;
  scolor = scolor.replaceAll('#', '');
  int dcolor = int.parse(scolor);
  return dcolor;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.black),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _istap = false;
  String ques = '';
  String ans = '';

  bool isoperator(String x) {
    if (x == '%' || x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equalpressed(){
    String finalques = ques;
    Parser p = Parser();
    Expression exp = p.parse(finalques);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    ans = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: _istap ? Colors.black : Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.31,
                width: MediaQuery.of(context).size.width,
                //  color: Colors.pink,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 50,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Color(hexcolor('#F9F9F9')),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _istap = false;
                                  });
                                },
                                icon: Icon(Icons.sunny)),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _istap = true;
                                  });
                                },
                                icon: Icon(Icons.nightlight_outlined)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 154,
                      width: 375,
                      //    color: Colors.green,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Container(
                              child: Text(ques, style: TextStyle(fontSize: 20,color: _istap ? Colors.white:Colors.black),
                              ),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(right: 18.0, bottom: 10),
                            child: Container(
                              child: Text(ans,
                                  style: TextStyle(fontSize: 20,color: _istap ? Colors.white:Colors.black)),
                              alignment: Alignment.bottomRight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.61,
                width: MediaQuery.of(context).size.width,
                // color: Colors.pink,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            // for c button
                            if (index == 0) {
                              ques = '';
                              ans = '';
                            }
                            // for del option
                            else if (index == 1) {
                              ques = ques.substring(0, ques.length - 1);
                            }
                            //for equal and ans button operation
                            else if (index == 19 || index == 18) {
                              setState(() {
                                equalpressed();
                              });
                            } else {
                              ques += item[index];
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: isoperator(item[index])
                                ? CupertinoColors.black
                                : Color(hexcolor('#F9F9F9')),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(item[index],
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: isoperator(item[index])
                                            ? Colors.white
                                            : Colors.black87))),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
