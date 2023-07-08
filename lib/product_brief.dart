

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_app/sql_helper.dart';
import 'package:showcaseview/showcaseview.dart';


//   enum FilterOptions { byTitle, bySubtitle, byDate, byStock }

// bool _showInStockOnly = false;
// FilterOptions _selectedFilter = FilterOptions.byTitle;

class ProductBrief extends StatefulWidget {

  
  // const ProductBrief({Key key}) : super(key: key);

  @override
  State<ProductBrief> createState() => _ProductBriefState();
}

class _ProductBriefState extends State<ProductBrief> {

// void _showFilterOptionsDialog() {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text("Filter Options"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             RadioListTile<FilterOptions>(
//               title: const Text("By Title"),
//               value: FilterOptions.byTitle,
//               groupValue: _selectedFilter,
//               onChanged: (FilterOptions? value) {
//                 setState(() {
//                   _selectedFilter = value!;
//                 });
//               },
//             ),
//             RadioListTile<FilterOptions>(
//               title: const Text("By Subtitle"),
//               value: FilterOptions.bySubtitle,
//               groupValue: _selectedFilter,
//               onChanged: (FilterOptions? value) {
//                 setState(() {
//                   _selectedFilter = value!;
//                 });
//               },
//             ),
//             RadioListTile<FilterOptions>(
//               title: const Text("By Date"),
//               value: FilterOptions.byDate,
//               groupValue: _selectedFilter,
//               onChanged: (FilterOptions? value) {
//                 setState(() {
//                   _selectedFilter = value!;
//                 });
//               },
//             ),
//             CheckboxListTile(
//               title: const Text("In Stock Only"),
//               value: _showInStockOnly,
//               onChanged: (bool? value) {
//                 setState(() {
//                   _showInStockOnly = value!;
//                 });
//               },
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               // Apply the selected filters here by updating the product list
//               _applyFilters();
//             },
//             child: const Text("Apply"),
//           ),
//         ],
//       );
//     },
//   );
// }

// void _applyFilters() {
//   setState(() {
//     if (_selectedFilter == FilterOptions.byTitle) {
//       _searchResults.sort((a, b) => a['title'].compareTo(b['title']));
//     } else if (_selectedFilter == FilterOptions.bySubtitle) {
//       _searchResults.sort((a, b) => a['subtitle'].compareTo(b['subtitle']));
//     } else if (_selectedFilter == FilterOptions.byDate) {
//       _searchResults.sort((a, b) => DateTime.parse(a['createdDate']).compareTo(DateTime.parse(b['createdDate'])));
//     }

//     if (_showInStockOnly) {
//   _searchResults = _searchResults.where((product) => product['stock'] == true).toList();
// }
//   });
// }

final List<String> items = [
  'In Stock / True',
  'Stock Out / False',
  "All Products"
];
String? selectedValue;

