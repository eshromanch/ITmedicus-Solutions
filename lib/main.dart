
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/myHomePage.dart';


void main ()async {
  WidgetsFlutterBinding.ensureInitialized();

// List<dynamic> sampleData = [
//   {
    
//       "title": "Sergel",
//       "subtitle": "Esomeprazole",
//       'image': "https://www.hplbd.com/products/Sergel_Tablet-20-mg.jpg",
//       // 'createdDate': DateTime.now().toString(),
//       'stock': 1
      
// },
//    {
    
//       "title": "Denvar DS",
//       "subtitle": "Cefixime",
//       'image': "hhttps://cdn.shopify.com/s/files/1/0595/9417/8768/products/7501298216409.jpg?v=1668652057",
//       // 'createdDate': DateTime.now().toString(),
//       'stock': 0
      
// },


// ];

// for (var i = 0; i < sampleData.length; i++) {
//   print(sampleData[i]["createdDate"]);
//   await SQLHelper.createProducts(sampleData[i]["title"],sampleData[i]["subtitle"],sampleData[i]["image"],sampleData[i]["stock"]);
// }

// for (var i = 0; i < sampleData.length; i++) {
//   // print(sampleData[i]["title"]);
//   await SQLHelper.createProducts(sampleData[i]);
// }

//  final data = await SQLHelper.getProducts();
//  print(data);

//       List<String> sampleImageUrls = [
//       'https://images.pexels.com/photos/3652097/pexels-photo-3652097.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//       'https://images.pexels.com/photos/2280571/pexels-photo-2280571.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//       "https://images.pexels.com/photos/4033148/pexels-photo-4033148.jpeg?auto=compress&cs=tinysrgb&w=1600"
//     ];
// for (String imageUrl in sampleImageUrls) {
//       await SQLHelper.createItem(imageUrl);
//     }

//     

//   WidgetsFlutterBinding.ensureInitialized();
//       List<int> sampleImageUrls = [
//       11,12,13,14,15
//     ];
// for (int imageUrl in sampleImageUrls) {
//       await SQLHelper.deleteItem(imageUrl);
//     }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        useMaterial3: true,
        textTheme: GoogleFonts.barlowTextTheme(
          Theme.of(context).textTheme
        )
      ),
      home: const MyHomePage(title: ''),
      debugShowCheckedModeBanner: false,
    );
  }
}

