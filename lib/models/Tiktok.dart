class Tiktok {
  int? code;
  String? msg;
  double? processedTime;
  Data? data;

  Tiktok({this.code, this.msg, this.processedTime, this.data});

  Tiktok.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    processedTime = json['processed_time'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['processed_time'] = this.processedTime;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? region;
  String? title;
  String? cover;
  String? originCover;
  int? duration;
  String? play;
  String? wmplay;
  int? size;
  int? wmSize;
  String? music;
  MusicInfo? musicInfo;
  int? playCount;
  int? diggCount;
  int? commentCount;
  int? shareCount;
  int? downloadCount;
  int? collectCount;
  int? createTime;
  Null? anchors;
  String? anchorsExtras;
  bool? isAd;
  CommerceInfo? commerceInfo;
  String? commercialVideoInfo;
  Author? author;

  Data(
      {this.id,
      this.region,
      this.title,
      this.cover,
      this.originCover,
      this.duration,
      this.play,
      this.wmplay,
      this.size,
      this.wmSize,
      this.music,
      this.musicInfo,
      this.playCount,
      this.diggCount,
      this.commentCount,
      this.shareCount,
      this.downloadCount,
      this.collectCount,
      this.createTime,
      this.anchors,
      this.anchorsExtras,
      this.isAd,
      this.commerceInfo,
      this.commercialVideoInfo,
      this.author});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    region = json['region'];
    title = json['title'];
    cover = json['cover'];
    originCover = json['origin_cover'];
    duration = json['duration'];
    play = json['play'];
    wmplay = json['wmplay'];
    size = json['size'];
    wmSize = json['wm_size'];
    music = json['music'];
    musicInfo = json['music_info'] != null
        ? new MusicInfo.fromJson(json['music_info'])
        : null;
    playCount = json['play_count'];
    diggCount = json['digg_count'];
    commentCount = json['comment_count'];
    shareCount = json['share_count'];
    downloadCount = json['download_count'];
    collectCount = json['collect_count'];
    createTime = json['create_time'];
    anchors = json['anchors'];
    anchorsExtras = json['anchors_extras'];
    isAd = json['is_ad'];
    commerceInfo = json['commerce_info'] != null
        ? new CommerceInfo.fromJson(json['commerce_info'])
        : null;
    commercialVideoInfo = json['commercial_video_info'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['region'] = this.region;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['origin_cover'] = this.originCover;
    data['duration'] = this.duration;
    data['play'] = this.play;
    data['wmplay'] = this.wmplay;
    data['size'] = this.size;
    data['wm_size'] = this.wmSize;
    data['music'] = this.music;
    if (this.musicInfo != null) {
      data['music_info'] = this.musicInfo!.toJson();
    }
    data['play_count'] = this.playCount;
    data['digg_count'] = this.diggCount;
    data['comment_count'] = this.commentCount;
    data['share_count'] = this.shareCount;
    data['download_count'] = this.downloadCount;
    data['collect_count'] = this.collectCount;
    data['create_time'] = this.createTime;
    data['anchors'] = this.anchors;
    data['anchors_extras'] = this.anchorsExtras;
    data['is_ad'] = this.isAd;
    if (this.commerceInfo != null) {
      data['commerce_info'] = this.commerceInfo!.toJson();
    }
    data['commercial_video_info'] = this.commercialVideoInfo;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    return data;
  }
}

class MusicInfo {
  String? id;
  String? title;
  String? play;
  String? cover;
  String? author;
  bool? original;
  int? duration;
  String? album;

  MusicInfo(
      {this.id,
      this.title,
      this.play,
      this.cover,
      this.author,
      this.original,
      this.duration,
      this.album});

  MusicInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    play = json['play'];
    cover = json['cover'];
    author = json['author'];
    original = json['original'];
    duration = json['duration'];
    album = json['album'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['play'] = this.play;
    data['cover'] = this.cover;
    data['author'] = this.author;
    data['original'] = this.original;
    data['duration'] = this.duration;
    data['album'] = this.album;
    return data;
  }
}

class CommerceInfo {
  bool? advPromotable;
  bool? auctionAdInvited;
  int? brandedContentType;
  bool? withCommentFilterWords;

  CommerceInfo(
      {this.advPromotable,
      this.auctionAdInvited,
      this.brandedContentType,
      this.withCommentFilterWords});

  CommerceInfo.fromJson(Map<String, dynamic> json) {
    advPromotable = json['adv_promotable'];
    auctionAdInvited = json['auction_ad_invited'];
    brandedContentType = json['branded_content_type'];
    withCommentFilterWords = json['with_comment_filter_words'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adv_promotable'] = this.advPromotable;
    data['auction_ad_invited'] = this.auctionAdInvited;
    data['branded_content_type'] = this.brandedContentType;
    data['with_comment_filter_words'] = this.withCommentFilterWords;
    return data;
  }
}

class Author {
  String? id;
  String? uniqueId;
  String? nickname;
  String? avatar;

  Author({this.id, this.uniqueId, this.nickname, this.avatar});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    nickname = json['nickname'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    return data;
  }
}
