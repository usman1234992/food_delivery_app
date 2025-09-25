import 'package:flutter/material.dart';
import 'package:food_delivery_2/Model/category_model.dart';
import 'package:food_delivery_2/Model/product_model.dart';
import 'package:food_delivery_2/Provider/cart_provider.dart';
import 'package:food_delivery_2/View/cart.dart';
import 'package:food_delivery_2/Widgets/food_product_items.dart';
import 'package:food_delivery_2/consts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String category = "";
  List<MyProductModel> productModel = []; // empty list initially

  @override
  void initState() {
    super.initState();
    // Set initial category to first one in myCategories
    if (myCategories.isNotEmpty) {
      category = myCategories[0].name;
      filterProductByCategory(category);
    }
  }

  void filterProductByCategory(String selectedCategory) {
    setState(() {
      category = selectedCategory;
      productModel = myProductModel
          .where(
            (element) =>
                element.category.toLowerCase() ==
                selectedCategory.toLowerCase(),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // CartProvider cartProvider = Provider.of<CartProvider>(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🟠 Top Bar (Location + Search + Cart)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Your Location",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black45,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: kblack,
                            size: 20,
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: korange,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Nabin, Nepal",
                            style: TextStyle(
                              fontSize: 16,
                              color: kblack,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.search, color: kblack),
                    ),
                    const SizedBox(width: 10),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Cart(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              color: kblack,
                            ),
                          ),
                        ),
                        // if (cartProvider.carts.isNotEmpty)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xfff95f60),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                 '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 35),

          // 🟠 Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Let's find the best food around you",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -.4,
                color: kblack,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // 🟠 Category Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Find by Category",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: kblack,
                  ),
                ),
                Text(
                  "See All",
                  style: TextStyle(color: Colors.orange),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // 🟠 Categories List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                ...List.generate(
                  myCategories.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        filterProductByCategory(myCategories[index].name);
                      },
                      child: Container(
                        height: 120,
                        width: 85,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: category == myCategories[index].name
                              ? Border.all(width: 2.5, color: korange)
                              : Border.all(color: Colors.white),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              myCategories[index].image,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              myCategories[index].name,
                              style: const TextStyle(
                                color: kblack,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // 🟠 Product Results
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Result (${productModel.length})",
              style: TextStyle(
                color: kblack.withOpacity(0.6),
                fontWeight: FontWeight.bold,
                letterSpacing: -.2,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 🟠 Product Items
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(
                productModel.length,
                (index) => Padding(
                  padding: index == 0
                      ? const EdgeInsets.only(left: 25, right: 25)
                      : const EdgeInsets.only(right: 25),
                  child: FoodProductItems(
                    productModel: productModel[index],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
