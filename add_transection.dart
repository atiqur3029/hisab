import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hisab/theme/theme.dart' as Static;

import '../controlar/db_helper.dart';

class Addtransection extends StatefulWidget {
  const Addtransection({Key? key}) : super(key: key);

  @override
  _AddtransectionState createState() => _AddtransectionState();
}

class _AddtransectionState extends State<Addtransection> {
  int? amount;
  String note = "Some Expenses";
  String type = "Income";
  DateTime setselectedate = DateTime.now();
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  Future<void> _setselectedate(BuildContext context) async {
    final DateTime? picker = await showDatePicker(
      context: context,
      initialDate: setselectedate,
      firstDate: DateTime(2021, 12),
      lastDate: DateTime(2200, 01),
    );
    if (picker != null && picker != setselectedate) {
      setState(() {
        setselectedate = picker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          SizedBox(height: 20,),
          const Text(
            'Add Transaction',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.cyanAccent,
                ),
                width: 40,
                height: 40,
                child: Image.asset('images/1200px_taka.png'),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '0',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  onChanged: (val) {
                    try {
                      amount = int.parse(val);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                duration: Duration(
                                  seconds: 2,
                                ),
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      "Enter only Numbers as Amount",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }


                    },
                  inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        // textAlign: TextAlign.center,
                      ),
                    ),




            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.cyanAccent,
                ),
                width: 40,
                height: 40,
                child: const Icon(Icons.description),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Note on Transaction',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  onChanged: (val) {
                    note = val;
                  },
                  keyboardType: TextInputType.text,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.yellowAccent,
                ),
                width: 40,
                height: 40,
                child: const Icon(Icons.moving_sharp),
              ),
              SizedBox(
                width: 10.0,
              ),
              ChoiceChip(
                label: Text(
                  'Income',
                  style: TextStyle(fontSize: 16,
                      color: type == "Income" ? Colors.white : Colors.black),
                ),
                selectedColor: Static.PrimaryMaterialColor,
                selected: type == "Income" ? true : false,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Income";
                    });
                  }
                },
              ),

              SizedBox(
                width: 25,
              ),
              ChoiceChip(
                label: Text(
                  'Expense',
                  style: TextStyle(fontSize: 16,
                      color: type == "Income" ? Colors.black : Colors.white),
                ),
                selectedColor: Static.PrimaryMaterialColor,
                selected: type == "Expense" ? true : false,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Expense";
                    });
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 50,
              child: TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero)),
                onPressed: () {
                  _setselectedate(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      size: 24,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "${setselectedate.day} ${months[setselectedate.month -
                          1]}",
                      style: TextStyle(
                        fontSize: 16,

                      ),
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (amount != null && note.isNotEmpty) {
                    DBhelper dbhelper = DBhelper();
                    dbhelper.addData(amount!, setselectedate, note, type);
                    Navigator.of(context).pop();
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red[700],
                            content: Text(
                              "Please enter a valid Amount !",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                  },

                child: Text(
                  "Add",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )),
        ],
      ),
    );
  }


}
