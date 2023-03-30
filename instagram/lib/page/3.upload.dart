import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 앱바 부분
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset('asset/img/close_icon.jpg'), // 종료 버튼
          ),
        ),
        title: const Text('새 게시물',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black)),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset('asset/img/upload_next_icon.jpg'), // 업로드 버튼
            ),
          ),
        ],
      ),
      // 앱바 종료
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imageShow(context), // 업로드할 이미지를 보여주는 곳
            _header(), // 업로드 관련 버튼
            _imageSelect(), // 이미지 선택하는 창
          ],
        ),
      ),
    );
  }

  Widget _imageShow(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      color: Colors.grey,
      child: seletedImage == null
          ? Container()
          : FutureBuilder(
              future: seletedImage!.thumbnailDataWithSize(
                // 썸네일
                ThumbnailSize(
                  MediaQuery.of(context).size.width.toInt(),
                  MediaQuery.of(context).size.width.toInt(),
                ),
              ),
              builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
                if (snapshot.hasData) {
                  // 데이터가 존재할경우
                  return Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  );
                } else {
                  // 데이터가 없을경우 빈 컨테이너 리턴
                  return Container();
                }
              },
            ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (_) {
                  return Container(
                    height: 400,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black54,
                          ),
                          width: 40,
                          height: 4,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                albums.length,
                                (index) => Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    child: Text(albums[index].name),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    headerTitle,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          // 제스쳐 끝
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff808080),
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Row(children: [
                  Image.asset(
                    'asset/img/image_select_icon.jpg',
                    width: 20,
                    height: 20,
                  )
                ]),
              ),
              SizedBox(width: 5.0),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff808080),
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Row(children: [
                  Image.asset(
                    'asset/img/camera_icon.jpg',
                    width: 20,
                    height: 20,
                  )
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageSelect() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(), // 스크롤이 지원되지 않게
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 가로행 보여줄 갯수
        mainAxisSpacing: 1, // 가로축 여백 공간
        crossAxisSpacing: 1, // 세로축 여백 공간
        childAspectRatio: 1, // 각 정사각형의 비율 크기 설정
      ),
      itemCount: imageList.length, // 불러온 값에 총 크기
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            seletedImage = imageList[index];
            update();
          },
          child: _photoWidget(
            imageList[index],
          ),
        );
      },
    );
  }

  var albums = <AssetPathEntity>[];
  var headerTitle = '';
  var imageList = <AssetEntity>[];
  AssetEntity? seletedImage;

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  void _loadPhotos() async {
    final PermissionState _ps = await PhotoManager
        .requestPermissionExtend(); // 사진 권한 요청 (/Runner/Info.plist)
    if (_ps.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
          ),
          orders: [
            const OrderOption(type: OrderOptionType.createDate, asc: false),
          ],
        ),
      );
      _loadData();
    } else {
      print('권한요청 거부');
    }
  }

  void _loadData() async {
    headerTitle = albums.first.name;
    await _pagingPhotos();
    update();
  }

  Future<void> _pagingPhotos() async {
    var photos = await albums.first.getAssetListPaged(page: 0, size: 30); // 30개
    imageList.addAll(photos);
    seletedImage = imageList.first; // 첫번째 사진을 추가
  }

  void update() => setState(() {});

  Widget _photoWidget(AssetEntity asset) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(
        ThumbnailSize(200, 200),
      ),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          // 데이터가 존재할경우
          return Opacity(
            opacity: asset == seletedImage ? 0.3 : 1,
            child: Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
