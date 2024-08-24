import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tiers_final_project/res/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List storyImages = [
    'https://getwallpapers.com/wallpaper/full/3/4/7/418501.jpg',
    'https://wallup.net/wp-content/uploads/2014/10/nature/Beautiful_Landscape_Mountain.jpg',
    'https://wallpapercave.com/wp/qQmVZKv.jpg',
    'https://tse4.mm.bing.net/th?id=OIP.SSwxf9L-saW3GRD6T0cn8AHaE_&pid=Api&P=0&h=180',
    'https://cdn.wallpapersafari.com/71/78/GNCBRk.jpg',
    'https://tse1.mm.bing.net/th?id=OIP.StmdTp7V2e2ON0XVgn7f5QHaFj&pid=Api&P=0&h=180',
    'https://getwallpapers.com/wallpaper/full/0/9/0/1009982-free-download-scenic-wallpaper-2560x1600-for-windows-7.jpg',
    'https://images5.alphacoders.com/357/thumb-1920-357983.jpg',
    'https://cdn.wallpapersafari.com/21/22/b5NhVt.jpg',
    'https://cdn.wallpapersafari.com/1/34/vtHlET.jpg',
  ];

  final List postImages = [
    'https://imagevars.gulfnews.com/2019/05/30/Pakistan-s-Mohammad-Amir-_16b09cb0745_large.jpg',
    'https://imagevars.gulfnews.com/2019/05/30/Pakistan-s-Mohammad-Amir-_16b09cb0745_large.jpg',
    'https://static.independent.co.uk/s3fs-public/thumbnails/image/2020/01/04/13/virat-kohli.jpg',
    'https://tse4.mm.bing.net/th?id=OIP.ezHMpGbJHd8IK2c7bn1cXAHaFL&pid=Api&P=0&h=180',
    'https://cricshots.com/wp-content/uploads/2021/07/babar-azam-england.jpg',
  ];
  final auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 2,
        title: const Text('Instagram'),
        centerTitle: false,
        actions: const [
          SizedBox(
            width: 20,
          ),
          Icon(Icons.settings),
          SizedBox(
            width: 20,
          ),
          Icon(Icons.light_mode),
          SizedBox(
            width: 20,
          ),
          Icon(Icons.message),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: storyImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.primaryButtonColor,
                                  width: 2),
                              shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundColor: AppColors.grayColor,
                            backgroundImage: NetworkImage(storyImages[index]),
                          ),
                        ));
                  })),
          Expanded(
              flex: 10,
              child: ListView.builder(
                itemCount: postImages.length,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://a1.espncdn.com/combiner/i?img=/i/espn/espn_logos/espncricinfo.png'),
                        ),
                        title: Text('espncricinfo',
                            style: Theme.of(context).textTheme.headlineSmall),
                        trailing: const Icon(Icons.more_vert),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 15),
                        child: Container(
                          height: 350,
                          color: Colors.white,
                          child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(postImages[index])),
                        ),
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.favorite_outline_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.mode_comment_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.send,
                            size: 30,
                          ),
                          Spacer(),
                          Icon(
                            Icons.download,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.sticky_note_2_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'espncricinfo',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'View Comments',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }),
              )),
        ],
      ),
    );
  }
}
