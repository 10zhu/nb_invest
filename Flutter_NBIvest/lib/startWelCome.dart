import 'dart:math';
import 'package:flutter/material.dart';

// START
class StartWelCome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('No-Brainer Investment'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: DeviceInfo.padding + 10.0),
            alignment: Alignment.center,
            // child: LogoStack(),
          ),
          Container(
            height: 319.0,
            width: 325.0,
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Hello, welcome!          "
                      "   I am your investment brain.",
                  style: TextStyle(
                      fontFamily: "SF-UI-Display-Regular",
                      fontSize: 28.0,
                      height: 1.2,
                      color: Color.fromRGBO(24, 29, 40, 1)
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    "I'd like to give you some finance advice.",
                    style: TextStyle(
                        fontFamily: "SF-UI-Display-Regular",
                        fontSize: 28.0,
                        height: 1.2,
                        color: Color.fromRGBO(24, 29, 40, 1)
                    ),
                  ),
                )
              ],
            ),
          ),
          Image.asset(
            // 'assets/google.png', width: 100.0, height: 100.0,
            'assets/NBInvest.jpeg', width: 150.0, height: 100.0,
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/quiz');
              },
              child: const Text('START')),

        ],
      ),
    );
  }
}



//
// // What do you love?
// class StartWelComeOne extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.only(top: DeviceInfo.padding),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.only(bottom: 13.0, top: 15.0),
//                   child: Text(
//                     "What do you love?",
//                     style: TextStyle(
//                         fontSize: 28.0,
//                         color: Color.fromRGBO(24, 29, 40, 0.87),
//                         fontFamily: "SF-UI-Display-Regular"
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pushReplacement(
//                         FadeRoute(StartWelComeTwo())
//                     );
//                   },
//                   icon: Text(
//                     "skip",
//                     style: TextStyle(
//                         fontSize: 15.0,
//                         color: Color.fromRGBO(84, 102, 174, 1),
//                         fontFamily: "SF-UI-Display-Regular"
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Container(
//                   height: 390.0,
//                   width: 521,
//                   margin: EdgeInsets.only(bottom: 0.0, left: 24.0, right: 24.0),
//                   child: TypeCheck()
//               )
//           ),
//           MyHeroButton(
//             title: "NEXT",
//             tag: 'STARTWELCOM',
//             callBack: (){
//               Navigator.of(context).pushReplacement(
//               FadeRoute(StartWelComeTwo())
//               );
//               }
//           )
//         ],
//       ),
//     );
//   }
// }

// // Complete!
// class Complete extends StatelessWidget {
//   final sqlLites = new SqlLite();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: <Color>[Color.fromRGBO(28, 224, 218, 1), Color.fromRGBO(71, 157, 228, 1)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Hero(
//               tag: 'WELCOMEOK',
//               child: Container(
//                 child: Text(
//                   "Complete!",
//                   style: TextStyle(
//                       fontFamily: "SF-UI-Display-Regular",
//                       fontSize: 28.0,
//                       color: Colors.white,
//                       decoration: TextDecoration.none
//                   ),
//                 ),
//               ),
//             ),
//
//             Column(
//               children: <Widget>[
//                 Image.asset("assets/images/aura.png"),
//                 Container(
//                   margin: EdgeInsets.only(top: 41.0),
//                   child: Text(
//                     "Rebel",
//                     style: TextStyle(
//                         fontFamily: "SF-UI-Display-Semibold",
//                         fontSize: 30.0,
//                         color: Colors.white,
//                         decoration: TextDecoration.none
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 284.0,
//                   padding: EdgeInsets.all(10.0),
//                   margin: EdgeInsets.only(bottom: 100.0),
//                   child: Text(
//                     "You are an energetic and purposeful person who needs downhole guitar reefs.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontFamily: "SF-UI-Display-Regular",
//                         fontSize: 15.0,
//                         color: Colors.white,
//                         decoration: TextDecoration.none
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//                 child: FlatButton(
//                   onPressed: () async {
//                     // 开启数据库
//                     await sqlLites.open();
//                     // 修改账户状态，不再是首次使用该程序
//                     await sqlLites.db.update("loginState", {"first": 0});
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, '/main', (route) => route == null);
//                   },
//                   splashColor: Color.fromRGBO(255, 255, 255, 0.35),
//                   highlightColor: Colors.transparent,
//                   child: Text(
//                     "VIEW RECOMMENDATIONS",
//                     style: TextStyle(
//                         fontFamily: "SF-UI-Display-Regular",
//                         fontSize: 18.0,
//                         color: Colors.white,
//                         decoration: TextDecoration.none
//                     ),
//                   ),
//                 )
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
