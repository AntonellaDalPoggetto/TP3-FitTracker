final List<String> profileImages = [
  'lib/assets/images/profile1.png',
  'lib/assets/images/profile2.png',
  'lib/assets/images/profile3.png',
  'lib/assets/images/profile4.png',
  'lib/assets/images/profile5.png',
  'lib/assets/images/profile6.png',
  'lib/assets/images/profile7.png',
  'lib/assets/images/profile8.png',
  'lib/assets/images/profile9.png',
];

String getProfileImageById(int? idImage) {
  if (idImage == null || idImage < 1 || idImage > profileImages.length) {
    return profileImages[0];
  }
  return profileImages[idImage - 1];
}
