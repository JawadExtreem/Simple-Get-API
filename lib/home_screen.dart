import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'Models/PostsModel.dart';


class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  List<PostsModel> postList= [];

  Future<List<PostsModel>> getPostApi () async {

    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200) {
      postList.clear();
      for(Map i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    }else {
      return postList;
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Get Api Integration')),
      ),
      body: Column(
        children: [
         Expanded(
           child: FutureBuilder(
             future: getPostApi (),
             builder: (context  , snapshot){
               if(!snapshot.hasData){
                 return Text('Loading');
               } else{
               return ListView.builder(itemBuilder: (context , index){
                 return Card(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text('Title', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text('Title\n'+postList[index].title.toString()),
                         SizedBox(height: 5,),
                         Text('Decription', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                         SizedBox(height: 5,),
                         Text('Decription\n'+postList[index].body.toString()),
                       ],
                     ),
                   ),
                 );
               });
               }
             },
           ),
         )
        ],
      ),
    );
  }
}
