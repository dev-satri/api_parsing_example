class AddPostModel {
  const AddPostModel({required this.id});

  final int id;

  static fromJson(Map<String, dynamic> json) {
    return AddPostModel(id: json['id']);
  }
}
