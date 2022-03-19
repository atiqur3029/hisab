

import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hisab/controlar/db_helper.dart';
import 'package:hisab/model/add_transection.dart';
import 'package:hisab/model_class/transaction_model.dart';
import 'package:hisab/theme/theme.dart' as Static;
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controlar/db_helper.dart';
import '../widget/confirm_dialog.dart';
import 'dart:async';

class Incomeexpenses extends StatefulWidget {

   const Incomeexpenses({Key? key}) : super(key: key);

  @override
  _IncomeexpensesState createState() => _IncomeexpensesState();
}

class _IncomeexpensesState extends State<Incomeexpenses> {
  DBhelper  dBhelper = DBhelper();
  List<FlSpot>  dataSet = [];
  DateTime? today = DateTime.now();
  SharedPreferences? preferences;
  Box ? box;
  DateTime now = DateTime.now();
  int  index=1;


  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  int totalsaving =0;

  //List <FlSpot> dataSet=[];
  //List<FlSpot> getPlotPoints){

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



  List<FlSpot> getPlotPoints(List<TransactionModel>? entireData) {
    dataSet = [];
    List tempdataSet = [];

    for (TransactionModel item in entireData!) {
      if (item.date.month == today?.month && item.type == "Expense") {
        tempdataSet.add(item);
      }
    }

    // Sorting the list as per the date
    tempdataSet.sort((a, b) => a.date.day.compareTo(b.date.day));

    for (var i = 0; i < tempdataSet.length; i++) {
      dataSet.add(
        FlSpot(
          tempdataSet[i].date.day.toDouble(),
          tempdataSet[i].amount.toDouble(),
        ),
      );
    }
    return dataSet;
  }

  getTotalBalance(List<TransactionModel>entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    totalsaving =0;
    //
    for (TransactionModel data in entireData) {
      if (data.date.month == today?.month) {
        if (data.type == "Expense") {
          totalBalance -= data.amount;
          totalExpense += data.amount;
          totalsaving=totalBalance;


        } else {

          totalBalance += data.amount;
          totalIncome += data.amount;
          totalsaving=totalIncome-totalExpense;


        }


      }


    }
  }

