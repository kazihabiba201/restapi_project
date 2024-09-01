
import 'package:flutter/material.dart';
import 'package:restapi_project/restApi/restClient.dart';
import '../Style/Style.dart';
import 'product_gridview_screen.dart';


class ProductUpdateScreen extends StatefulWidget {
  final Map productItem;
  const ProductUpdateScreen(this.productItem);
  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {


  Map<String,String> fromValues={"Img":"", "ProductCode":"", "ProductName":"", "Qty":"", "TotalPrice":"", "UnitPrice":""};

  bool Loading=false;



  @override
  void initState(){
    setState(() {
      fromValues.update("Img", (value) => widget.productItem['Img']);
      fromValues.update("ProductCode", (value) =>  widget.productItem['ProductCode']);
      fromValues.update("ProductName", (value) => widget.productItem['ProductName']);
      fromValues.update("Qty", (value) => widget.productItem['Qty']);
      fromValues.update("TotalPrice", (value) => widget.productItem['TotalPrice']);
      fromValues.update("UnitPrice", (value) =>widget.productItem['UnitPrice']);
    });
  }



  InputOnChange(MapKey, Textvalue){
    setState(() {
      fromValues.update(MapKey, (value) => Textvalue);
    });
  }


  FormOnSubmit() async{
    if(fromValues['Img']!.isEmpty){
      errorToast('Image Link Required !');
    }
    else if(fromValues['ProductCode']!.isEmpty){
      errorToast('Product Code Required !');
    }
    else if(fromValues['ProductName']!.isEmpty){
      errorToast('Product Name Required !');
    }
    else if(fromValues['Qty']!.isEmpty){
      errorToast('Product Qty Required !');
    }
    else if(fromValues['TotalPrice']!.isEmpty){
      errorToast('Total Price Required !');
    }
    else if(fromValues['UnitPrice']!.isEmpty){
      errorToast('Unit Price Required !');
    }
    else{
      setState(() {
        Loading=true;
      });
      await ProductUpdateRequest(fromValues,widget.productItem['_id']); 
      
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context)=> const ProductGridViewScreen()),
          (Route route)=>false
      );
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Product'),),
      body: Stack(
        children: [
          screenBackground(context),
          Container(
              child:Loading?(const Center(child: CircularProgressIndicator(),)):((SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    TextFormField(
                      initialValue:fromValues['ProductName'],
                      onChanged: (Textvalue){
                        InputOnChange("ProductName",Textvalue);
                      },
                      decoration: appInputDecoration('Product Name'),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      initialValue:fromValues['ProductCode'],
                      onChanged: (Textvalue){
                        InputOnChange("ProductCode",Textvalue);
                      },
                      decoration: appInputDecoration('Product Code'),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      initialValue:fromValues['Img'],
                      onChanged: (Textvalue){
                        InputOnChange("Img",Textvalue);
                      },
                      decoration: appInputDecoration('Product Image'),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      initialValue:fromValues['UnitPrice'],
                      onChanged: (Textvalue){
                        InputOnChange("UnitPrice",Textvalue);
                      },
                      decoration: appInputDecoration('Unit Price'),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      initialValue:fromValues['TotalPrice'],
                      onChanged: (Textvalue){
                        InputOnChange("TotalPrice",Textvalue);
                      },
                      decoration: appInputDecoration('Total Price'),
                    ),

                    const SizedBox(height: 20),

                    appDropDownStyle(
                        DropdownButton(
                          value:fromValues['Qty'] ,
                          items:const [
                            DropdownMenuItem(value: "",child: Text('Select Qt'),),
                            DropdownMenuItem(value: "1 pcs",child: Text('1 pcs'),),
                            DropdownMenuItem(value: '2 pcs',child: Text('2 pcs'),),
                            DropdownMenuItem(value: '3 pcs',child: Text('3 pcs'),),
                            DropdownMenuItem(value: '4 pcs',child: Text('4 pcs'),),
                          ],
                          onChanged: (Textvalue){
                            InputOnChange("Qty",Textvalue);
                          },
                          underline: Container(),
                          isExpanded: true,
                        )
                    ),

                    const SizedBox(height: 20),

                    Container(
                        child:ElevatedButton(
                            style: appButtonStyle(),
                            onPressed: (){
                              FormOnSubmit();
                            },
                            child: successButtonChild('Submit')
                        )
                    )
                  ],
                ),
              )))
          )
        ],
      ),
    );
  }
}