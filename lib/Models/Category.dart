import 'dart:core';


class Category{
	static const String history = '歴史';
	static const String nature = '自然・環境';
	static const String seminar = '講座・セミナー';
	static const String kids = 'こども';
	static const String other = 'その他';
	static const String culture = '文化・芸術';
	static const String health = '食・健康';
	static const String sports = 'スポーツ';
	static const String music = '音楽';
	static const String festival = '観光・祭り';

	Map events_category = {
		history:true,
		nature:true,
		seminar:true,
		kids:true,
		other:true,
		culture:true,
		health:true,
		sports:true,
		music:true,
		festival:true,
	};
}
