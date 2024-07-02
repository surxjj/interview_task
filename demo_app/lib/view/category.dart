import 'package:demo_app/view/subcategory.dart';
import 'package:flutter/material.dart';
import '../controller/api_services.dart';
import '../model/datamodel.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  ApiService apiService = ApiService();
  List<Category> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      List<Category> fetchedCategories = await apiService.fetchCategories();
      setState(() {
        categories = fetchedCategories;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'ESP Tiles',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.filter_list,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(      color: Colors.black,
      ))
          : DefaultTabController(
        length: categories.length,
        child: Column(
          children: [
            Container(
              color: Colors.black,
              child: TabBar(
                isScrollable: true,
                labelStyle: const TextStyle(fontSize: 18),
                unselectedLabelStyle: const TextStyle(fontSize: 14),
                indicatorColor: Colors.white,

                tabs: categories.map((category) {
                  return Tab(
                    child: Text(
                      category.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: categories.map((category) {
                  return SubCategoriesScreen(categoryId: category.id);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}