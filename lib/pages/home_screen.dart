import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/logic/metrics_helper.dart';
import 'package:untitled/components/button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _inputController = TextEditingController();

  String? _result = '';

  final FocusNode _focusNode = FocusNode();

  String? _dropDownValueFrom = 'm';
  String? _dropDownValueTo = 'm';

  final _items = MetricsHelper.metricSystems.keys;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Metrics Converter',
              style: TextStyle(
                fontSize: 40,
                color: Colors.blue,
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Number:',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 175,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: TextField(
                            focusNode: _focusNode,
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            controller: _inputController,
                            decoration: InputDecoration(
                                filled: true,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                fillColor: Colors.blue,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: deviceSize.width * 0.8,
                    height: deviceSize.width * 0.8,
                    // margin: const EdgeInsets.all(40.0),
                    decoration: const BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'From:',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: DropdownButton(
                                value: _dropDownValueFrom,
                                icon:
                                    const Icon(Icons.keyboard_arrow_down_sharp),
                                items: _items.map((String items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: const TextStyle(
                                          fontSize: 25,
                                          color: Colors.blue,
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _dropDownValueFrom = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.symmetric(vertical: 15)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'To:',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Text('km')

                            Container(
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: DropdownButton(
                                value: _dropDownValueTo,
                                icon:
                                    const Icon(Icons.keyboard_arrow_down_sharp),
                                items: _items.map((String items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: const TextStyle(
                                          fontSize: 25,
                                          color: Colors.blue,
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _dropDownValueTo = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Result:',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        width: 175,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue),
                        child: Text(
                          '$_result',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                  Column(
                    children: [
                      CustomButton(
                        text: 'CONVERT',
                        action: () {
                          setState(() {
                            if (double.tryParse(_inputController.text) !=
                                null) {
                              _result = MetricsHelper()
                                  .convertTo(
                                      double.parse(_inputController.text),
                                      _dropDownValueFrom!,
                                      _dropDownValueTo!)
                                  .toString();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter valid number!'),
                                ),
                              );
                            }
                          });
                        },
                      ),
                      CustomButton(
                        text: 'RESET',
                        action: () {
                          setState(() {
                            _focusNode.unfocus();
                            _inputController.clear();
                            _dropDownValueFrom = 'm';
                            _dropDownValueTo = 'm';
                            _result = '';
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
