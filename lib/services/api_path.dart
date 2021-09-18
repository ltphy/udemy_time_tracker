class APIPath {
  static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';

  static String jobs(String uid) => 'users/$uid/jobs/';

  static String entry(String uuid, String entryId) =>
      'users/$uuid/entries/$entryId';

  static String entries(String uid) => 'users/$uid/entries/';
}
