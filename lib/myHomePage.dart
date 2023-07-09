
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:my_app/product_brief.dart';
import 'package:my_app/sql_helper.dart';
import 'package:showcaseview/showcaseview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Map<String, dynamic>> _sliders = [];
  bool _isLoading = true;

  void getData() async {
    final data = await SQLHelper.getItems();
    setState(() {
_sliders = data;

 _isLoading = false;
    });
  }



 void initState() {
    super.initState();

    getData();
     // Loading the diary when the app starts
  }





  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i){
    setState(() {
       _selectedTab =  _SelectedTab.values[i];
    });
  }




  @override
  Widget build(BuildContext context) {
double number = MediaQuery.of(context).size.width /70;

    return  SafeArea(
      maintainBottomViewPadding : false,
      child: Scaffold(
        
        extendBody: true,
      backgroundColor: const Color(0xffF2F6FE),
        body:   Padding(
          padding: const EdgeInsets.all(15),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const Text("Hi, Rakib Hasan", style: TextStyle(
                fontWeight: FontWeight.w600
               ),),
             Container(
    
             decoration: const BoxDecoration(
              // color: Colors.white,
               borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow:  [
                BoxShadow(
                    color: Color(0xff1479FF), // shadow color
                    blurRadius: 50, // shadow radius
                    offset: Offset(0, 30), // shadow offset
                    spreadRadius:
                        0.1, // The amount the box should be inflated prior to applying the blur
                    blurStyle: BlurStyle.normal // set blur style
                    ),]
             ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("lib/icons/notification.png", fit: BoxFit.fill, height: 42, width: 42,),
                ),),
             ],),
             Expanded(
              // height: 300,
               child: ListView(
                
                children: [
                  const Text("BPL", style: TextStyle(
                fontSize: 36,
                color: Color(0xff284596),
                     fontWeight: FontWeight.bold
               ),),
               const Text("E-ducare", style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xff284596)
                     
               ),),
                     SizedBox(
                       height: 25,
                     ),
               _isLoading? const Center(child: CircularProgressIndicator(

               ),) 
               :FlutterCarousel(
                     options: CarouselOptions(
                       height: 150.0, 
                      //  aspectRatio: 16/9,
                       viewportFraction: 1,
                       showIndicator: true,
                     floatingIndicator: false,
                       slideIndicator:  const CircularSlideIndicator(
                        itemSpacing: 15,
                        indicatorRadius: 4,
                        currentIndicatorColor: Color(0xff1479FF),
                        indicatorBackgroundColor: Color(0xffB4C7DE)
                       ),
                     ),
                     items: _sliders.map((i) {
                       return Builder(
                     builder: (BuildContext context) {
                       return Container(
                         width: MediaQuery.of(context).size.width,
                         // height: MediaQuery.of(context).size.height ,
                         margin: const EdgeInsets.symmetric(horizontal: 5.0),
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                         child: Image.network(i["image"], fit: BoxFit.cover,)
                       );
                     },
                       );
                     }).toList(),
                     ),
                 
                     SizedBox(
                       
                     height: 400,
                     child:   GridView.count(
                       physics: NeverScrollableScrollPhysics(),
                     
                       primary: false,
                     
                       padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                     
                       crossAxisSpacing: number,
                     
                       mainAxisSpacing: number,
                     
                       crossAxisCount: 3,
                     
                       children: <Widget>[
                     
                     InkWell(
                      onTap: () => Navigator.push(
    context,
    CupertinoPageRoute(builder: (context) =>ShowCaseWidget(
  builder: Builder(
    builder : (context)=>ProductBrief()),
  ),)),
                       child: Container(
                                      margin: EdgeInsets.all(6),
                        height: 90.46,
                        width: 102,
                         
                        decoration: const BoxDecoration(
                       color: Color(0xff62CEF9),
                       borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                         child:  Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           
                           children: [
                                     Image.asset("lib/icons/new-productb.png"),
                                     const Text("Product Brief", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)
                           ],
                         )
                       
                       ),
                     ),
                     
                     
                     Container(
                     margin: EdgeInsets.all(6),
                      height: 90.46,
                      width: 102,  
                      decoration: const BoxDecoration(
                     color: Color(0xff4AC989),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                       child:  Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         
                         children: [
                Image.asset("lib/icons/sticky-notes.png"),
                const Text("Memo/Circular", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)
                         ],
                       )
                     
                     ),
                     
                     
                     Container(
                     margin: EdgeInsets.all(6),
                      height: 90.46,
                      width: 102,  
                      decoration: const BoxDecoration(
                     color: Color(0xffA28EEC),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                       child:  Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         
                         children: [
                Image.asset("lib/icons/visual-thinkingb.png"),
                const Text("Digital WPM", style: TextStyle(color: Colors.white,  fontWeight: FontWeight.w700),)
                         ],
                       )
                     
                     ),
                     
                     Container(
                     margin: EdgeInsets.all(6),
                      height: 90.46,
                      width: 102,  
                      decoration: const BoxDecoration(
                     color: Color(0xffFF7070),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                       child:  Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         
                         children: [
                Image.asset("lib/icons/survey.png"),
                const Text("Survey", style: TextStyle(color: Colors.white,  fontWeight: FontWeight.w700),)
                         ],
                       )
                     
                     ),
                     
                     
                     
                     Container(
                     margin: EdgeInsets.all(6),
                      height: 90.46,
                      width: 102,  
                      decoration: const BoxDecoration(
                     color: Color(0xffECAC4A),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                       child:  Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         
                         children: [
                Image.asset("lib/icons/quizb.png"),
                const Text("Exam/Quiz", style: TextStyle(color: Colors.white,  fontWeight: FontWeight.w700),)
                         ],
                       )
                     
                     ),
                     
                     Container(
                     margin: EdgeInsets.all(6),
                      height: 90.46,
                      width: 102,  
                      decoration: const BoxDecoration(
                     color: Color(0xffFB80BA),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                       child:  Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         
                         children: [
                Image.asset("lib/icons/marketinfffg.png"),
                const Text("Campaign", style: TextStyle(color: Colors.white,  fontWeight: FontWeight.w700),)
                         ],
                       )
                     
                     ),
                Container(
                     margin: EdgeInsets.all(6),
                      height: 90.46,
                      width: 102,  
                      decoration: const BoxDecoration(
                     color: Color(0xff62CEF9),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                       child:  Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         
                         children: [
                Image.asset("lib/icons/feedback.png"),
                const Text("Feedback", style: TextStyle(color: Colors.white,  fontWeight: FontWeight.w700),)
                         ],
                       )
                     
                     ),
                Container(
                     margin: EdgeInsets.all(6),
                      height: 90.46,
                      width: 102,  
                      decoration: const BoxDecoration(
                     color: Color(0xff4AC989),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                       child:  Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         
                         children: [
                Image.asset("lib/icons/continuous.png"),
                const Text("Cycle Plan", style: TextStyle(color: Colors.white,  fontWeight: FontWeight.w700),)
                         ],
                       )
                     
                     ),
                Container(
                     margin: EdgeInsets.all(6),
                      height: 90.46,
                      width: 102,  
                      decoration: const BoxDecoration(
                     color: Color(0xffFB80BA),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                       child:  Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         
                         children: [
                Image.asset("lib/icons/message.png"),
                const Text("Notice", style: TextStyle(color: Colors.white,  fontWeight: FontWeight.w700),)
                         ],
                       )
                     
                     ),
                     
                       ],
                     
                     ),
                     )
                ],
               ),
             )
        
        
            ],
          ),
          
        ),
     bottomNavigationBar:  DotNavigationBar(
      backgroundColor: Color(0xffFCFDFF),
            currentIndex: _SelectedTab.values.indexOf(_selectedTab),
            onTap: _handleIndexChanged,
            dotIndicatorColor: Colors.transparent,
            marginR :const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            boxShadow: const [  BoxShadow(
                        color: Color(0xffC0D2EA),
                        offset:  Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 10.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset:  Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ),],
    paddingR :const EdgeInsets.only(bottom: 0, top: 0),
            items: [
              /// Home
              DotNavigationBarItem(
                icon: Image.asset("lib/icons/home.png", height: 36,),
          
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

enum _SelectedTab {home, profile}