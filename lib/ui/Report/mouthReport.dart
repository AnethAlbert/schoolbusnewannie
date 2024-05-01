import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;

class mouthReportClass extends StatefulWidget {
  const mouthReportClass({Key? key}) : super(key: key);

  @override
  State<mouthReportClass> createState() => _mouthReportClassState();
}

class _mouthReportClassState extends State<mouthReportClass> {

  TableRow _tableRow =const TableRow(
    children: [
      Padding(padding: EdgeInsets.all(2.0),
      child: Text("no"),),

      Padding(padding: EdgeInsets.all(2.0),
        child: Text("Name"),),

      Padding(padding: EdgeInsets.all(2.0),
        child: Text("Absent"),),

      Padding(padding: EdgeInsets.all(2.0),
        child: Text("Dism"),),

      Padding(padding: EdgeInsets.all(2.0),
        child: Text("Present"),),

      Padding(padding: EdgeInsets.all(2.0),
        child: Text("%"),)

    ]
  );
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 6,
                          child: Container(
                             // color: Colors.blue,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        'https://png.pngtree.com/png-vector/20211011/ourmid/pngtree-school-logo-png-image_3977360.png'), // You can replace this with the URL of your avatar image
                                  ),
                                  SizedBox(width: 16.0),
                                  // Adjust the spacing between the avatar and the username
                                  Text(
                                    'Keifo Primary School',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            //color: Colors.grey,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Ionicons.ios_search,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Ionicons.ios_alert,),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 50.0, right: 50.0, bottom: 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 30,
                    child: Container(
                      color: Colors.white,
                      child: Center(child: Text("Class Attendacy Summary")),
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(
                    top: 12.0, left: 50.0, right: 50.0, bottom: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 200,
                    child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Class  :",style: TextStyle(fontSize: 19),),
                                  Text(" Class 1-B")
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Trip  :",style: TextStyle(fontSize: 19),),
                                  Text(" Trip number 6")
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Head Teacher  :",style: TextStyle(fontSize: 19),),
                                  Text(" Ekonia Damas")
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Date  :",style: TextStyle(fontSize: 19),),
                                  Text(" 31 January 2024 ")
                                ],
                              ),
                            )

                          ],
                        ),
                        ),
                  ),
                )),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 5.0, right: 5.0, bottom: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 750,
                    height: double.infinity,
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: [
                            DataColumn(
                              label: Container( // Wrap in a Container to set width
                                //width: 90, // Set your desired width
                                child: Text(
                                  'Student Name',
                                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                'A',
                                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'D',
                                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'P',
                                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '%',
                                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('P.Joshua')),
                              DataCell(Text('14')),
                              DataCell(Text('1')),
                              DataCell(Text('15')),
                              DataCell(Text('50%')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('A.Mayele')),
                              DataCell(Text('5')),
                              DataCell(Text('5')),
                              DataCell(Text('20')),
                              DataCell(Text('65%')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('E.Damas')),
                              DataCell(Text('0')),
                              DataCell(Text('0')),
                              DataCell(Text('31')),
                              DataCell(Text('100%')),
                            ]),
                            // Add more rows as needed
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

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


//////////////////////////////////////dataTable
//   child:SingleChildScrollView(
//   scrollDirection: Axis.vertical,
//   child: Expanded(
//     child: DataTable(
//       columns: [
//         DataColumn(
//           label: Text(
//             'No',
//             style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
//           ),
//         ),
//         DataColumn(
//           label: Text(
//             'Student Name',
//             style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
//           ),
//         ),
//         DataColumn(
//           label: Text(
//             'A',
//             style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
//           ),
//         ),
//         DataColumn(
//           label: Text(
//             'D',
//             style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
//           ),
//         ),
//         DataColumn(
//           label: Text(
//             'P',
//             style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
//           ),
//         ),
//         DataColumn(
//           label: Text(
//             '%',
//             style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
//           ),
//         ),
//
//       ],
//       rows: [
//         DataRow(cells: [
//           DataCell(Text('1', style: TextStyle(fontSize: 10.0))),
//           DataCell(Text('Prisca Joshua', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('A', style: TextStyle(fontSize: 10.0))),
//           DataCell(Text('A', style: TextStyle(fontSize: 10.0))),
//           DataCell(Text('A', style: TextStyle(fontSize: 10.0))),
//           DataCell(Text('A', style: TextStyle(fontSize: 10.0))),
//         ]),
//         DataRow(cells: [
//           DataCell(Text('2', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('Aika Mayele', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
//         ]),
//         DataRow(cells: [
//           DataCell(Text('3', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('Enock Damas', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
//         ]),
//         DataRow(cells: [
//           DataCell(Text('4', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('Musa Masud', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('p', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
//           DataCell(Text('A', style: TextStyle(fontSize: 16.0))),
//
//         ]),
//         DataRow(cells: [
//           DataCell(Text('6')),
//           DataCell(Text('Sadiki')),
//           DataCell(Text('p')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//
//         ]),
//         DataRow(cells: [
//           DataCell(Text('6')),
//           DataCell(Text('imma imma')),
//           DataCell(Text('p')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//
//         ]),
//         DataRow(cells: [
//           DataCell(Text('7')),
//           DataCell(Text('alii amis')),
//           DataCell(Text('p')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//
//         ]),
//         DataRow(cells: [
//           DataCell(Text('7')),
//           DataCell(Text('Zabroni semu')),
//           DataCell(Text('p')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//
//         ]),
//         DataRow(cells: [
//           DataCell(Text('8')),
//           DataCell(Text('Attanasio Sabas')),
//           DataCell(Text('p')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//
//         ]),
//         DataRow(cells: [
//           DataCell(Text('9')),
//           DataCell(Text('Asajile uwezo')),
//           DataCell(Text('p')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//
//         ]),
//
//         DataRow(cells: [
//           DataCell(Text('10')),
//           DataCell(Text('Musa Masud')),
//           DataCell(Text('p')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//           DataCell(Text('A')),
//
//         ]),
//
//         // Add more rows as needed
//       ],
//     ),
//   ),
// ),