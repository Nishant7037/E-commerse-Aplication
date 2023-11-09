import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopingapi/Screens/apihelper.dart';
import 'package:onlineshopingapi/Screens/cart_list.dart';
import 'package:onlineshopingapi/Screens/explore.dart';
import 'package:onlineshopingapi/Screens/favorite_list.dart';
import 'package:onlineshopingapi/Screens/homepage.dart';
import 'package:onlineshopingapi/Screens/profile.dart';
import 'package:onlineshopingapi/Screens/signin.dart';
import 'package:onlineshopingapi/models/product_res_model.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SignInPage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int myindex = 0;
  final screens = [
    const HomeApiPage(),
    const ExplorePage(),
    CartList(),
    Favorite_List(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              myindex = index;
            });
          },
          currentIndex: myindex,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.manage_search_outlined), label: "Explore"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), label: "Favourite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: "Account"),
          ],
        ),
        body: screens[myindex]);
  }
}

//homepage

class HomeApiPage extends StatefulWidget {
  const HomeApiPage({super.key});

  @override
  State<HomeApiPage> createState() => _HomeApiPageState();
}

class _HomeApiPageState extends State<HomeApiPage> {
  late Future<List<ProductResModel>> _productFuture;
  late Future<List<String>> _productCategory;

  @override
  void initState() {
    _productFuture = ApiHelper.getproduct(context);
    _productFuture1 = ApiHelper.getproduct1(context);
    _productFuture2 = ApiHelper.getproduct2(context);
    super.initState();
  }

  late Future<List<ProductResModel>> _productFuture1;

  late Future<List<ProductResModel>> _productFuture2;

  @override
  Widget build(BuildContext context) {
    var myimage = [
      Image.asset("assets/images/banner.png"),
      Image.asset("assets/images/banner.png"),
      Image.asset("assets/images/banner.png"),
    ];
    int myCurrentIndex = 0;
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on_outlined),
                          Text(
                            'Badarpur , New Delhi',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),

                      InkWell(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: Column(children: [
                              TextField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15),
                                  hintText: "Search Store",
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                              ),
                            ])),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: true,
                              height: 100,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              autoPlayInterval: const Duration(seconds: 2),
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  myCurrentIndex = index;
                                });
                              }),
                          items: myimage,
                          //images
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Exclusive Offer",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 103, 233, 107),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FutureBuilder<List<ProductResModel>>(
                          future: _productFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.data == null) {
                              return const Center(
                                child: Text("No data"),
                              );
                            }
                            if (snapshot.data!.isEmpty) {
                              return const Center(child: Text("Data Empty"));
                            }

                            return SizedBox(
                                height: 250,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: ((context, index) {
                                      final product1 = snapshot.data![index];
                                      return ProductReuseable(
                                          product: product1);
                                    })));
                          }),

//best selling

                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Best Selling",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 103, 233, 107),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FutureBuilder<List<ProductResModel>>(
                          future: _productFuture1,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.data == null) {
                              return const Center(
                                child: Text("No data"),
                              );
                            }
                            if (snapshot.data!.isEmpty) {
                              return const Center(child: Text("Data Empty"));
                            }

                            return SizedBox(
                                height: 250,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: ((context, index) {
                                      final product = snapshot.data![index];
                                      return ProductReuseable(product: product);
                                    })));
                          }),

                      const SizedBox(
                        height: 20,
                      ),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Groceries",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 103, 233, 107),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 248.19,
                                height: 105,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 251, 194, 132),
                                    border: Border.all(
                                        width: 1,
                                        color: const Color.fromARGB(
                                            255, 209, 208, 208)),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                            "assets/images/pulse.png")),
                                    const Expanded(
                                        child: Text(
                                      "Pulses",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ))
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                width: 248.19,
                                height: 105,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 177, 243, 201),
                                    border: Border.all(
                                        width: 1,
                                        color: const Color.fromARGB(
                                            255, 209, 208, 208)),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                            "assets/images/rice.png")),
                                    const Expanded(
                                        child: Text(
                                      "Rice",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ))
                                  ],
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height: 10),

                      FutureBuilder<List<ProductResModel>>(
                          future: _productFuture2,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.data == null) {
                              return const Center(
                                child: Text("No data"),
                              );
                            }
                            if (snapshot.data!.isEmpty) {
                              return const Center(child: Text("Data Empty"));
                            }

                            return SizedBox(
                                height: 250,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: ((context, index) {
                                      final product = snapshot.data![index];
                                      return ProductReuseable(product: product);
                                    })));
                          }),
                    ])))));
  }
}

