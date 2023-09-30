import 'package:bhagvat_geeta_mobile_app/Controllers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavSlok extends StatefulWidget {
  const FavSlok({super.key});

  @override
  State<FavSlok> createState() => _FavSlokState();
}

class _FavSlokState extends State<FavSlok> {
  @override
  void initState() {
    Provider.of<DataProvider>(context, listen: false).getFavSlok();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DataProvider>(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Favorite Slocks')),
        body: Provider
            .of<DataProvider>(context)
            .favSlok
            .isEmpty
            ? const Center(child: Text('No Favorite Slocks Found...')) : ListView.separated(
          itemCount: Provider
              .of<DataProvider>(context)
              .favSlok
              .length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(provider.favSlok[index].toString()),
              trailing: InkWell(
                  onTap: () {
                    provider.deleteToFav(index);
                  },
                  child: const Icon(Icons.delete)),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(thickness: 2);
          },
        ));
  }
}
