class DoctorCategory {
  final String title;
  final String imagePath;

  DoctorCategory({required this.title, required this.imagePath});

  // static fromFirestore(Map<String, dynamic> data) {}
  factory DoctorCategory.fromFirestore(String categoryTitle) {
    return DoctorCategory(
      title: categoryTitle,
      imagePath: _getImagePathForCategory(categoryTitle),
    );
  }

  // Static method to map category titles to image paths
  static String _getImagePathForCategory(String title) {
    switch (title.toLowerCase()) {
      case 'womens specialist':
        return 'assets/images/women_specialist.png';

      case 'child specialist':
        return 'assets/images/pediatrician.png';
      case 'neurologist':
        return 'assets/images/neuro.png';
      case 'dermatology':
        return 'assets/images/dernatology.png';
      case 'ent':
        return 'assets/images/ent.png';
      case 'dental':
        return 'assets/images/dentist.png';
      case 'oncologist':
        return 'assets/images/oncologist.png';

      default:
        return 'assets/images/generalphysician.png'; // Default fallback image
    }
  }
}
