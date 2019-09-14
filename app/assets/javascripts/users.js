document.addEventListener('DOMContentLoaded', function() {

  var follow_checkbox = document.getElementById('follows_checkbox');
  var follower_checkbox = document.getElementById('followers_checkbox');
  var follow_link = document.getElementById('follows_link');
  var follower_link = document.getElementById('followers_link');
  var mutual_follow_link = document.getElementById('mutual_followers_link');
  var all_users_link = document.getElementById('all_users_link');

  if(follow_checkbox) {
    follow_checkbox.addEventListener('change', function(e) {
      if (e.target.checked && !follower_checkbox.checked) {
        follow_link.click();
      } else if (e.target.checked && follower_checkbox.checked) {
        mutual_follow_link.click();
      } else if (!e.target.checked && follower_checkbox.checked) {
        follower_link.click();
      } else {
        all_users_link.click();
      }
      });
  };

  if(follower_checkbox) {
    follower_checkbox.addEventListener('change', function(e) {
      if (e.target.checked && !follow_checkbox.checked) {
        follower_link.click();
      } else if (e.target.checked && follower_checkbox.checked) {
        mutual_follow_link.click();
      } else if (!e.target.checked && follow_checkbox.checked) {
        follow_link.click();
      } else {
        all_users_link.click();
      }
    });
  };

  var request_tab = document.getElementById('request_tab');
  var posts_tab = document.getElementById('posts_tab');
  var keep_tab = document.getElementById('keep_tab');

  request_tab.addEventListener('click', function () {
    console.log('clicked!');
  });

  posts_tab.addEventListener('click', function () {
    console.log('clicked!');
  });

  keep_tab.addEventListener('click', function () {
    console.log('clicked!');
  });

});
