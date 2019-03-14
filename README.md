# http_client

## how to use
#### get_http
- $ ruby http_client_get.rb <uri> <thread_counts>'
#### post_http
1. post_dataにymlを作成
2. $ ruby http_client_post.rb <file_name>

### yml雛形
- uri: 'url'
- thread_counts: 10
- form_data:
  - name: 'hoge'
  - age: 30

