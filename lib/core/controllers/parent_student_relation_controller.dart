import '../services/firebaseservices/pSr_database_service.dart';
import '../services/pSr_apiService.dart';

class ParentStudentRelationController {
  late ParentStudentRelationApiService parentStudentRelationApiService;
  late ParentStudentRelationFirebaseService
      parentStudentRelationFirebaseService;

  ParentStudentRelationController() {
    parentStudentRelationApiService = ParentStudentRelationApiService();
    parentStudentRelationFirebaseService =
        ParentStudentRelationFirebaseService();
  }

  Future<bool> deleteRelation(int parentId, int studentId) async {
    try {
      await parentStudentRelationApiService.removeParentStudentRelationById(
          parentId, studentId);
      await parentStudentRelationFirebaseService.deletepSr(parentId, studentId);
      return true;
    } catch (e) {
      return false;
    }
  }
}
