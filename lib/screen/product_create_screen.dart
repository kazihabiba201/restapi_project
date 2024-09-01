import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:restapi_project/restApi/restClient.dart';
import 'package:restapi_project/screen/product_update_screen.dart';
import 'package:restapi_project/style/style.dart';

// ai part ta state k represent kore
class ProductCreateScrenn extends StatefulWidget {  
 
  const ProductCreateScrenn({super.key});

  @override
  State<ProductCreateScrenn> createState() => _ProductCreateScrennState();
}

class _ProductCreateScrennState extends State<ProductCreateScrenn> {

  Map<String, String> fromValues = {
    "Img": "",
    "ProductCode": "",
    "ProductName": "",
    "Qty": "",
    "TotalPrice": "",
    "UnitPrice": ""
  };
  bool loading = false;

  inputOnChange(mapKey, textValue) {
    setState(() {
      fromValues.update(mapKey, (value) => textValue);
    });
  }

  fromOnSubmit() async {
    if (fromValues["Img"]!.isEmpty) {
      errorToast('Image Link Required');
    } else if (fromValues["ProductCode"]!.isEmpty) {
      errorToast('Product Code Requires');
    } else if (fromValues["ProductName"]!.isEmpty) {
      errorToast('Product Name Requires');
    } else if (fromValues["Qty"]!.isEmpty) {
      errorToast('Quantity Requires');
    } else if (fromValues["TotalPrice"]!.isEmpty) {
      errorToast('Total Price Requires');
    } else if (fromValues["UnitPrice"]!.isEmpty) {
      errorToast('Unit Price Requires');
    } else {
      setState(() {
        loading = true;
      });
      await productCreateRequest(fromValues);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  // r ai part ta view niye kaj kore
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorWhite,
        title: const Text('Create Product'),
      ),
      body: Stack(
        children: [
          screenBackground(context),
          Container(
            child: loading
                ? (const Center(
                    child: CircularProgressIndicator(),
                  ))
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (textValue) {
                            inputOnChange("ProductName", textValue);
                          },
                          decoration: appInputDecoration('Product Name'),
                        ),
                        const Gap(20),
                        TextFormField(
                          onChanged: (textValue) {
                            inputOnChange("ProductCode", textValue);
                          },
                          decoration: appInputDecoration('Product Code'),
                        ),
                        const Gap(20),
                        TextFormField(
                          onChanged: (textValue) {
                            inputOnChange("Img", textValue);
                          },
                          decoration: appInputDecoration('Product Image'),
                        ),
                        const Gap(20),
                        TextFormField(
                          onChanged: (textValue) {
                            inputOnChange("UnitPrice", textValue);
                          },
                          decoration: appInputDecoration("UnitPrice"),
                        ),
                        const Gap(20),
                        TextFormField(
                          onChanged: (textValue) {
                            inputOnChange("TotalPrice", textValue);
                          },
                          decoration: appInputDecoration('Total Price'),
                        ),
                        const Gap(20),
                        appDropDownStyle(DropdownButton(
                          value: fromValues["Qty"],
                          items: const [
                            DropdownMenuItem(
                              value: "",
                              child: Text('Select Qt'),
                            ),
                            DropdownMenuItem(
                              value: "1 pc",
                              child: Text('1 pc'),
                            ),
                            DropdownMenuItem(
                              value: "2 pc",
                              child: Text('2 pc'),
                            ),
                            DropdownMenuItem(
                              value: "3 pc",
                              child: Text('3 pc'),
                            ),
                            DropdownMenuItem(
                              value: "4 pc",
                              child: Text('4 pc'),
                            ),
                          ],
                          onChanged: (textValue) {
                            inputOnChange("Qty", textValue);
                          },
                          underline: Container(),
                          isExpanded: true,
                        )),
                        const Gap(20),
                        ElevatedButton(
                            style: appButtonStyle(),
                            onPressed: () {
                              fromOnSubmit();
                            },
                            child: successButtonChild('Submit'))
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
