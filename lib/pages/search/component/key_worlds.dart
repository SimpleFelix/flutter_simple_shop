import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:flutter/material.dart';

/// 搜索关键字组件
class SearchKeyWorlds extends StatefulWidget {
  const SearchKeyWorlds({Key? key}) : super(key: key);

  @override
  _SearchKeyWorldsState createState() => _SearchKeyWorldsState();
}

class _SearchKeyWorldsState extends State<SearchKeyWorlds> {

  List<String> _keyWorlds = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('搜索发现',style: TextStyle(fontSize: 16),),
          SizedBox(height: 12,),
          Wrap(children: _keyWorlds.map(_item).toList(),spacing: 5,runSpacing: 5,),
        ],
      ),
    );
  }

  Widget _item(String item){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Text(item),
    );
  }

  @override
  void initState() {
    Future.microtask(() async{
     final result =  await DdTaokeSdk.instance.getSuggest();
     if(mounted){
       setState(() {
         _keyWorlds = result.sublist(0,10);
       });
     }
    });
    super.initState();
  }
}
