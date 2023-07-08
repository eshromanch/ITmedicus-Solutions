
// import 'package:flutter/foundation.dart';
// import 'package:sqflite/sqflite.dart' as sql;

// class SQLHelper {
//   static Future<void> createTables(sql.Database database) async {
//     await database.execute("""CREATE TABLE banner(
//         id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//         image TEXT
//       )
//       """);
//   }

//   static Future<void> createTablesForProducts(sql.Database database) async {
//     await database.execute("""CREATE TABLE products(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         title TEXT,
//         subtitle TEXT,
//         image TEXT,
//         createdDate TEXT,
//         stock INTEGER
//       )
//       """);
//   }

//   static Future<sql.Database> db() async {
//     final databasePath = await sql.getDatabasesPath();
//     final path = '$databasePath/mydb.db';

//     return sql.openDatabase(
//       path,
//       version: 1,
//       onCreate: (sql.Database database, int version) async {
//         await createTables(database);
//         await createTablesForProducts(database);
//       },
//     );
//   }

//   static Future<int> createItem(String image) async {
//     final db = await SQLHelper.db();

//     final data = {'image': image};
//     final id = await db.insert('banner', data,
//         conflictAlgorithm: sql.ConflictAlgorithm.replace);
//     return id;
//   }

//   static Future<List<Map<String, dynamic>>> getItems() async {
//     final db = await SQLHelper.db();
//     return db.query('banner', orderBy: "id");
//   }

//   static Future<int> createProducts(
//       String image, String title, String subtitle, int stock,) async {
//     final db = await SQLHelper.db();

//     final data = {
//       "title": title,
//       "subtitle": subtitle,
//       'image': image,
//       'createdDate': "06 Jun, 2023",
//       'stock': stock
//     };
//     final id = await db.insert('products', data,
//         conflictAlgorithm: sql.ConflictAlgorithm.replace);
//     return id;
//   }

//   static Future<List<Map<String, dynamic>>> getProducts() async {
//     final db = await SQLHelper.db();
//     return db.query('products', orderBy: "id");
//   }
// }


import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE banner(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        image TEXT
      )
      """);
  }

  static Future<void> createTablesForProducts(sql.Database database) async {
    await database.execute("""CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        subtitle TEXT,
        image TEXT,
        createdDate TEXT,
        stock INTEGER
      )
      """);
  }

  static Future<sql.Database> db() async {
final databasePath = await sql.getDatabasesPath();
    final dbPath = path.join(databasePath, 'mydb.db');

    return sql.openDatabase(
      dbPath,
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
        await createTablesForProducts(database);
        // Preload data into the database
        await _preloadData(database);
      },
    );
  }

  static Future<void> _preloadData(sql.Database database) async {
    // Preload data for the 'banner' table
    final banners = [
      {'image': 'https://images.pexels.com/photos/3652097/pexels-photo-3652097.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'},
      {'image': 'https://images.pexels.com/photos/2280571/pexels-photo-2280571.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'},
      {'image': 'https://images.pexels.com/photos/4033148/pexels-photo-4033148.jpeg?auto=compress&cs=tinysrgb&w=1600'},
    ];
    for (final banner in banners) {
      await database.insert(
        'banner',
        banner,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    }

    // Preload data for the 'products' table
    final products = [
  {
    
      "title": "Sergel",
      "subtitle": "Esomeprazole",
      'image': "https://www.hplbd.com/products/Sergel_Tablet-20-mg.jpg",
      'createdDate': "06 Jun, 2023",
      'stock': 1
      
},
   {
    
      "title": "Denvar DS",
      "subtitle": "Cefixime",
      'image': "https://cdn.shopify.com/s/files/1/0595/9417/8768/products/7501298216409.jpg?v=1668652057",
      'createdDate': "07 Jun, 2023",
      'stock': 0
      
},
{
"title": "Relif",
"subtitle": "Ibuprofen",
"image": "https://unitedpharmacy.sa/media/catalog/product/cache/9058a6b5192dd8da86b4e7d8796e45c8/1/0/1033-tb250.jpeg",
"createdDate": "05 Jun, 2023",
"stock": 1
},

{
"title": "Cortimed",
"subtitle": "Prednisone",
"image": "https://farmacorp.com/cdn/shop/products/7770108267829_1024x1024.jpg?v=1669485939",
"createdDate": "05 Jun, 2023",
"stock": 0
}
,
{
"title": "Amlox",
"subtitle": "Amoxicillin",
"image": "https://www.netmeds.com/images/product-v1/600x600/899753/amlox_500mg_capsule_10s_0_2.jpg",
"createdDate": "06 Jun, 2023",
"stock": 1
},


    ];
    for (final product in products) {
      await database.insert(
        'products',
        product,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    }
  }

  static Future<int> createItem(String image) async {
    final db = await SQLHelper.db();

    final data = {'image': image};
    final id = await db.insert('banner', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('banner', orderBy: "id");
  }

  static Future<int> createProducts(
    String image,
    String title,
    String subtitle,
    bool stock,
  ) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'subtitle': subtitle,
      'image': image,
      'createdDate': "06 Jun, 2023",
      'stock': stock ? 1 : 0, 
    };
    final id = await db.insert('products', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await SQLHelper.db();
    return db.query('products', orderBy: "id");
  }
}

