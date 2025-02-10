class EndPoints {
  static String baseUrl = 'http://192.168.1.10/farm_hub/public';

  // Authentication
  static String login = '$baseUrl/auth/login.php';
  static String handleOTP = '$baseUrl/auth/handle_otp.php';
  static String changePassword = '$baseUrl/auth/change_password.php';
  static String register = '$baseUrl/auth/register.php';

  // User
  static String userData = '$baseUrl/user/user_data.php';
  static String userPosts = '$baseUrl/user/user_posts.php';
  static String editProfile = '$baseUrl/user/edit_profile.php';
  static String editAvatar = '$baseUrl/user/edit_avatar.php';
  static String showProfile = '$baseUrl/user/show_profile.php';

  // Posts
  static String incrementShares = '$baseUrl/posts/common/increment_shares.php';
  static String incrementViews = '$baseUrl/posts/common/increment_views.php';

  /* Insights */
  static String likeInsight = '$baseUrl/posts/insights/like_insight.php';
  static String likeComment = '$baseUrl/posts/insights/like_comment.php';
  static String showInsights = '$baseUrl/posts/insights/show_insights.php';
  static String createInsight = '$baseUrl/posts/insights/add_insight.php';
  static String addComment = '$baseUrl/posts/insights/add_comment.php';
  static String showComments = '$baseUrl/posts/insights/show_comments.php';

  /* Listings */
  static String searchListings = '$baseUrl/posts/listings/search_listings.php';
  static String showListings = '$baseUrl/posts/listings/show_listings.php';
  static String createListing = '$baseUrl/posts/listings/add_listing.php';

  // Chats
  static String showChats = '$baseUrl/chats/show_chats.php';
  static String sendMessage = '$baseUrl/chats/send_message.php';
  static String readMessage = '$baseUrl/chats/read_message.php';
}
