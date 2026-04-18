import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductItem {
  final String productName;
  final int price;
  final String imagePath;
  int quantity;
  bool isSelected;
  final bool hasFreeship;
  final bool hasPromo;
  final bool hasKombo;

  ProductItem({
    required this.productName,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
    this.isSelected = false,
    this.hasFreeship = false,
    this.hasPromo = false,
    this.hasKombo = false,
  });
}

class StoreCart {
  final String storeName;
  final List<ProductItem> products;
  final String voucherType;

  StoreCart({
    required this.storeName, 
    required this.products,
    this.voucherType = 'kode',
  });

  bool get isAllSelected => products.every((p) => p.isSelected);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
      ),
      home: const MyHomePage(title: 'Keranjang Saya (23)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  String formatRupiah(int amount) {
    String result = amount.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = result.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) buffer.write('.');
      buffer.write(result[i]);
      count++;
    }
    return 'Rp${buffer.toString().split('').reversed.join()}';
  }
  bool isCoinActive = false;
  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     // _counter++;
  //   });
  // }
  List<StoreCart> stores = [
    StoreCart(
      storeName: "Bambang Store",
      voucherType: 'diskon',
      products: [
        ProductItem(
          productName: "Pisau Dapur Lipat Mini Outdoor Survival S...",
          price: 13823,
          imagePath: 'assets/images/pisau.jpg',
          hasFreeship: true,
        ),
      ],
    ),
    StoreCart(
      storeName: "Ready Accessories",
      voucherType: 'kode',
      products: [
        ProductItem(
          productName: "Survival Gantungan Kunci 18in1 Snowflak...",
          price: 8374,
          imagePath: 'assets/images/snow.jpg',
          hasFreeship: true,
          hasPromo: true,
          hasKombo: true,
        ),
        ProductItem(
          productName: "Pisau Lipat Tactical Mini Serbaguna...",
          price: 15000,
          imagePath: 'assets/images/pisau.jpg',
          hasFreeship: true,
        ),
        ProductItem(
          productName: "Tali Paracord Survival 550 10 Meter...",
          price: 22500,
          imagePath: 'assets/images/tali.jpg',
          hasPromo: true,
        ),
      ],
    ),
  ];
  List<ProductItem> get allProducts =>
      stores.expand((store) => store.products).toList();
  
  int get totalHarga => allProducts
      .where((p) => p.isSelected)
      .fold(0, (sum, p) => sum + (p.price * p.quantity));
  
  int get totalChecked => allProducts.where((p) => p.isSelected).length;
  
  bool get isAllSelected => allProducts.every((p) => p.isSelected);
  @override
  Widget build(BuildContext context) {
    // return Checkbox(checkColor: Colors.white, 
    // value: IsChecked, 
    // onChanged: (bool? value) {
    //   setState(() {
    //     IsChecked = value!;
    //   });
    // }),
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        titleSpacing: 0,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        leading: Icon(Icons.arrow_back, size: 25, color: Colors.deepOrange,),
        title: Row(
          children: [
            const Text(
              'Keranjang Saya',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 8),
            Text(
              '(23)',
              style: TextStyle(
                fontSize: 14, 
                color: const Color.fromARGB(255, 92, 92, 92), 
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Text('Ubah', style: TextStyle(fontSize: 12),),
              SizedBox(width: 10,),
              FaIcon(FontAwesomeIcons.commentDots, size: 16,color: Colors.deepOrange,),
              SizedBox(width:12,),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                for (int i = 0; i < stores.length; i++) ...[
                  _buildStoreCard(stores[i]),
                  if (i < stores.length - 1)
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          const Icon(Icons.delete_outline, color: Colors.deepOrange, size: 18),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              "Hapus produk yang sudah tidak kamu perlukan.",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.deepOrange,
                              side: const BorderSide(color: Colors.deepOrange),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text("Hapus", style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                ],
              ],
            ),
          ),
          _buildVoucherAndCoinBar(),
          _buildBottomCheckout(),
        ],
        
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        // child: Row(
        //   // Column is also a layout widget. It takes a list of children and
        //   // arranges them vertically. By default, it sizes itself to fit its
        //   // children horizontally, and tries to be as tall as its parent.
        //   //
        //   // Column has various properties to control how it sizes itself and
        //   // how it positions its children. Here we use mainAxisAlignment to
        //   // center the children vertically; the main axis here is the vertical
        //   // axis because Columns are vertical (the cross axis would be
        //   // horizontal).
        //   //
        //   // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
        //   // action in the IDE, or press "p" in the console), to see the
        //   // wireframe for each widget.
        //   children: [
            
        //     Image(image: AssetImage('assets/images/book.jpg'), 
        //     width: 150, 
        //     height: 150,),            
        //     SizedBox(width: 20,),
        //     Text('Buku Flutter untuk Pemula', 
        //     style: TextStyle(
        //       fontSize: 16, 
        //       fontWeight: FontWeight.bold),),
        //   ],
        // ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
  Widget _buildProductRow(ProductItem product) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: product.isSelected,
              activeColor: Colors.deepOrange,
              onChanged: (val) {
                setState(() => product.isSelected = val ?? false);
              },
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(product.imagePath,
                  width: 80, height: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.productName, maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 4,
                    children: [
                      if (product.hasFreeship)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Text('GRATIS ONGKIR',
                              style: TextStyle(color: Colors.green, fontSize: 9, fontWeight: FontWeight.bold)),
                        ),
                      if (product.hasPromo)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.deepOrange),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Text('PROMO',
                              style: TextStyle(color: Colors.deepOrange, fontSize: 9, fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(formatRupiah(product.price),
                          style: const TextStyle(
                              color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 16)),
                      const Spacer(),
                      InkWell(
                        onTap: () { if (product.quantity > 1) setState(() => product.quantity--); },
                        child: Container(
                          width: 26, height: 26,
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
                          child: const Icon(Icons.remove, size: 14),
                        ),
                      ),
                      Container(
                        width: 32, height: 26,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey.shade300),
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text('${product.quantity}', style: const TextStyle(fontSize: 13)),
                      ),
                      InkWell(
                        onTap: () => setState(() => product.quantity++),
                        child: Container(
                          width: 26, height: 26,
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
                          child: const Icon(Icons.add, size: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (product.hasKombo) ...[
          const SizedBox(height: 4),
          ListTile(
            dense: true,
            contentPadding: const EdgeInsets.only(left: 48),
            leading: const Icon(Icons.shopping_bag_outlined, color: Colors.deepOrange, size: 18),
            title: const Text("Kombo Hemat dengan harga lebih murah", style: TextStyle(fontSize: 12)),
            trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
            onTap: () {},
          ),
        ],
      ],
    );
  }
  Widget _buildStoreCard(StoreCart store) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: store.isAllSelected,
                  activeColor: Colors.deepOrange,
                  onChanged: (val) {
                    setState(() {
                      for (var p in store.products) {
                        p.isSelected = val ?? false;
                      }
                    });
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Text('Star+',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 6),
                Text(store.storeName, style: const TextStyle(fontWeight: FontWeight.bold)),
                const Icon(Icons.chevron_right, size: 18),
                const Spacer(),
                const Text("Ubah", style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(width: 8),
              ],
            ),

            for (var product in store.products) ...[
              const Divider(),
              _buildProductRow(product),
            ],

            const Divider(height: 1, thickness: 0.5),
            (store.voucherType == 'kode')
              ?ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                leading: const Icon(Icons.confirmation_num_outlined, color: Colors.deepOrange, size: 18),
                title: const Text("Tambahkan kode Voucher Toko", style: TextStyle(fontSize: 12)),
                trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                onTap: () {},
              )
              :ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                leading: const Icon(Icons.confirmation_num_outlined, color: Colors.deepOrange, size: 18),
                title: const Text("Tersedia Voucher Diskon s/d Rp5RB", style: TextStyle(fontSize: 12)),
                trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                onTap: () {},
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherAndCoinBar() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Divider(height: 1, thickness: 0.5),
          ListTile(
            dense: true,
            leading: const Icon(Icons.confirmation_num_outlined, color: Colors.deepOrange, size: 20),
            title: const Text("Voucher Toko", style: TextStyle(fontSize: 13)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("Gunakan/masukkan kode", style: TextStyle(fontSize: 12, color: Colors.grey)),
                Icon(Icons.chevron_right, size: 18, color: Colors.grey),
              ],
            ),
            onTap: () {},
          ),
          
          const Divider(height: 1, thickness: 0.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.orange, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Tidak ada produk yang dipilih", style: TextStyle(fontSize: 13)),
                    //   Row(
                    //   children: [
                    //     Text(
                    //       "Tidak ada produk yang dipilih",
                    //       style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    //     ),
                    //     const SizedBox(width: 4),
                    //     Icon(Icons.help_outline, size: 13, color: Colors.grey),
                    //   ],
                    // ),
                    ],
                  ),
                ),
                Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    value: isCoinActive, 
                    onChanged: (val) {setState(() {
                      isCoinActive = val;
                    });},
                    activeThumbColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCheckout() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Checkbox(
            value: isAllSelected,
            activeColor: Colors.deepOrange,
            onChanged: (val) {
              setState(() {
                for (var item in allProducts) {
                  item.isSelected = val ?? false;
                }
              });
            },
          ),
          const Text("Semua"),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Total", style: TextStyle(fontSize: 12)),
              Text(
                formatRupiah(totalHarga),
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 50,
            width: 130,
            child: ElevatedButton(
              onPressed: totalChecked > 0 ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                disabledBackgroundColor: Colors.grey.shade300,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Text(
                "Checkout ($totalChecked)",
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
