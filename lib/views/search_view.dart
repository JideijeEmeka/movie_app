import 'package:flutter/material.dart';
import 'package:movie_app/helpers/constants.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: BackButton(onPressed: () => Navigator.pop(context),
            color: Colors.white,),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              width: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white
              ),
            )
          ],
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          color: Colors.brown.withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Icon(Icons.search, color: Colors.white, size: 28,),
              const SizedBox(width: 15,),
              Expanded(
                child: TextField(
                  controller: searchController,
                  style: titleTextStyle,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Search for a show, movie, genre, etc',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 17),
                ),),
              ),
              IconButton(onPressed: () {},
                  icon: const Icon(Icons.mic, color: Colors.white,))
            ],),
          ),
        ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text("Top Searches", style: listTextStyle,),
          ),
          MediaQuery(data: const MediaQueryData(padding: EdgeInsets.zero),
            child: ListTile(
              leading: Image.asset("assets/images/movie_img.png", fit: BoxFit.cover,),
              title: Text("Interceptor", style: titleTextStyle,),
              trailing: const Icon(Icons.play_circle_outline, color: Colors.white,),
              tileColor: Colors.brown.withOpacity(0.4),
              contentPadding: const EdgeInsets.only(left: 0.0, right: 20.0, top: 5.0, bottom: 5.0),
            ),
          )
      ],),
    );
  }
}