  String _selectedOption = "By Title";

  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sort By"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  title: Text("By Title"),
                  selected: _selectedOption == "By Title",
                  onTap: () {
                    setState(() {
                      _selectedOption = "By Title";
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("By Subtitle"),
                  selected: _selectedOption == "By Subtitle",
                  onTap: () {
                    setState(() {
                      _selectedOption = "By Subtitle";
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("By Date"),
                  selected: _selectedOption == "By Date",
                  onTap: () {
                    setState(() {
                      _selectedOption = "By Date";
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("By Stock"),
                  selected: _selectedOption == "By Stock",
                  onTap: () {
                    setState(() {
                      _selectedOption = "By Stock";
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),

        );
      },
    );
  }


  final _controller = TextEditingController();

    final _day = TextEditingController();
    final _month = TextEditingController();
    final _year = TextEditingController();

GlobalKey _one = GlobalKey();


  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = true;



  void getData() async {

    final data = await SQLHelper.getProducts();
    setState(() {
      _products = data;
      _searchResults = data;
      _isLoading = false;

    });
  }

  void initState() {
    super.initState();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
  ShowCaseWidget.of(context).startShowCase([_one]),
);
  }

  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }


void _searchProducts(String query) {
  setState(() {
    if (query.isEmpty) {
      _searchResults = _products;
    } else {
      if (_selectedOption == "By Title") {
        _searchResults = _products
            .where((product) => product['title']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      } else if (_selectedOption == "By Subtitle") {
        _searchResults = _products
            .where((product) => product['subtitle']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      } 

      // }
      else if (_selectedOption == "By Date") {
// final formattedDate = DateFormat('dd MMM, yyyy').format(query);
        _searchResults = _products
            .where((product) => product['createdDate']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      } 
        else if (_selectedOption == "By Stock") {
             _searchResults = _products
            .where((product) => product['stock']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Color(0xffF2F6FE),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 31,
                      width: 31,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff1479FF),
                            blurRadius: 70, 
                            offset: Offset(5, 20), 
                            spreadRadius: 0.1, 
                            blurStyle: BlurStyle.normal, 
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "lib/icons/icn2.png",
                          fit: BoxFit.fitHeight,
                          height: 11.84,
                          width: 6.95,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Products",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                       color: Color(0xff152358)),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(70)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff1479FF), 
                          blurRadius: 70,
                          offset: Offset(5, 20),
                          spreadRadius: 0.1, 
                          blurStyle: BlurStyle.normal, 
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "lib/icons/notification.png",
                        fit: BoxFit.fill,
                        height: 42,
                        width: 42,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  height: 178,
                  width: 310,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    "lib/icons/sergel-intro.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _selectedOption == "By Title" || _selectedOption == "By Subtitle"? Container(
                        height: 46,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffC0D2EA),
                              offset: Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 8.0,
                              spreadRadius: 10.0,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _controller,
                          onChanged: _searchProducts,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Search here...",
                            hintStyle: GoogleFonts.raleway(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Image.asset("lib/icons/search-icn.png"),
                            suffixIcon: IconButton(
                              icon: Image.asset(
                                "lib/icons/delete-icn.png",
                                fit: BoxFit.fill,
                                height: 18,
                              ),
                              onPressed: () { 
                                _controller.clear();
                              
                              _searchProducts('');
                              },
                            ),
                          ),
                        ),
                      ):_selectedOption == "By Stock" ?
                      Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
              if (value == "In Stock / True") {
               _searchProducts("1");
              }else if(value == "Stock Out / False"){
_searchProducts("0");
              }else{
                 _searchProducts("");
              }
            });
          },
          buttonStyleData:  ButtonStyleData(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            width:MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow:const [
                            BoxShadow(
                              color: Color(0xffC0D2EA),
                              offset: Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 8.0,
                              spreadRadius: 6.0,
                            ),
                          ],
            )
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Container(
                             decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffC0D2EA),
                              offset: Offset(
                                5.0,
                                5.0,
                              ),
                        blurRadius: 14.0,
                              spreadRadius: 5.0,
                            ),
                          ],
                        ),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _day,
                                 decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "DD",
                              hintStyle: GoogleFonts.raleway(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            
                                                      ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 50,
                              child: Container(
                                decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffC0D2EA),
                              offset: Offset(
                                5.0,
                                5.0,
                              ),
                                  blurRadius: 14.0,
                              spreadRadius: 5.0,
                            ),
                          ],
                        ),
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                  controller: _month,
                                   decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "MM",
                                hintStyle: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                                        
                                                          ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Container(
                              decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffC0D2EA),
                              offset: Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 14.0,
                              spreadRadius: 5.0,
                            ),
                          ],
                        ),
                              child: TextField(
                                  keyboardType: TextInputType.number,
                                controller: _year,
                                 decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "YYYY",
                              hintStyle: GoogleFonts.raleway(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            
                                                      ),
                              ),
                            ),
                     

                          ),
                                 IconButton(
                                 
                              icon: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  "lib/icons/search-icn.png",
                                  fit: BoxFit.fill,
                                  height: 18,
                                ),
                              ),
                              onPressed: () { 
                            if (_day.text.isNotEmpty && _month.text.isNotEmpty && _year.text.isNotEmpty) {
                                     int day = int.parse(_day.text);
              int month = int.parse(_month.text);
              int year = int.parse(_year.text);

              var formattedDate = DateFormat('dd MMM, yyyy').format(DateTime(year, month,day ));
   // final formattedDate = DateFormat('dd MMM, yyyy').format(query);
                              _searchProducts(formattedDate);
                            }
                              },
                              
                            ),
                               IconButton(
                                 color: Colors.white,
                              icon: Image.asset(
                                "lib/icons/delete-icn.png",
                                fit: BoxFit.fill,
                                height: 20,
                              ),
                              onPressed: () { 
                                _day.clear();
                                _month.clear();
                                _year.clear();
                              _searchProducts("");
                              },
                              
                            ),
                        ],
                      )
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Showcase(
                      key: _one,
                      description: "For advance search use this",
                      child: InkWell(
                        onTap: () {
                          _showPopup();
                          // _showFilterOptionsDialog();
                          //here I want to create a pop up box and all filter options
                        },
                        child: Container( 
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff1479FF),
                          ),
                          child: Image.asset("lib/icons/menu.png"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: _searchResults.isEmpty
                    ? const Center(
                        child: Text(
                          "No results found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    : ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Container(
                        height: 109,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                _searchResults[index]["image"],
                                height: 70,
                                width: 70,
                                fit: BoxFit.fill),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _searchResults[index]["title"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xff152358),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _searchResults[index]["subtitle"],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff5C5F8A),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Row(
                                      children: [
                                        Image.asset("lib/icons/clock.png"),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            _searchResults[index]["createdDate"],

                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff5C5F8A),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(50, 50, 0, 0),
                                child: SizedBox(
                                  width: 90,
                                  child: TextButton(
                                    onPressed: null,
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xff26D7AC)),
                                    ),
                                    child: const Text(
                                      "Guideline",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: DotNavigationBar(
            backgroundColor: Color(0xffFCFDFF),
            currentIndex: _SelectedTab.values.indexOf(_selectedTab),
            onTap: _handleIndexChanged,
            dotIndicatorColor: Colors.transparent,
            marginR: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffC0D2EA),
                offset: Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 10.0,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ],
            paddingR: const EdgeInsets.only(bottom: 0, top: 0),
            items: [
              /// Home
              DotNavigationBarItem(
                icon: Image.asset(
                  "lib/icons/home.png",
                  height: 36,
                ),
              ),

              /// Profile
              DotNavigationBarItem(
                icon: Image.asset("lib/icons/user-profile.png"),
              ),
            ],
          ),
        ),
      );
    }
  }

enum _SelectedTab { home, profile }
