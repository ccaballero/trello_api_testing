import json

def dictionary_to_json(dictionary):
    if dictionary is not None:
        return json.dumps(dictionary)

