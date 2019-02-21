import json
import re


def convert_table_to_dictionary(table):
    result = []
    header = table.headings
    for row_data in table:
        result.append(dict(zip(header, row_data)))

    for row_data in result:
        for key, value in row_data.items():
            if is_boolean(row_data[key]):
                row_data[key] = json.loads(value)
            elif is_integer(row_data[key]):
                row_data[key] = json.loads(value)
    return result


def is_boolean(value):
    if value == 'true' or value == 'false':
        return True
    else:
        return False


def is_integer(value):
    try:
        int(value)
        return True
    except ValueError:
        return False


def delete_item(context):
    item_list = context.request_api.execute_request('get', 'my/items')
    for item in item_list.json():
        delete_url = '/my/items/' + str(item['id'])
        context.request_api.execute_request('delete', delete_url)



def map_url(end_point, context):
    mapped_url = end_point
    if re.search(r'<.*>', end_point):
        if hasattr(context, 'item_response'):
            mapped_url = re.sub("<item_id>", str(context.workspace_response.json()["id"]), mapped_url)
    return mapped_url




def delete_workspace(context):
    workspace_list = context.request_api.execute_request('get', 'my/workspaces')
    for workspace in workspace_list.json():
        delete_url = '/my/workspaces/' + str(workspace['id'])
        context.request_api.execute_request('delete', delete_url)