  Future getPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<List<TransactionModel>> fetch() async {
    if (box!.values.isEmpty) {
      return Future.value([]);
    } else {
      List<TransactionModel> items = [];
      box?.toMap().values.forEach((element) {
        items.add(
          TransactionModel(element['amount'] as int, element['date'],
              element['note'], element['type']),
        );
      });

      return items;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreference();
    box = Hive.box('money');
    fetch();
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.cyanAccent,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Addtransection()))
                .whenComplete(() {
              setState(() {});
            });
          },
          child: Icon(
            Icons.add,
            size: 32,
          ),
        ),
      ),
      body: FutureBuilder<List<TransactionModel>>(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            getTotalBalance(snapshot.data!);
            getPlotPoints(snapshot.data!);
            return ListView(
              children: [
                Padding(
                  padding:  EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Container(
                                //padding: EdgeInsets.all(value)

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 80,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Center(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                       "My Profile",
          // "${preferences?.getString('name')}"
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Static.PrimaryMaterialColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                              selectMonth()!,
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                Container(

                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.all(12.0),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 13, vertical: 18),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(colors: [
                          Static.PrimaryMaterialColor,
                          Colors.blueAccent,
                        ])),
                    child: Column(
                      children: [
                        Text(
                          "Total Balance",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            "Taka $totalBalance",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cardIncome(totalIncome.toString()),
                                SizedBox(height:10),
                                cardExpenses(totalExpense.toString()),
                                SizedBox(height:10),
                                Savingcard(totalsaving.toString()),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(12.0),
                  child: Text(
                    "Expenses",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87),
                  ),
                ),
                dataSet.length < 2
                    ? SingleChildScrollView(
                     scrollDirection: Axis.vertical,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 40,
                          ),
                          margin: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          //height: 400.h,
                          child: Text("No Enough Data")),
                    )

                    : Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12.0,
                        ),
                        margin: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(

                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ]),
                        height: 400,
                        child: LineChart(LineChartData(
                            borderData: FlBorderData(
                              show: false,
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                  spots: getPlotPoints(snapshot.data!),
                                  isCurved: false,
                                  barWidth: 2.5,
                                  colors: [
                                    Static.PrimaryMaterialColor,
                                  ],
                                showingIndicators: [200,200,90,10],
                                dotData: FlDotData(
                                  show: true,
                                )

                              ),
                            ],
                        ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Recent Income and Expenses List",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        TransactionModel dataindex;

                        try{
                          dataindex=snapshot.data! [index];

                        }catch(e){
                          return Container();

                        }
                        if (dataindex.type == "Income") {
                          return IncomeTile(
                              dataindex.amount, dataindex.note, dataindex.date,index);
                        } else {
                          return ExpenceTile(
                              dataindex.amount, dataindex.note, dataindex.date,index);
                        }
                      }),
                ),

                SizedBox(
                  height: 70,
                ),
              ],
            );

          }

          return Center(
            child: Text(snapshot.error.toString()),
          );
        },
      ),


    );
  }


  Widget Savingcard(String  type) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_upward,
            size: 28,
            color: Colors.greenAccent[700],
          ),
          margin: EdgeInsets.only(right: 8),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saving',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[400]),
            ),
            Text(
              type.toString(),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.white70),
            ),
          ],
        )
      ],
    );
  }
  Widget cardIncome(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_upward,
            size: 28,
            color: Colors.greenAccent[700],
          ),
          margin: EdgeInsets.only(right: 8),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[400]),
            ),
            Text(
              value.toString(),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.white70),
            ),
          ],
        )
      ],
    );
  }

  Widget cardExpenses(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_downward,
            size: 28,
            color: Colors.redAccent[700],
          ),
          margin: EdgeInsets.only(right: 8),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Expense',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(

                  value.toString(),
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white70),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget ExpenceTile(int value, String note, DateTime date,int index) {
    return InkWell(

      onLongPress: ()async{
        bool? answer=await showConfirmDialog(context,"WARNING","Do you want to delete this?");

        if(answer !=null && answer){
          await dBhelper.deleteData(index);
          setState(() {

          });

        }

      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_circle_down_outlined,
                        size: 29,
                        color: Colors.red[700],
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Expense",
                        style: TextStyle(fontSize: 20,color: Colors.red[800]),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  // Text(
                  //   "Expense",
                  //   style: TextStyle(fontSize: 20.sp),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      "${date.day} ${months[date.month - 1]} ${date.year}",
                      style: TextStyle(color: Colors.red[700]),
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      "-$value ",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      note,
                      style: TextStyle(fontSize: 20, color: Colors.tealAccent),
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget IncomeTile(int value, String note, DateTime date,int index) {
    return InkWell(
      onLongPress: () async{
        bool? answer=await showConfirmDialog(context, "WARNING", "Do you want to delete this?");
        if(answer!=null && answer ){
          await dBhelper.deleteData(index);
          setState(() {

          });
        }



      },
      child: Container(
        width: 200,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_circle_up_outlined,
                        size: 29,
                        color: Colors.green[700],
                      ),
                      SizedBox(width: 8,),
                      Text(
                        "Income",
                        style: TextStyle(fontSize: 20,color:Colors.lightGreenAccent),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      "${date.day} ${months[date.month - 1]} ${date.year}",
                      style: TextStyle(color: Colors.red[700]),
                    ),
                  ),

                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      "+$value ",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      note,
                      style: TextStyle(fontSize: 20, color: Colors.tealAccent),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }






  Widget? selectMonth() {
    return Padding(
      padding: EdgeInsets.all(
        8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                index = 3;
                today = DateTime(now.year, now.month - 2, today!.day);
              });
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                color: index == 3 ? Static.PrimaryMaterialColor : Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                months[now.month - 3],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: index == 3 ? Colors.white : Static.PrimaryMaterialColor,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                index = 2;
                today = DateTime(now.year, now.month - 1, today!.day);
              });
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                color: index == 2 ? Static.PrimaryMaterialColor : Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                months[now.month - 2],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: index == 2 ? Colors.white : Static.PrimaryMaterialColor,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                index = 1;
                today = DateTime.now();
              });
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                color: index == 1 ? Static.PrimaryMaterialColor : Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                months[now.month - 1],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: index == 1 ? Colors.white : Static.PrimaryMaterialColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


