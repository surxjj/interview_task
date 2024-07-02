import 'package:flutter/material.dart';
import '../controller/api_services.dart';
import '../model/datamodel.dart';

class ProductsGrid extends StatefulWidget {
  final int subCategoryId;

  const ProductsGrid({super.key, required this.subCategoryId});

  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  ApiService apiService = ApiService();
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      List<Product> fetchedProducts =
          await apiService.fetchProducts(widget.subCategoryId);
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: Colors.black,
          ))
        : SizedBox(
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Row(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              product.imageUrl,
                              height: 80,
                              width: 80,
                            ),
                            Positioned(
                                top: 5,
                                left: 5,
                                child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Colors.blue),
                                    child: Text(
                                      product.pricecode,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )))
                          ],
                        ),
                        Text(
                          product.name,
                          style: const TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                );
              },
            ),
          );
  }
}
