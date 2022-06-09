import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
void main() {
  runApp(HitalWeather());
}
class HitalWeather extends StatefulWidget {
  const HitalWeather({Key? key}) : super(key: key);
  @override
  _HitalWeatherState createState() => _HitalWeatherState();
}
class _HitalWeatherState extends State<HitalWeather> {

  final txtName = TextEditingController();
  bool isLoad = false;
  var infoWeather ;
  Future<dynamic> getWeather(String name) async{
    var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$name&units=metric&appid=26fb19f31886a051bed3294c2aef2040");
    var response = await http.get(url,);
    infoWeather = json.decode(response.body);
    print(infoWeather);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Theme(
        data: ThemeData(fontFamily: "YekanBakh"),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xFFF7F7F7),
              body: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: const Color(0xFFA8FFF9),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(30)
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Image.asset("assets/images/weather.png",width: 30,),
                            const SizedBox(width: 10,),
                            const Text("هواشناسی",style: TextStyle(
                                fontSize: 20,fontWeight: FontWeight.w900,
                                color: Color(0xFF4E4E4E)
                            ),),
                            const Spacer(),
                            const Text("HITALDEV",style: TextStyle(
                                fontSize: 13,fontWeight: FontWeight.w900,
                                color: Color(0xFF4E4E4E)
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: txtName,
                        decoration: InputDecoration(isDense: true,
                          contentPadding: const EdgeInsets.
                          symmetric(vertical: 15,horizontal: 8),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "نام شهر خود را وارد کنید",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.transparent),
                            borderRadius:  BorderRadius.circular(10),
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.transparent),
                            borderRadius:  BorderRadius.circular(10),
                          ),
                          hintStyle: const TextStyle(fontSize: 13),
                          suffixIcon: isLoad ?
                              const CircularProgressIndicator()
                              : GestureDetector(
                            onTap: () {
                              setState(() {
                                isLoad = true;
                              });
                              getWeather(txtName.text).then((value) {
                                setState(() {
                                  isLoad = false;
                                });
                              });
                            },
                            child: const Icon(
                              CupertinoIcons.search,size: 30,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  infoWeather == null || infoWeather["cod"] == "404" ? Container():
                  SizedBox(
                    width: 250,
                    child: Column(
                      children: [
                        Text(infoWeather["main"]["temp"].toString(),style: const TextStyle(
                            fontSize: 50,fontWeight: FontWeight.w900,
                            color: Color(0xFF4E4E4E)
                        ),),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.up_arrow,color: Colors.red,),
                            const Text("بیشترین دما",style: TextStyle(
                                fontSize: 20,fontWeight: FontWeight.bold
                            ),),
                            const Spacer(),
                            Text("${infoWeather["main"]["temp_max"]} درجه "
                              ,style: const TextStyle(
                                  fontSize: 20,fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B8A82)
                              ),),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          width: double.infinity, height: 1, color: Colors.black38,
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.arrow_down,color: Colors.blue,),
                            const Text("کمترین دما",style: TextStyle(
                                fontSize: 20,fontWeight: FontWeight.bold
                            ),),
                            const Spacer(),
                            Text("${infoWeather["main"]["temp_min"]} درجه "
                              ,style: const TextStyle(
                                  fontSize: 20,fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B8A82)
                              ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
