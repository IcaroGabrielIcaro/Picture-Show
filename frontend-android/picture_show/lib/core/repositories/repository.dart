class Repository {
  final api = ApiService();
  final local = LocalStorageService();

  Future<List<dynamic>> getData() async {
    try {
      final data = await api.fetchData();
      await local.saveData(data); // salva localmente
      return data;
    } catch (e) {
      // se falhar, tenta pegar do cache
      final cached = await local.getData();
      if (cached != null) return cached;

      throw Exception("Sem internet e sem cache");
    }
  }
}