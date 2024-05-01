import 'package:flutter/material.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;

class weekklyAttendacyClass extends StatefulWidget {
  const weekklyAttendacyClass({Key? key}) : super(key: key);

  @override
  State<weekklyAttendacyClass> createState() => _weekklyAttendacyClassState();
}

class _weekklyAttendacyClassState extends State<weekklyAttendacyClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.Colors.loginGradientStart,
              Theme.Colors.loginGradientEnd,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          //rmainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 5,
              child: Container(
                child: Card(
                  elevation: 2.0,
                  // color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 350,
                      height: 200,
                      child: Container(
                        child: Scaffold(
                          appBar: AppBar(
                            title: Text('Keifo Primary School'),
                            centerTitle: true,
                          ),
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      child: Text(
                                        "Weekly Attendacy Report",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text("Class : One - B"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                  "Teacher : Ambangile Mwakichovya"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Text("Week Of  : 01"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //////////second card/////////////
            Container(
              child: Card(
                elevation: 22.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: double.infinity,
                      height: 430,
                      child: Scaffold(
                        // appBar: AppBar(
                        //   title: Text('Your Table'),
                        // ),
                        body: FittedBox(
                          fit: BoxFit.contain,
                          child: Container(
                            width: 600,
                            height: 500,
                            // Set the desired width
                            child:SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      'No',
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Student Name',
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'M',
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'T',
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'W',
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Th',
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'F',
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                                rows: [
                                  DataRow(cells: [
                                    DataCell(Text('1', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('Prisca Joshua', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('2', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('Aika Mayele', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('3', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('Enock Damas', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('4', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('Musa Masud', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
                                    DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('6')),
                                    DataCell(Text('Sadiki')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('6')),
                                    DataCell(Text('imma imma')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('7')),
                                    DataCell(Text('alii amis')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('7')),
                                    DataCell(Text('Zabroni semu')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('8')),
                                    DataCell(Text('Attanasio Sabas')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('9')),
                                    DataCell(Text('Asajile uwezo')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),

                                  DataRow(cells: [
                                    DataCell(Text('10')),
                                    DataCell(Text('Musa Masud')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),

                                  DataRow(cells: [
                                    DataCell(Text('10')),
                                    DataCell(Text('Musa Masud')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),

                                  DataRow(cells: [
                                    DataCell(Text('10')),
                                    DataCell(Text('Musa Masud')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),

                                  DataRow(cells: [
                                    DataCell(Text('10')),
                                    DataCell(Text('Musa Masud')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('10')),
                                    DataCell(Text('Musa Masud')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('10')),
                                    DataCell(Text('Musa Masud')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('10')),
                                    DataCell(Text('Musa Masud')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('10')),
                                    DataCell(Text('Musa Masud')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),

                                  DataRow(cells: [
                                    DataCell(Text('10')),
                                    DataCell(Text('Musa Masud')),
                                    DataCell(Text('p')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                    DataCell(Text('A')),
                                  ]),






                                  // Add more rows as needed
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
