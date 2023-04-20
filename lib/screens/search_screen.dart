// class Search extends StatefulWidget {
//   @override
//   SearchState createState() => SearchState();
// }

// class SearchState extends State<Search> {
//   final _searchsong=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     double displayWidth = MediaQuery.of(context).size.width;
//     double displayHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       extendBody: true,
//       body: Container(
//         height: displayHeight,
//         width: displayWidth,
//         decoration: BoxDecoration(gradient: bodyGradient),
//         child: SafeArea(
//             child: Padding(
//           padding: EdgeInsets.only(
//               right: displayWidth * .05,
//               left: displayWidth * .05,
//               top: displayWidth * .06),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 ' Search',
//                 style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   prefixIcon: Icon(
//                     Icons.search_rounded,
//                     size: 25,
//                   ),
//                   // suffixIcon: Icon(Icons.clear_rounded),
//                   hintText: 'Search',
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide(color: Colors.white)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide(color: Colors.white)),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(100)),
//                 ),
//               ),
//               SizedBox(
//                 height: displayHeight * .03,
//               ),
//               Expanded(
//                   child: Material(
//                 color: Colors.black.withOpacity(0),
//                 child: ListView.separated(
//                     physics: BouncingScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       bool isliked;
//                       if (likedSongs.contains(song[index])) {
//                         isliked = true;
//                       } else {
//                         isliked = false;
//                       }
//                       return ListTile(
//                         onTap: () {},
//                         textColor: Colors.white,
//                         iconColor: Colors.white,
//                         tileColor: Color(0xFF20225D),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         leading: Container(
//                           height: 60,
//                           width: 60,
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image: NetworkImage(song[index][2])),
//                               borderRadius: BorderRadius.circular(12)),
//                         ),
//                         title: Text(
//                           song[index][0],
//                         ),
//                         subtitle: Text(
//                           song[index][1],
//                           style: TextStyle(color: Color(0xFF9DA8CD)),
//                         ),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             LikedButton(index: index, isliked: isliked),
//                             PopupMenuButton(
//                               icon: Icon(
//                                 Icons.more_vert_rounded,
//                                 color: Color(0xFF9DA8CD),
//                               ),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                               color: Color(0xFF07014F),
//                               itemBuilder: (context) => [
//                                 PopupMenuItem(
//                                     value: 0,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Icon(Icons.playlist_add),
//                                         Text(
//                                           'Add to Playlist',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                       ],
//                                     ))
//                               ],
//                               onSelected: (value) =>
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => AddToPlaylist(),
//                               )),
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) => SizedBox(
//                           height: 10,
//                         ),
//                     itemCount: song.length),
//               )),
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }
