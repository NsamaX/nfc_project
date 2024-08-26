import 'package:nfc_project/api/service/model.dart';

class CFV extends Model {
  final int? id;
  final String? cardType;
  final String? clan;
  final int? critical;
  final String? designIllus;
  final String? effect;
  final String? flavor;
  final String? format;
  final String? grade;
  final String? illust;
  final String? illustColor;
  final String? illust2;
  final String? illust3;
  final String? illust4;
  final String? illust5;
  final String? imageUrlEn;
  final String? imageUrlJp;
  final String? imaginaryGift;
  final String? italian;
  final String? kana;
  final String? kanji;
  final String? korean;
  final String? limitationText;
  final String? mangaIllus;
  final String? name;
  final String? nation;
  final String? note;
  final String? otherNames;
  final String? phonetic;
  final int? power;
  final String? race;
  final String? rideSkill;
  final List<String>? sets;
  final Map<String, String>? tournamentStatuses;
  final int? shield;
  final String? skill;
  final String? thai;
  final String? translation;
  final String? triggerEffect;

  CFV({
    this.id,
    this.cardType,
    this.clan,
    this.critical,
    this.designIllus,
    this.effect,
    this.flavor,
    this.format,
    this.grade,
    this.illust,
    this.illustColor,
    this.illust2,
    this.illust3,
    this.illust4,
    this.illust5,
    this.imageUrlEn,
    this.imageUrlJp,
    this.imaginaryGift,
    this.italian,
    this.kana,
    this.kanji,
    this.korean,
    this.limitationText,
    this.mangaIllus,
    this.name,
    this.nation,
    this.note,
    this.otherNames,
    this.phonetic,
    this.power,
    this.race,
    this.rideSkill,
    this.sets,
    this.tournamentStatuses,
    this.shield,
    this.skill,
    this.thai,
    this.translation,
    this.triggerEffect,
  }) : super();

  @override
  Model fromJson({required Map<String, dynamic> json}) => CFV(
        id: json['id'],
        cardType: json['cardtype'],
        clan: json['clan'],
        critical: json['critical'],
        designIllus: json['designillus'],
        effect: json['effect'],
        flavor: json['flavor'],
        format: json['format'],
        grade: json['grade'],
        illust: json['illust'],
        illustColor: json['illustcolor'],
        illust2: json['illust2'],
        illust3: json['illust3'],
        illust4: json['illust4'],
        illust5: json['illust5'],
        imageUrlEn: json['imageurlen'],
        imageUrlJp: json['imageurljp'],
        imaginaryGift: json['imaginarygift'],
        italian: json['italian'],
        kana: json['kana'],
        kanji: json['kanji'],
        korean: json['korean'],
        limitationText: json['limitationtext'],
        mangaIllus: json['mangaillust'],
        name: json['name'],
        nation: json['nation'],
        note: json['note'],
        otherNames: json['othernames'],
        phonetic: json['phonetic'],
        power: json['power'],
        race: json['race'],
        rideSkill: json['rideskill'],
        sets: List<String>.from(json['sets']),
        tournamentStatuses:
            Map<String, String>.from(json['tournamentstatuses']),
        shield: json['shield'],
        skill: json['skill'],
        thai: json['thai'],
        translation: json['translation'],
        triggerEffect: json['triggereffect'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'cardtype': cardType,
        'clan': clan,
        'critical': critical,
        'designillus': designIllus,
        'effect': effect,
        'flavor': flavor,
        'format': format,
        'grade': grade,
        'illust': illust,
        'illustcolor': illustColor,
        'illust2': illust2,
        'illust3': illust3,
        'illust4': illust4,
        'illust5': illust5,
        'imageurlen': imageUrlEn,
        'imageurljp': imageUrlJp,
        'imaginarygift': imaginaryGift,
        'italian': italian,
        'kana': kana,
        'kanji': kanji,
        'korean': korean,
        'limitationtext': limitationText,
        'mangaillust': mangaIllus,
        'name': name,
        'nation': nation,
        'note': note,
        'othernames': otherNames,
        'phonetic': phonetic,
        'power': power,
        'race': race,
        'rideskill': rideSkill,
        'sets': sets,
        'tournamentstatuses': tournamentStatuses,
        'shield': shield,
        'skill': skill,
        'thai': thai,
        'translation': translation,
        'triggereffect': triggerEffect,
      };

  @override
  String getName() => name ?? '';
  String getImagePath() => imageUrlJp ?? '';
  String getDescription() => format ?? '';

  @override
  Map<String, dynamic> getMap() {
    var properties = {
      'Name': name,
      'Flavor': flavor,
      'Skill': skill,
      'Effect': effect,
      'Ride Skill': rideSkill,
      'Trigger': cardType,
      'Trigger Effect': triggerEffect,
      'Power': power.toString(),
      'Shield': shield.toString(),
      'Clan': clan,
      'Nation': nation,
      'Format': format,
    };
    var map = sets!.isNotEmpty ? {...properties, 'Sets': sets} : properties;
    return map.entries.where((entry) => entry.value != '').fold({},
        (map, entry) {
      map[entry.key] = entry.value;
      return map;
    });
  }
}
