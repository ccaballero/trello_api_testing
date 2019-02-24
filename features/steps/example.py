#   import json
#   from compare import expect
#   from utils.utils import map_url
#
#
#   @when(u'I send the {method} request to {end_point}')
#   def step_impl(context, method, end_point):
#       context.project_name = context.project_response.json()['name']
#       project_data = json.loads(context.text.replace(context.project_name, str(context.project_response.json()['id'])))
#       context.response = context.request_api.execute_request(method, map_url(end_point, context), data=project_data)
#
#
#   @then(u'the item created should contain the following data')
#   def step_impl(context):
#       data = json.loads(context.text)
#       expect(data['name']).to_equal(context.items_response.json()['name'])
#
#
#   @then(u'the item should contain the project created')
#   def step_impl(context):
#       expect(context.items_response.json()['project_ids']).to_contain(context.project_response.json()['id'])
