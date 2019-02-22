import requests
from utils import json_utils

class RequestApi:
    def __init__(self, token, url, username, password):
        self.token = token
        self.base_endpoint = url
        self.authorizarion = (username, password)
        self.headers = {'X-TrackerToken': token, 'Content-Type': 'application/json'}

    def execute_request(self, method, end_point, data=None):
        return requests.request(method, self.base_endpoint + end_point, headers=self.headers,
                                data=json_utils.dictionary_to_json(data))

