from functools import partial
import requests
import time

from msa.api.base_methods import register_base_methods
from msa.server import route_adapter
from msa.server.default_routes import register_default_routes
from msa.core.loader import load_builtin_modules, load_plugin_modules



class MsaApi(dict):
    def __init__(self, *args, **kwargs):
        super(MsaApi, self).__init__(*args, **kwargs)
        self.__dict__ = self


class MsaApiRestClient:

    def __init__(self, host="localhost", port=8080, script_mode=False):

        self.host = host
        self.port = port
        self.base_url = "http://{}:{}".format(self.host, self.port)

    def _wrap_api_call(self, func, endpoint, **kwargs):
        n = 0
        fail = 3
        while True:
            try:
                return func(self.base_url + endpoint,  **kwargs)
            except requests.exceptions.ConnectionError:
                n += 1

                if n == 1:
                    print("This is taking longer than expected, we seem to be having some connection troubles. Trying again.")
                elif n == 2:
                    print("Hmm, something must be up.")

            print("Unfortunately, I was unable to read the msa daemon instance at {}".format(self.base_url))
            print("Please check your connection and try again")
            return None

    def get(self, endpoint, **kwargs):
        return self._wrap_api_call(requests.get, endpoint, **kwargs)

    def post(self, endpoint, **kwargs):
        print(kwargs)
        return self._wrap_api_call(requests.post, endpoint, **kwargs)

    def put(self, endpoint, **kwargs):
        return self._wrap_api_call(requests.put, endpoint, **kwargs)
    
    def update(self, endpoint, **kwargs):
        return self._wrap_api_call(requests.update, endpoint, **kwargs)
    
    def delete(self, endpoint, **kwargs):
        return self._wrap_api_call(requests.delete, endpoint, **kwargs)


class MsaApiWrapper:
    def __init__(self, host="localhost", port=8080, script_mode=False, white_listed_plugins=[]):

        self.api = MsaApi()
        self.api.script_mode = script_mode
        self.api.rest_client = MsaApiRestClient()

        self._registration_frozen = False

        register_base_methods(self)

        to_be_registered = []
        for module in load_builtin_modules():
            if hasattr(module, "register_client_api") and callable(module.register_client_api):
                to_be_registered.append(module.register_client_api)

        for module in load_plugin_modules(white_listed_plugins):
            if hasattr(module, "register_client_api") and callable(module.register_client_api):
                to_be_registered.append(module.register_client_api)

        for method in to_be_registered:
            method(self)


        self._registration_frozen = True


    def register_method(self):
        if not self._registration_frozen:
            def decorator(func):
                self.api[func.__name__] = partial(func, self.api)
            return decorator
        else:
            raise Exception(f"MsaAPI Method Registration is frozen, failed to register method: {func.__name__}")

    def get_api(self):
        return self.api


class MsaServerApi(dict):
    def __init__(self, loop):
        super(MsaServerApi, self).__init__()
        self.__dict__ = self
        self.loop = loop

        self.route_adapter = route_adapter
        self.rest_client = self

    def _call_api_route(self, verb, route, payload=None):
        func = self.route_adapter.lookup_route(verb, route)
        if func is None:
            raise Exception(f"{self.__class__.__name__}: no api route {verb}:{route} exists.")

        if not callable(func):
            raise Exception(f"{self.__class__.__name__}: api route is not callable: {func}")

        if payload is not None:
            func(payload)
        else:
            func(None)

    def get(self, route):
        self._call_api_route("get", route)

    def post(self, route, data=None, json=None):
        self._call_api_route("post", route, payload=data or json)

    def put(self, route, data=None, json=None):
        self._call_api_route("put", route, payload=data or json)

    def delete(self, route, data=None, json=None):
        self._call_api_route("delete", route, payload=data or json)
        

class MsaLocalApiWrapper:
    def __init__(self, loop=None, white_listed_plugins=[]):
        self.loop = loop
        self.api = MsaServerApi(loop)

        MsaLocalApiWrapper.api = self.api

        self._registration_frozen = False
        register_base_methods(self)

        to_be_registered = []
        for module in load_builtin_modules():
            if hasattr(module, "register_client_api") and callable(module.register_client_api):
                to_be_registered.append(module.register_client_api)

        for module in load_plugin_modules(white_listed_plugins):
            if hasattr(module, "register_client_api") and callable(module.register_client_api):
                to_be_registered.append(module.register_client_api)

        for method in to_be_registered:
            method(self)

    def register_method(self):
        def decorator(func):
            if not self._registration_frozen:
                self.api[func.__name__] = partial(func, self.api)
            else:
                raise Exception(f"MsaServerAPI Method Registration is frozen, failed to register method: {func.__name__}")
        return decorator

    def freeze_registration(self):
        self._registration_frozen = True

    @classmethod
    def get_api(cls):
        return cls.api






