import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  static List<String> buttons = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
    '(',
    ')',
    'sin',
    'cos',
    'tan'
  ];
  static List<String> operators = [
    '+',
    '-',
    '*',
    '/',
    'del',
    'C',
    '^',
    '%',
    '!',
    '='
  ];
  TextEditingController exp = TextEditingController();
  TextEditingController ans = TextEditingController();
  bool isEvaluated = false;
  @override
  void initState() {
    // TODO: implement initState
    exp.text = "00";
    ans.text = "00";
    super.initState();
  }

  void handleTap(String char, {bool isOperator = false}) {
    switch (char) {
      case 'del':
        if (exp.text == "00") {
          return;
        }
        if (exp.text.isNotEmpty) {
          exp.text = exp.text.substring(0, exp.text.length - 1);
        }
        if (exp.text.isEmpty) {
          exp.text = "00";
          ans.text = "00";
        }
        break;
      case 'C':
        if (exp.text == "00") {
          return;
        }
        exp.clear();
        ans.clear();
        ans.text = "00";
        exp.text = "00";
        break;
      case '=':
        String char = exp.text;
        if (exp.text == "00" ||
            char == "+" ||
            char == "-" ||
            char == "*" ||
            char == "/") {
          return;
        }
        evaluate();
        isEvaluated = false;
        break;
      default:
        if (isOperator) {
          if (char == exp.text.characters.last) {
            return;
          }
          String lastOparetor = exp.text.characters.last;
          if (lastOparetor == '*' ||
              lastOparetor == '+' ||
              lastOparetor == '-' ||
              lastOparetor == '/') {
            int lastIndex = exp.text.length - 1;

            exp.text = exp.text.substring(0, exp.text.length - 1);

            // return;
          }
        }
        if (exp.text == "00") {
          exp.clear();
          exp.text += char;
        } else {
          if (ans.text != "00" && !isEvaluated) {
            exp.clear();
            if (ans.text != "0.0") {
              exp.text = ans.text + char;
            } else {
              exp.text = char;
            }

            isEvaluated = true;
          } else {
            exp.text += char;
          }
        }
    }
    setState(() {});
  }

  void evaluate() {
    try {
      Parser parse = Parser();
      Expression expression = parse.parse(exp.text);
      ContextModel cm = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, cm);
      ans.text = result.toString();
    } catch (e) {
      ("exception occured $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: ListView(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
                  alignment: Alignment.bottomRight,
                  constraints: const BoxConstraints(
                    minHeight: 200,
                    maxHeight: 250,
                    minWidth: double.infinity,
                  ),
                  decoration: BoxDecoration(border: Border.all()),
                  child: Text(
                    exp.text,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Text(
                      ans.text,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 60,
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6),
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      handleTap(buttons[index]);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black)),
                      child: Text(
                        buttons[index],
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                })),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: operators.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 60,
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6),
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      handleTap(operators[index], isOperator: true);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: operators[index] == '='
                              ? Colors.green
                              : Colors.blue,
                          border: Border.all(width: 2, color: Colors.black)),
                      child: Text(
                        operators[index],
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }
}
