import '../models/group_model.dart';

abstract class GroupMemoryCacheDataSource {
  GroupModel? getGroupFromCache(String groupId);
  void cacheGroup(GroupModel group);
  void clearCache();
  bool hasGroup(String groupId);
  List<GroupModel> getAllUserGroups();
}

class GroupMemoryCacheDataSourceImpl implements GroupMemoryCacheDataSource {
  final _cache = <String, GroupModel>{};

  @override
  GroupModel? getGroupFromCache(String groupId) => _cache[groupId];



  @override
  void cacheGroup(GroupModel group) => _cache[group.id] = group;

  @override
  void clearCache() => _cache.clear();

  @override
  bool hasGroup(String groupId) => _cache.containsKey(groupId);

  @override
  List<GroupModel> getAllUserGroups() {
    return _cache.values.toList();
  }
}