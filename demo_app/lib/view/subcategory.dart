import 'package:demo_app/view/products.dart';
import 'package:flutter/material.dart';
import '../controller/api_services.dart';
import '../model/datamodel.dart';

class SubCategoriesScreen extends StatefulWidget {
  final int categoryId;

  const SubCategoriesScreen({super.key, required this.categoryId});

  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  ApiService apiService = ApiService();
  List<SubCategory> subCategories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubCategories();
  }

  void fetchSubCategories() async {
    try {
      List<SubCategory> fetchedSubCategories =
      await apiService.fetchSubCategories(widget.categoryId);
      setState(() {
        subCategories = fetchedSubCategories;
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
        ? const Center(child: CircularProgressIndicator(      color: Colors.black,
    ))
        : ListView(
      children: subCategories.map((subCategory) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                subCategory.name,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ProductsGrid(subCategoryId: subCategory.id),
          ],
        );
      }).toList(),
    );
  }
}
