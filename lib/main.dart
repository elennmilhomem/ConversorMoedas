import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

const request = "https://api.hgbrasil.com/finance?key=5cbfb4fa";

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        hintColor: Colors.white,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2e2e3d),
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.menu,
            color: Colors.white38,
          ),
        ),
        backgroundColor: Color(0xFF44445a),
        elevation: 0.0,
        title: Text(
          "CONVERSOR DE MOEDAS",
          style: GoogleFonts.crimsonText(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.equalizer,),
            color: Colors.white38,
          ),
        ],
      ),
      body: FutureBuilder<Map>(
        future: getData(),

        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados...",
                  style: GoogleFonts.crimsonText(color: Colors.white38, fontSize: 25.0),
                  // style: TextStyle(color: Colors.white38, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar Dados...",
                    style: GoogleFonts.crimsonText(color: Colors.white38, fontSize: 25.0),
                    // style: TextStyle(color: Colors.white38, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          height: 50.0,
                        ),

                        //PRIMEIRO CAMPO
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "REAIS",
                              style: GoogleFonts.crimsonText(color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 18.0),
                              // style: TextStyle(
                              //     color: Colors.white38,
                              //     fontWeight: FontWeight.bold,
                              //     fontSize: 18.0),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            SizedBox(
                              width: 200,
                              height: 40,
                              child: Material(
                                color: Color(0xFF44445a),
                                elevation: 4,
                                borderRadius: BorderRadius.circular(20),
                                child: TextField(
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "R\$",
                                    hintStyle:GoogleFonts.crimsonText(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10)),

                        //SEGUNDO CAMPO
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "DÓLAR",
                              style: GoogleFonts.crimsonText(color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 16.0),
                              // style: TextStyle(
                              //     color: Colors.white38,
                              //     fontWeight: FontWeight.bold,
                              //     fontSize: 18.0),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            SizedBox(
                              width: 200,
                              height: 40,
                              child: Material(
                                color: Color(0xFF44445a),
                                elevation: 4,
                                borderRadius: BorderRadius.circular(20),
                                child: TextField(
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "\$",
                                    hintStyle: GoogleFonts.crimsonText(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 17.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
