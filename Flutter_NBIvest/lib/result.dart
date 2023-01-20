import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final int resultgScore;
  final VoidCallback resetHandler;

  Result(this.resultScore, this.resultgScore,this.resetHandler);

  String get resultPhrase {
    String resultText;
    // if (resultScore <= 8) {
    //   resultText = 'You are awesome and innocent!';
    // } else if (resultScore <= 12) {
    //   resultText = 'Pretty likeable!';
    // } else if (resultScore <= 16) {
    //   resultText = 'You are ... strange?!';
    // } else {
    //   resultText = 'You are so bad!';
    // }
    resultText = 'You have finished the questionnaire!';
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          // Image(
          //   image:AssetImage('assets/google.png'),
          // ),
          TextButton(
            child: Text(
              'Restart Quiz!',
            ),
            // textColor: Colors.blue,
            onPressed: resetHandler,
          ),
          // ElevatedButton(
          //     onPressed: (){
          //       Navigator.pushNamed(context, '/chip');
          //     },
          //     child: const Text('Investment Options')),

          ElevatedButton(
              onPressed: (){
                // Navigator.pushNamed(context, '/chip');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChipApp()),
                );
              },
              child: const Text('Investment Options')),

        ],
      ),
    );

  }
}

enum ExerciseFilter { Google, Tesla, META, Amozon, CNY_FOREX, INR_FOREX }
class ChipApp extends StatelessWidget {
  const ChipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: const FilterChipExample(),
    );
  }
}

class FilterChipExample extends StatefulWidget {
  const FilterChipExample({super.key});

  @override
  State<FilterChipExample> createState() => _FilterChipExampleState();
}

