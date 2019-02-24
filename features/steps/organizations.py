from compare import expect
from json import loads
from requests import request

@given(u'I have an existing organization with parameters')
def step_impl(context):
    query = {
        'key':context.key,
        'token':context.token
    }

    for row in context.table:
        query[row[0]] = row[1]

    response = request('POST',context.url+'/organizations',params=query)
    body = loads(response.text)

    expect(response.status_code).to_equal(200)

    context.id = body['id']

