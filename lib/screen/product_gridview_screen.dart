import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:restapi_project/restApi/restClient.dart';
import 'package:restapi_project/screen/product_create_screen.dart';
import 'package:restapi_project/style/style.dart';

import 'product_update_screen.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({super.key});

  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {
  List productList = [];
  bool isLoading = false;

  @override
  void initState() {
    CallData();
    super.initState();
  }

  CallData() async {
    isLoading = true;
    var data = await productGridViewrequest();
    setState(() {
      productList = data;
      isLoading = false;
    });
  }

  gotoUpdate(context, productItem) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) =>  ProductUpdateScreen(productItem)));
  }

  deleteItem(id) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Delete!"),
              content: const Text("Once Delete"),
              actions: [
                OutlinedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      setState(() {
                        isLoading = true;
                      });
                      await productDeleteRequest(id);
                      await CallData();
                    },
                    child: const Text('yes')),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No')),
              ]);
        });
    await productDeleteRequest(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorWhite,
        title: const Text('Product Grid'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) =>  ProductCreateScrenn()));
 
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          screenBackground(context),
          Container(
            child: isLoading
                ? (const Center(child: CircularProgressIndicator()))
                : RefreshIndicator(
                    onRefresh: () async {
                      await CallData();
                    },
                    child: GridView.builder(
                      gridDelegate: productGridViewStyle(),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                  child: Image.network(
                                productList[index]['Img'],
                                fit: BoxFit.fitHeight,
                              )),
                              const Gap(10),
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(productList[index]['ProductName']),
                                      const Gap(10),
                                      Text(productList[index]['ProductCode']),
                                      Text("Price: " +
                                          productList[index]['UnitPrice']),
                                      Row(
                                        children: [
                                          OutlinedButton(
                                              onPressed: () {
                                                gotoUpdate(context,
                                                    productList[index]);
                                              },
                                              child: const Icon(Icons.edit)),
                                          const Gap(10),
                                          OutlinedButton(
                                              onPressed: () {
                                                deleteItem(
                                                    productList[index]['_id']);
                                              },
                                              child: const Icon(Icons.delete)),
                                        ],
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