//Explore Page

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late Future<List<ProductResModel>> _productFuture;
  late Future<List<String>> _futureCategory; //category
  bool _isSearch = false; //search
  List<ProductResModel> _lstSearchProducts = []; //search
  List<ProductResModel> lstProduct = []; //search
  String _searchkeyword = ""; //search
  final TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    _productFuture = ApiHelper.getproduct(context);
    _futureCategory = ApiHelper.getproductcategory(context); //search

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
        centerTitle: true,
      ),
      body:
          _isSearch ? lstSearchProducts() : lstProducts(), //search k bad update
    );
  }

//search

  Widget lstProducts() {
    return FutureBuilder<List>(
        future: Future.wait(
            [_productFuture, _futureCategory]), //catogory and access
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text("No data"),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text("Data Empty"));
          }
          lstProduct = snapshot.data![0]; //search
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25, right: 25, left: 25, bottom: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CupertinoSearchTextField(
                          placeholder: "Search Product",
                          onSubmitted: (keyword) {
                            if (keyword.isEmpty) {
                              _isSearch = false;
                              setState(() {});
                            }
                            if (keyword.isNotEmpty) {
                              _searchkeyword = keyword;
                              _isSearch = true;
                              setState(() {});
                            }
                            _lstSearchProducts = lstProduct
                                .where((product) => product.title
                                    .toLowerCase()
                                    .contains(keyword))
                                .toList();
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            _show(context, snapshot.data![1]);
                          },
                          icon: const Icon(Icons.filter_list)),
                    ]),
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 0),
                    itemCount: snapshot.data![0].length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![0][index];
                      return ExplorePageReuse(product: product);
                    }),
              ),
            ],
          );
        });
  }

//search

  Widget lstSearchProducts() {
    searchcontroller.text = _searchkeyword;
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 25, right: 25, left: 25, bottom: 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: CupertinoSearchTextField(
                controller: searchcontroller,
                placeholder: "Search Product",
                onSubmitted: (keyword) {
                  if (keyword.isEmpty) {
                    _isSearch = false;
                    setState(() {});
                  }
                  _searchkeyword = keyword;
                  _lstSearchProducts = lstProduct
                      .where((product) =>
                          product.title.toLowerCase().contains(keyword))
                      .toList();
                  setState(() {});
                },
              ),
            ),
            //   IconButton(
            //       onPressed: () {
            //         _show(context, snapshot.data![1]);
            //         print("filtered");
            //       },
            //       icon: Icon(Icons.filter_list)),
          ]),
        ),
        Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 0),
              itemCount: _lstSearchProducts.length,
              itemBuilder: (context, index) {
                final product = _lstSearchProducts[index];
                return ExplorePageReuse(product: product);
              }),
        ),
      ],
    );
  }

//filtered

  void _show(BuildContext ctx, List<String> lstCategories) {
    showModalBottomSheet(
        elevation: 10,
        context: ctx,
        builder: (ctx) => Container(
              alignment: Alignment.center,
              child: ListView.builder(
                itemCount: lstCategories.length,
                itemBuilder: (context, index) {
                  String categoryName = lstCategories[index];
                  return ListTile(
                    onTap: () async {
                      _productFuture =
                          ApiHelper.getproductByCategory(context, categoryName);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    leading: const Icon(Icons.shopping_bag_outlined),
                    title: Text(lstCategories[index]),
                  );
                },
              ),
            ));
  }
}
