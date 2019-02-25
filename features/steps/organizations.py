from compare import expect
from json import loads
from re import match
from requests import request
from uuid import uuid4

@given(u'I have an existing organization with parameters')
def step_impl(context):
    query = {
        'key':context.key,
        'token':context.token
    }

    for row in context.table:
        if match('\{[A-Za-z0-9_\-]+\}',row[1]):
            if 'generated' not in context:
                context.generated = {}

            context.generated[row[1]] = 'o'+str(uuid4()).replace('-','')
            query[row[0]] = context.generated[row[1]]
        else:
            query[row[0]] = row[1]

    response = request('POST',context.url+'/organizations',params=query)
    print('==> query parameters:',query)

    expect(response.status_code).to_equal(200)

    body = loads(response.text)
    context.organization_id = body['id']

    if 'generated' not in context:
        context.generated = {}

    context.generated['{organization_id}'] = body['id']

