import 'package:intl/intl.dart';

class PontosTuristicos {
  static const nomeTabela = 'pontosturisticos';
  static const campoId = 'id';
  static const campoNome = 'nome';
  static const campoDescricao = 'descricao';
  static const campoDiferenciais = 'diferenciais';
  static const campoInclusao = 'inclusao';
  static const campoLatitude = 'latitude';
  static const campoLongitude = 'longitude';
  static const campoCep = 'cep';

  int id;
  String nome;
  String descricao;
  String diferenciais;
  DateTime? dataInclusao;
  bool finalizada;
  String latitude;
  String longitude;
  String cep;

  PontosTuristicos({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.diferenciais,
    this.dataInclusao,
    this.finalizada = false,
    required this.latitude,
    required this.longitude,
    required this.cep,
  });

  String get prazoFormatado {
    if (dataInclusao == null) {
      return '';
    }
    return DateFormat('dd/MM/yyyy').format(dataInclusao!);
  }

  Map<String, dynamic> toMap() => {
    campoId: id == 0 ? null : id,
    campoNome: nome,
    campoDescricao: descricao,
    campoDiferenciais: diferenciais,
    campoInclusao: dataInclusao == null
        ? null
        : DateFormat('yyyy-MM-dd').format(dataInclusao!),
    campoLatitude: latitude,
    campoLongitude: longitude,
    campoCep: cep,
  };

  factory PontosTuristicos.fromMap(Map<String, dynamic> map) => PontosTuristicos(
    id: map[campoId] is int ? map[campoId] : null,
    nome: map[campoNome] is String ? map[campoNome] : '',
    descricao: map[campoDescricao] is String ? map[campoDescricao] : '',
    diferenciais: map[campoDiferenciais] is String ? map[campoDiferenciais] : '',
    dataInclusao: map[campoInclusao] is String
        ? DateFormat('yyyy-MM-dd').parse(map[campoInclusao])
        : null,
    latitude: map[campoLatitude] is String ? map[campoLatitude] : '',
    longitude: map[campoLongitude] is String ? map[campoLongitude] : '',
    cep: map[campoCep] is String ? map[campoCep] : '',
  );
}