class _FilterChipExampleState extends State<FilterChipExample> {
  bool favorite = false;
  final List<String> _filters = <String>[];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('No-Brainer Investment'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Choose your portfolio', style: textTheme.labelLarge),
            const SizedBox(height: 5.0),
            Wrap(
              spacing: 5.0,
              children: ExerciseFilter.values.map((ExerciseFilter exercise) {
                return FilterChip(
                  label: Text(exercise.name),
                  selected: _filters.contains(exercise.name),
                  onSelected: (bool value) {
                    setState(() {
                      if (value) {
                        if (!_filters.contains(exercise.name)) {
                          _filters.add(exercise.name);
                        }
                      } else {
                        _filters.removeWhere((String name) {
                          return name == exercise.name;
                        });
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
            Text('Looking for: ${_filters.join(', ')}'),
            ElevatedButton(
                onPressed: (){
                  // Navigator.pushNamed(context, '/chip');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ResultIMG()),
                  );
                },
                child: const Text('Submit')),
          ],
        ),
      ),
    );
  }
}

class ResultIMG extends StatelessWidget {
  const ResultIMG({super.key});




  @override
  Widget build(BuildContext context) {

    // return Center(
    //   child: Column(
    //     children: <Widget>[
    //       Text(
    //         resultPhrase,
    //         style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    //         textAlign: TextAlign.center,
    //       ),
    //
    //       Image(
    //         image:AssetImage('assets/google.png'),
    //       ),
    //
    //       // ElevatedButton(
    //       //     onPressed: (){
    //       //       Navigator.pushNamed(context, '/chip');
    //       //     },
    //       //     child: const Text('Investment Options')),
    //
    //       ElevatedButton(
    //           onPressed: (){
    //             // Navigator.pushNamed(context, '/chip');
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => const ChipApp()),
    //             );
    //           },
    //           child: const Text('Next')),
    //
    //     ],
    //   ),
    // );

    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('No-Brainer Investment'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        // children: <Widget>[
        //   // Container(
        //   //   // margin: EdgeInsets.only(top: DeviceInfo.padding + 10.0),
        //   //   alignment: Alignment.center,
        //   //   // child: LogoStack(),
        //   // ),
        //   Container(
        //     height: 319.0,
        //     width: 325.0,
        //     padding: EdgeInsets.only(left: 20.0, right: 20.0),
        //     child: Column(
        //       children: <Widget>[
        //         Text(
        //           "Here is your report!     ",
        //           style: TextStyle(
        //               fontFamily: "SF-UI-Display-Regular",
        //               fontSize: 28.0,
        //               height: 1.2,
        //               color: Color.fromRGBO(24, 29, 40, 1)
        //           ),
        //         ),
        //
        //       ],
        //     ),
        //   ),
        //   Image.asset(
        //       'assets/google.png',
        //       scale:3.4
        //
        //         // image:AssetImage('assets/google.png'),
        //   ),
        //   ElevatedButton(
        //       onPressed: (){
        //         Navigator.pushNamed(context, '/quiz');
        //       },
        //       child: const Text('START')),
        //
        // ],

        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text(
          //   "Here is your report!",
          //         style: TextStyle(
          //             fontFamily: "SF-UI-Display-Regular",
          //             fontSize: 28.0,
          //             height: 1.2,
          //             color: Color.fromRGBO(24, 29, 40, 1)
          //         ),
          // ),
          Container(
            margin: EdgeInsets.zero,

    //       decoration: BoxDecoration(
    //           border: Border.all(width:0.5), // 0.1 to 0.9
    //       color: Colors.yellow,
    //       borderRadius: BorderRadius.circular(20.0),
    // ),

      child: Image.asset(
              // 'assets/google.png', width: 100.0, height: 100.0,
              'assets/google.png', width: 100.0, height: 60.0,

            ),
            // margin: EdgeInsets.symmetric(horizontal: 100.0 *0.1, vertical: 60.0 *0.05),


          ),
          // Container(
          //   margin: EdgeInsets.zero,
          //   // margin: EdgeInsets.only(top: 1),
          //   // margin: EdgeInsets.only(top:5),
          //   child: Image.asset(
          //     'assets/GOOG.png', width: 400.0, height: 300.0,
          //     // 'assets/meta.png', width: 100.0, height: 100.0,
          //   ),
          //   // margin: EdgeInsets.symmetric(horizontal: 100.0 *0.1, vertical: 60.0 *0.05),
          //
          // ),
          //

          Image.asset(
            'assets/GOOG.png', width: 400.0, height: 200.0,
            // 'assets/meta.png', width: 100.0, height: 100.0,
          ),

          Text(
            "Worst Case:   ",
            // "Best Case: We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.26, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 216.93",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 15.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),
          Text(
            "We calculated that the probability the daily return goes BELOW -3.8 % is upper bounded by 0.16, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -178.43     ",
            // "Best Case: We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.26, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 216.93",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 12.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),
          Text(
            // "Worst Case: We calculated that the probability the daily return goes BELOW -3.8 % is upper bounded by 0.16, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -178.43     ",
            "Best Case: ",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 15.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),Text(
            // "Worst Case: We calculated that the probability the daily return goes BELOW -3.8 % is upper bounded by 0.16, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -178.43     ",
            "We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.26, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 216.93",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 12.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),

          Image.asset(
            // 'assets/google.png', width: 100.0, height: 100.0,
            'assets/green.jpg', width: 50.0, height: 80.0,
          ),

          // Image.asset(
          //   // 'assets/google.png', width: 100.0, height: 100.0,
          //   'assets/meta.png', width: 100.0, height: 100.0,
          // ),
        //   Image.asset(
        //     // 'assets/google.png', width: 100.0, height: 100.0,
        //     'assets/tesla.png', width: 100.0, height: 100.0,
        //   ),
        //   Image.asset(
        //     // 'assets/google.png', width: 100.0, height: 100.0,
        //     'assets/amazon.png', width: 100.0, height: 100.0,
        //   ),
          ElevatedButton(
              onPressed: (){
                // Navigator.pushNamed(context, '/chip');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MetaIMG()),
                );
              },
              child: const Text('Next')),
        ],

      ),
    );
  }
}

class MetaIMG extends StatelessWidget {
  const MetaIMG({super.key});

  String get resultPhrase {
    appBar: AppBar(
      title: Text('No-Brainer Investment'),
      centerTitle: true,
      backgroundColor: Colors.deepPurpleAccent,
    );
    String resultText;

    resultText = 'Here is your report!';

    return resultText;
  }

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

        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Image.asset(
            'assets/meta.png', width: 100.0, height: 60.0,
            // 'assets/meta.png', width: 100.0, height: 100.0,
          ),
          Image.asset(
            'assets/metare.png', width: 400.0, height: 200.0,
            // 'assets/meta.png', width: 100.0, height: 100.0,
          ),
          Text(
            "Worst Case:   ",
            // "Best Case: We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.26, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 216.93",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 15.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),

        Text(
          "We calculated that the probability the daily return goes BELOW -12.16 % is upper bounded by 0.21, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -827.79",
          // "Best Case: We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.26, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 216.93",
          style: TextStyle(
              fontFamily: "SF-UI-Display-Regular",
              fontSize: 12.0,
              height: 1.0,
              color: Color.fromRGBO(24, 29, 40, 1)
          ),
        ),
        Text(
          // "Worst Case: We calculated that the probability the daily return goes BELOW -3.8 % is upper bounded by 0.16, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -178.43     ",
          "Best Case: ",
          style: TextStyle(
              fontFamily: "SF-UI-Display-Regular",
              fontSize: 15.0,
              height: 1.0,
              color: Color.fromRGBO(24, 29, 40, 1)
          ),
        ),Text(
      // "Worst Case: We calculated that the probability the daily return goes BELOW -3.8 % is upper bounded by 0.16, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -178.43     ",
      "We calculated that the probability the daily return goes ABOVE 5.94 % is upper bounded by 0.32, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 404.37",
      style: TextStyle(
          fontFamily: "SF-UI-Display-Regular",
          fontSize: 12.0,
          height: 1.0,
          color: Color.fromRGBO(24, 29, 40, 1)
      ),
    ),

        Image.asset(
          // 'assets/google.png', width: 100.0, height: 100.0,
          'assets/yellow.jpg', width: 50.0, height: 80.0,
        ),

          ElevatedButton(
              onPressed: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AmazonIMG()),
                );
              },
              child: const Text('Next')),
        ],

      ),
    );
  }
}

