import 'package:flutter/material.dart';

class GroupItemCard extends StatelessWidget {
  final String name;
  final String teamnum;
  final Widget list;
   
  GroupItemCard({
    @required this.name,
    
    this.teamnum,
    this.list,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.grey[200],
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.group,
              color: Theme.of(context).primaryColor,
            ),
          ),
          subtitle: Text(
            "Team number : " + teamnum,
            style: Theme.of(context).textTheme.caption,
          ),
          children: [
            Text(
              "Team member",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            list,
            
          ],
          title: Text(
            name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
