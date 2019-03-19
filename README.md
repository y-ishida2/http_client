# http_client

## how to use
1. request_dataにymlを作成
2. $ ruby http_client.rb <file_name>

### yml_template
- uri: 'url'
- thread_counts: 10
- type: get or post
- params:
  - name: 'hoge'
  - age: 30

### cautions
- paramsが不要な場合はymlに書かなくてよい

