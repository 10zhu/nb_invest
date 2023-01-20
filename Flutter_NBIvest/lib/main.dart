import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

import './startWelCome.dart';
// import './chip.dart';
// import './company.dart';
// void main() {
//   runApp(MyApp());
// }

void main() => runApp(
  MaterialApp(initialRoute: '/',
    routes:{
      "/": (context) {
        return StartWelCome();
      },
      "/quiz": (context) {
        return MyApp();
      },
      // "/chip":(context){
      //   return ChipApp();
      // },
      // "/":(context){
      //   return ChipApp();
      // },

    },)
    );

class MyApp extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': 'What is your age?',
      'answers': [
        {'text': '16 ~ 30', 'score': 5,'gscore': 0},
        {'text': '31 ~ 45', 'score': 15,'gscore': 0},
        {'text': '46 ~ 60', 'score': 10,'gscore': 0},
        {'text': 'Age 60 and above', 'score': 0,'gscore': 0},
      ],
    },
    {
      'questionText': 'What are your main sources of income? ',
      'answers': [
        {'text': 'Wages and remuneration', 'score': 5,'gscore': 0},
        {'text': 'Production and operation', 'score': 10,'gscore': 0},
        {'text': 'Financial assets such as interest, dividends, and transfer', 'score': 15,'gscore': 0},
        {'text': 'No fixed income', 'score': 0,'gscore': 0},
      ],
    },
    {
      'questionText': 'What is your household disposable annual income?',
      'answers': [
        {'text': 'Less than \$50,000', 'score': 0,'gscore': 0},
        {'text': '\$50,000 ~ \$100,000', 'score': 5,'gscore': 0},
        {'text': '\$100,000 ~ \$200,000', 'score': 10,'gscore': 0},
        {'text': 'More than \$200,000', 'score': 15,'gscore': 0},
      ],
    },
    {
      'questionText': 'The proportion of your annual income that can be used for investment?',
      'answers': [
        {'text': 'Less than 10%', 'score': 0,'gscore': 0},
        {'text': '10% to 25%', 'score': 5,'gscore': 0},
        {'text': '25% to 50%', 'score': 10,'gscore': 0},
        {'text': 'More than 50%', 'score':15 ,'gscore': 0},
      ],
    },
    {
      'questionText': 'Do you have any debts of a large amount? If so, the nature of these debts is?',
      'answers': [
        {'text': 'No ', 'score': 15,'gscore': 0},
        {'text': 'Yes, long-term fixed debt(eg. housing mortgage)', 'score': 5,'gscore': 0},
        {'text': 'Yes, short-term credit debts(eg. credit card debt, consumer credit)', 'score': 0,'gscore': 0},
        {'text': 'Yes, loans from relatives and friends', 'score': 10,'gscore': 0},
      ],
    },
    {
      //??????????
      'questionText': 'If you already win \$5,000 at a casion, would you enter a lotery where you have 50% lose everything or 50% chance to win \$10,000 ?',
      'answers': [
        {'text': '0%-20% likely', 'score': 0,'gscore': 0},
        {'text': '20%-40% likely', 'score': 0,'gscore': 5},
        {'text': '40-60% likely', 'score': 0,'gscore': 10},
        {'text': 'More than 60% likely', 'score': 0,'gscore': 15},
      ],
    },
    {
      'questionText': 'What is the maximum investment loss you think you can bear?',
      'answers': [
        {'text': ' Within 10%', 'score': 0,'gscore': 0},
        {'text': '10%-30%', 'score': 5,'gscore': 0},
        {'text': '30%-50%', 'score': 10,'gscore': 0},
        {'text': 'More than 50% ', 'score': 15,'gscore': 0},
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;
  var _totalgScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _totalgScore = 0;
    });
  }

  void _answerQuestion(int score, int gscore) {
    // var aBool = true;
    // aBool = false;

    _totalScore += score;
    _totalgScore += gscore;
    double _totalScoreD = _totalScore/90;
    double _totalgScoreD = _totalgScore/15;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    print(_totalScoreD);
    print(_totalgScoreD);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');

    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    // var dummy = const ['Hello'];
    // dummy.add('Max');
    // print(dummy);
    // dummy = [];
    // questions = []; // does not work if questions is a const

    return MaterialApp(

      home: Scaffold(
        // drawer: SideDrawer(),
        appBar: AppBar(
          title: Text('No-Brainer Investment'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
          answerQuestion: _answerQuestion,
          questionIndex: _questionIndex,
          questions: _questions,
        )
            : Result(_totalScore,_totalgScore, _resetQuiz),
      ),
    );

    //
  }
}

//
// enum ExerciseFilter { walking, running, cycling, hiking }
// class ChipApp extends StatelessWidget {
//   const ChipApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//           colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
//       home: const FilterChipExample(),
//     );
//   }
// }
//
// class FilterChipExample extends StatefulWidget {
//   const FilterChipExample({super.key});
//
//   @override
//   State<FilterChipExample> createState() => _FilterChipExampleState();
// }
//
// class _FilterChipExampleState extends State<FilterChipExample> {
//   bool favorite = false;
//   final List<String> _filters = <String>[];
//
//   @override
//   Widget build(BuildContext context) {
//     final TextTheme textTheme = Theme.of(context).textTheme;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FilterChip Sample'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Choose an execise', style: textTheme.labelLarge),
//             const SizedBox(height: 5.0),
//             Wrap(
//               spacing: 5.0,
//               children: ExerciseFilter.values.map((ExerciseFilter exercise) {
//                 return FilterChip(
//                   label: Text(exercise.name),
//                   selected: _filters.contains(exercise.name),
//                   onSelected: (bool value) {
//                     setState(() {
//                       if (value) {
//                         if (!_filters.contains(exercise.name)) {
//                           _filters.add(exercise.name);
//                         }
//                       } else {
//                         _filters.removeWhere((String name) {
//                           return name == exercise.name;
//                         });
//                       }
//                     });
//                   },
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 10.0),
//             Text('Looking for: ${_filters.join(', ')}')
//           ],
//         ),
//       ),
//     );
//   }
// }

