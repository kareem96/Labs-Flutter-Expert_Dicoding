
import 'package:core/styles/text_style.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/widgets/card_tv_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/tv_search_notifier.dart';

class SearchTvPage extends StatefulWidget {
  static const routeName = '/search_tv';
  const SearchTvPage({Key? key}) : super(key: key);

  @override
  State<SearchTvPage> createState() => _SearchTvPageState();
}

class _SearchTvPageState extends State<SearchTvPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search TV"),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query){
                Provider.of<TvSearchNotifier>(context, listen: false).fetchTvSearch(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search TV',
                prefixIcon: Icon(Icons.search_outlined),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16,),
            Text('Search Result', style: Heading6,),
            Consumer<TvSearchNotifier>(
              builder: (context, data, child){
                if(data.state == RequestState.Loading){
                  return const Center(child: CircularProgressIndicator(),);
                }else if(data.state == RequestState.Loaded){
                  final result = data.searchResultTv;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index){
                        final movie = data.searchResultTv[index];
                        return CardTvList(movie);
                      },
                    ),
                  );
                }else{
                  return Expanded(child: Container());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