class AmazonIMG extends StatelessWidget {
  const AmazonIMG({super.key});

  String get resultPhrase {
    appBar: AppBar(
      title: Text('No-Brainer Investment'),
      centerTitle: true,
      backgroundColor: Colors.deepPurpleAccent,
    );
    String resultText;

    resultText = 'Here is your report!';

    return resultText;
  }

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

        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/amazon.png', width: 100.0, height: 60.0,
            // 'assets/meta.png', width: 100.0, height: 100.0,
          ),
          Image.asset(
            'assets/AMZN.png', width: 400.0, height: 200.0,
            // 'assets/meta.png', width: 100.0, height: 100.0,
          ),
          Text(
            "Worst Case:   ",
            // "Best Case: We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.26, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 216.93",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 15.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),

          Text(
            "We calculated that the probability the daily return goes BELOW -2.66 % is upper bounded by 0.45, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -124.59",
            // "Best Case: We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.26, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 216.93",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 12.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),
          Text(
            // "Worst Case: We calculated that the probability the daily return goes BELOW -3.8 % is upper bounded by 0.16, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -178.43     ",
            "Best Case: ",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 15.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),Text(
            // "Worst Case: We calculated that the probability the daily return goes BELOW -3.8 % is upper bounded by 0.16, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -178.43     ",
            "We calculated that the probability the daily return goes ABOVE 6.6 % is upper bounded by 0.18, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 309.14",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 12.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),

          Image.asset(
            // 'assets/google.png', width: 100.0, height: 100.0,
            'assets/yellow.jpg', width: 50.0, height: 80.0,
          ),

          ElevatedButton(
              onPressed: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TeslaIMG()),
                );
              },
              child: const Text('Next')),
        ],

      ),
    );
  }
}

class TeslaIMG extends StatelessWidget {
  const TeslaIMG({super.key});

  String get resultPhrase {
    appBar: AppBar(
      title: Text('No-Brainer Investment'),
      centerTitle: true,
      backgroundColor: Colors.deepPurpleAccent,
    );
    String resultText;

    resultText = 'Here is your report!';

    return resultText;
  }

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

        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Image.asset(
            'assets/tesla.png', width: 100.0, height: 60.0,
            // 'assets/meta.png', width: 100.0, height: 100.0,
          ),
          Image.asset(
            'assets/TSLA.png', width: 400.0, height: 200.0,
            // 'assets/meta.png', width: 100.0, height: 100.0,
          ),
          Text(
            "Worst Case:   ",
            // "Best Case: We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.26, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 216.93",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 15.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),

          Text(
            "We calculated that the probability the daily return goes BELOW -4.94 % is upper bounded by 0.38, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -314.11",// "Best Case: We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.26, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 216.93",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 12.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),
          Text(
            // "Worst Case: We calculated that the probability the daily return goes BELOW -3.8 % is upper bounded by 0.16, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -178.43     ",
            "Best Case: ",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 15.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),Text(
            // "Worst Case: We calculated that the probability the daily return goes BELOW -3.8 % is upper bounded by 0.16, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -178.43     ",
            "We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.29, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 293.76",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 12.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),

          Image.asset(
            // 'assets/google.png', width: 100.0, height: 100.0,
            'assets/yellow.jpg', width: 50.0, height: 80.0,
          ),

          ElevatedButton(
              onPressed: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CNYIMG()),
                );
              },
              child: const Text('Next')),
        ],

      ),
    );
  }
}

