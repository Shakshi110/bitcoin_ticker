import 'coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;  //to build platform specific UI.

class PriceScreen extends StatefulWidget {
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency= 'INR';

   //for android UI appearance.
  //For dropdownButton.
   DropdownButton<String> getDropdownButton(){
     List<DropdownMenuItem<String>> dropDownItemsList= [];
     // for(int i=0; i<currenciesList.length; i++){
     //  String currency= currenciesList[i];
     for(String currency in currenciesList){
       var newItem= DropdownMenuItem(
         child: Text(currency),
         value: currency,
       );
       dropDownItemsList.add(newItem);
     }
   return DropdownButton<String>(
          value: selectedCurrency, //to display the value on the dropdownbutton.
            items: dropDownItemsList,
            onChanged: (value){
            setState(() {
              selectedCurrency= value!;
              getData();
            });
            }
        );
  }

  //for cupertino widget for ios UI appearance
  //FOR CUPERTINOPICKER
  CupertinoPicker getiOSPicker(){
    List<Text> pickerItemsList= [];
    for(String currency in currenciesList){
      pickerItemsList.add(Text(currency));
    }
   return CupertinoPicker(
        itemExtent:32, //height for the each picker in cupertinoPicker.
        onSelectedItemChanged:(selectedIndex){
          setState(() {
            selectedCurrency= currenciesList[selectedIndex];
            getData();
          });
        } ,
        children: pickerItemsList
    );
  }

  Map<String,String> coinValues= {};
   bool isWaiting= false;

   Future getData()async{
     isWaiting= true;
      try{
       var data= await CoinData().getCoinData(selectedCurrency);
       isWaiting=false;
       setState(() {
         coinValues= data;
       });
   }catch(e){
        print(e);
      }
      }

   @override
  void initState() {
    super.initState();
  getData();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Coin Ticker'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardWidget(
                value: isWaiting? '?' : coinValues['BTC'],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: 'BTC',),
              CardWidget(
                value: isWaiting? '?' : coinValues['ETH'],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: 'ETH',),
              CardWidget(
                value: isWaiting? '?' : coinValues['LTC'],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: 'LTC',),
            ],
          ),
          Container(
            height: 120.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFF81A86F),
           child: Platform.isIOS? getiOSPicker():getDropdownButton(),
          ),
        ],
      ),
    );
  }
}


class CardWidget extends StatelessWidget{
  CardWidget({required this.value,required this.selectedCurrency,required this.cryptoCurrency});
  var value;
  var selectedCurrency;
  var cryptoCurrency;
  @override
  Widget build(BuildContext context) {
   return  Padding(
     padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
     child: Card(
       color: Color(0xFF81A86F),
       elevation: 5.0,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(10.0),
       ),
       child: Padding(
         padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
         child: Text(
           '1 $cryptoCurrency = $value $selectedCurrency',
           textAlign: TextAlign.center,
           style: TextStyle(
             fontSize: 20.0,
             color: Colors.white,
           ),
         ),
       ),
     ),
   );


  }
}