class CNYIMG extends StatelessWidget {
  const CNYIMG({super.key});

  String get resultPhrase {
    appBar: AppBar(
      title: Text('No-Brainer Investment'),
      centerTitle: true,
      backgroundColor: Colors.deepPurpleAccent,
    );
    String resultText;

    resultText = 'Here is your report!';

    return resultText;
  }

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


        children: <Widget>[
          Image.asset(
            'assets/cny.png', width: 100.0, height: 60.0,
            // 'assets/meta.png', width: 100.0, height: 100.0,
          ),
          Image.asset(
            'assets/CNYre.png', width: 400.0, height: 200.0,
            // 'assets/meta.png', width: 100.0, height: 100.0,
          ),
          Text(
            "Worst Case:   ",
            // "Best Case: We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.26, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 216.93",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 15.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),

          Text(
            "We calculated that the probability the daily return goes BELOW -1.14 % is upper bounded by 0.1, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -25.22",// "Best Case: We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.26, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 216.93",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 12.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),
          Text(
            // "Worst Case: We calculated that the probability the daily return goes BELOW -3.8 % is upper bounded by 0.16, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -178.43     ",
            "Best Case: ",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 15.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),Text(
            // "Worst Case: We calculated that the probability the daily return goes BELOW -3.8 % is upper bounded by 0.16, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -178.43     ",
            "We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.07, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 102.22",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 12.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),

          Image.asset(
            // 'assets/google.png', width: 100.0, height: 100.0,
            'assets/yellow.jpg', width: 50.0, height: 80.0,
          ),

          ElevatedButton(
              onPressed: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const INRIMG()),
                );
              },
              child: const Text('Next')),
        ],

      ),
    );
  }
}


class INRIMG extends StatelessWidget {
  const INRIMG({super.key});

  String get resultPhrase {
    appBar: AppBar(
      title: Text('No-Brainer Investment'),
      centerTitle: true,
      backgroundColor: Colors.deepPurpleAccent,
    );
    String resultText;

    resultText = 'Here is your report!';

    return resultText;
  }

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

        children: <Widget>[
          Image.asset(
            'assets/inr.png', width: 100.0, height: 60.0,
            // 'assets/meta.png', width: 100.0, height: 100.0,
          ),
          Image.asset(
            'assets/INRre.png', width: 400.0, height: 200.0,
            // 'assets/meta.png', width: 100.0, height: 100.0,
          ),
          Text(
            "Worst Case:   ",
            // "Best Case: We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.26, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 216.93",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 15.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),

          Text(
            "We calculated that the probability the daily return goes BELOW -13.3 % is upper bounded by 0.21, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -259.35",// "Best Case: We calculated that the probability the daily return goes ABOVE 4.62 % is upper bounded by 0.26, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 216.93",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 12.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),
          Text(
            // "Worst Case: We calculated that the probability the daily return goes BELOW -3.8 % is upper bounded by 0.16, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -178.43     ",
            "Best Case: ",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 15.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),Text(
            // "Worst Case: We calculated that the probability the daily return goes BELOW -3.8 % is upper bounded by 0.16, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your maximum acceptable probability is 0.19. Based on the return threshold, your worst-case loss is \$ -178.43     ",
            "We calculated that the probability the daily return goes ABOVE 3.96 % is upper bounded by 0.52, where the threshold on daily return is predicted based on your questionnaire. We also predicted based on the questionnaire that your minimum acceptable probability is 0.17. Based on the return threshold, your best-case return is \$ 77.22",
            style: TextStyle(
                fontFamily: "SF-UI-Display-Regular",
                fontSize: 12.0,
                height: 1.0,
                color: Color.fromRGBO(24, 29, 40, 1)
            ),
          ),

          Image.asset(
            // 'assets/google.png', width: 100.0, height: 100.0,
            'assets/yellow.jpg', width: 50.0, height: 80.0,
          ),

          ElevatedButton(
              onPressed: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const INRIMG()),
                );
              },
              child: const Text('FINAL')),
        ],

      ),
    );
  }
}